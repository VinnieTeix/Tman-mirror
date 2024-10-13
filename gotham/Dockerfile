FROM elixir:latest

RUN apt-get update && apt-get install -y build-essential wget

RUN wget https://github.com/erlang/rebar3/releases/download/3.19.0/rebar3 && \
    chmod +x rebar3 && \
    mv rebar3 /usr/local/bin/

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get

COPY . .

RUN mix compile

EXPOSE 4000

CMD ["mix", "phx.server"]
