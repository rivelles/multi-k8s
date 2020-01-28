FROM node:alpine as builder
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html

# Cria uma imagem a partir da imagem-base node:alpine, roda o comando npm install e joga o conteúdo da pasta 'build' no diretório do nginx