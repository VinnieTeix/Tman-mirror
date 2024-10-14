#!/bin/bash

if [ "$( psql -XtAc "SELECT 1 FROM pg_database WHERE datname='api'" )" = '1' ]
then
    echo "Database already exists."
else
    mix ecto.migrate
fi

mix phx.server
