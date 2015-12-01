FROM node:5
MAINTAINER Octoblu <docker@octoblu.com>

EXPOSE 80

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install --production
COPY . /usr/src/app

RUN ["./node_modules/.bin/bower", "install", "--allow-root"]
CMD ["./node_modules/.bin/gulp", "webserver"]
