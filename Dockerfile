FROM mhart/alpine-node:16 as build

WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml ./

RUN pnpm install

COPY . .

RUN pnpm build

FROM mhart/alpine-node:slim-16

COPY --from=build . .

WORKDIR /app

EXPOSE 8000

CMD ["node", "--es-module-specifier-resolution=node", "build/server.js"]