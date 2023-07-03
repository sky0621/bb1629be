# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOTOOL=$(GOCMD) tool
GOGET=$(GOCMD) get
GOMOD=$(GOCMD) mod
GOINST=$(GOCMD) install

# Binary Name
BINARY_NAME=bb1629be

# Build
build:
	@$(GOBUILD) -o $(BINARY_NAME) .
	@echo "⭐️ Build Done ⭐️"

#Test
test:
	@$(GOTEST) -v ./...
	@echo "⭐️ Test Completed ⭐️"

# Run Server
server:build
	@echo "🚀 Running Server"
	@./$(BINARY_NAME) server

