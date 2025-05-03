#!/bin/bash
docker compose build
docker run --rm -ti -p 21025:21025 --mount type=bind,src=./assets/packed.pak,dst=/starbound/assets/packed.pak  openstarbound:latest $@