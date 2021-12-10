FROM node:alpine as builder
WORKDIR '/app'
ENV PATH /app/node_modules/.bin:$PATH

COPY ./.npmrc .
COPY ./package.json .

RUN npm install
RUN rm -f .npmrc

COPY . .

RUN npm run build



FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html