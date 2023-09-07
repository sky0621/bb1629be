# LB用のIP予約
resource "google_compute_global_address" "default" {
  name = "${var.project_id}-lb-address"
}

# Architecture
# https://cloud.google.com/load-balancing/docs/https/setup-global-ext-https-serverless?hl=ja#creating_the_load_balancer
# 参考
# https://cloud.google.com/blog/ja/products/serverless/serverless-load-balancing-terraform-hard-way

# Cloud Run にリクエストを飛ばすためのネットワークエンドポイントグループ(Serverless NEG)
resource "google_compute_region_network_endpoint_group" "default" {
  name                  = "neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = var.cloud_run_instance_name
  }
}

# NEGにリクエストを飛ばすためのLBのバックエンドサービス
resource "google_compute_backend_service" "default" {
  name        = "lb-backend"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.default.id
  }
}

# URLマッピング
resource "google_compute_url_map" "default" {
  name = "url-map"

  default_service = google_compute_backend_service.default.id
}

# SSL証明書の更新でエラーが出ないようにするWork Around
# https://github.com/hashicorp/terraform-provider-google/issues/5356
resource "random_id" "cert" {
  byte_length = 4
  prefix      = "${var.project_id}-cert-"

  keepers = {
    domains = join(",", var.domains)
  }
}

# LB用のマネージドSSL証明書
resource "google_compute_managed_ssl_certificate" "default" {
  name = "lb-cert-${random_id.cert.hex}"

  lifecycle {
    create_before_destroy = true
  }

  managed {
    domains = var.domains
  }
}

# SSLポリシー
resource "google_compute_ssl_policy" "default" {
  name            = "${var.project_id}-ssl-policy"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

# HTTPプロキシ
resource "google_compute_target_https_proxy" "default" {
  name    = "https-proxy"
  url_map = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default.id
  ]
  ssl_policy = google_compute_ssl_policy.default.id
}

# 転送ルール
resource "google_compute_global_forwarding_rule" "default" {
  name        = "front"
  target      = google_compute_target_https_proxy.default.id
  ip_address  = google_compute_global_address.default.address
  ip_protocol = "TCP"
  port_range  = "443"
}

# 以降は、http アクセスを https に転送する設定

resource "google_compute_url_map" "https_redirect" {
  name = "${var.project_id}-https-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "https_redirect" {
  name    = "${var.project_id}-http-proxy"
  url_map = google_compute_url_map.https_redirect.id
}

resource "google_compute_global_forwarding_rule" "https_redirect" {
  name = "${var.project_id}-lb-http"

  target     = google_compute_target_http_proxy.https_redirect.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}
