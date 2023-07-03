# Frontend

## env

### Node.js

```
❯ node -v
v18.16.1
```

```
❯ npm -v 
9.7.2
```

## create project

```
❯ npx create-next-app@latest
✔ What is your project named? … frontend
✔ Would you like to use TypeScript with this project? … No / Yes
✔ Would you like to use ESLint with this project? … No / Yes
✔ Would you like to use Tailwind CSS with this project? … No / Yes
✔ Would you like to use `src/` directory with this project? … No / Yes
✔ Use App Router (recommended)? … No / Yes
✔ Would you like to customize the default import alias? … No / Yes
```

## Getting Started

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## build image

```
docker build -t nextjs-docker .
```

```
docker run -p 3000:3000 nextjs-docker
```
