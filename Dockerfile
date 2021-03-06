FROM ruby:2.7.0-alpine3.11

RUN apk update
RUN apk add --no-cache build-base tzdata postgresql-dev postgresql-client git

ENV APP_PATH /usr/src/app

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock $APP_PATH/

RUN bundle check || bundle install

COPY . $APP_PATH

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
