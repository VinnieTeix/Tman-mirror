FROM elixir:latest

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix deps.get

RUN mix do compile

RUN chmod +x /app/migrate.sh

CMD [ "/app/migrate.sh" ]