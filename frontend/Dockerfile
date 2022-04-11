FROM node:13.12.0-alpine AS front
ENV NODE_ENV front
WORKDIR /frontend

COPY package.json package-lock.json yarn.lock ./
RUN yarn install
COPY . ./
EXPOSE 3000
CMD [ "yarn", "start" ]