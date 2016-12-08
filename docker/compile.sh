#!/bin/sh

cd ${WORK_PATH}
mix local.hex --force
mix local.rebar --force
mix deps.get
MIX_ENV=prod mix compile

SECRET=$(MIX_ENV=prod mix phoenix.gen.secret)
sed -rie 's,(secret_key_base: ").*("),\1'$SECRET'\2,' config/prod.secret.exs

MIX_ENV=prod mix phoenix.digest
MIX_ENV=prod mix release --env=prod
find rel/${APP}/releases/  -regex ".*[0-9]\+\.[0-9]\+\.[0-9]\+/${APP}\.tar\.gz" -type f -exec mv {} /build/ \;
