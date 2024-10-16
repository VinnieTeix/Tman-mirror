FROM elixir:latest

RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app
WORKDIR /app

ENV MIX_ENV=prod

RUN mix local.hex --force &&\
    mix local.rebar --force

RUN mix deps.get

CMD ["./entrypoint.sh"]