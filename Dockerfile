FROM ruby:2.5.0-stretch
MAINTAINER Daniel Silva <silva20102@gmail.com>

RUN mkdir -p /service
WORKDIR /service

COPY ./ /service
RUN cd /service; bundler install

EXPOSE 80

ENV MENSAGEM_MD5=teste

ENV AUTH_SERVICE_METRICS_KEY=teste

CMD ["sh", "-c", "cd /service && ruby api/api.rb -p 80"]