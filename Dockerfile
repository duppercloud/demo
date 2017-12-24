FROM node:9

COPY ./package.json /

RUN npm install

COPY ./app.js /
CMD ["node","app.js"]

