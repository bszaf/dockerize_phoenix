.PHONY: compile builder docker_release docker_image clean

BUILDER_NAME := elixir_builder
BUILDER_VERSION := 0.1
APP_NAME := web
APP_VER := $(shell sed -n -e 's/^.*version.*"\(.*\)".*/\1/p' mix.exs)

deps:
	mix deps.get

compile: deps
	mix compile

builder: clean_image
	docker build --force-rm -t $(BUILDER_NAME):latest -f Dockerfile.builder .

docker_release:
	docker create -v $(PWD)/docker:/build --name $(BUILDER_NAME) $(BUILDER_NAME)
	docker cp . $(BUILDER_NAME):/work/$(APP_NAME)_src
	docker start -ai $(BUILDER_NAME)
	docker rm $(BUILDER_NAME)

docker_image:
	docker build --force-rm -t $(APP_NAME):$(APP_VER) -t $(APP_NAME):latest -f Dockerfile.web .

docker_start:
	docker run -ti --rm --name web -p 80:80 $(APP_NAME):latest

clean_image:
	docker rmi $(BUILDER_NAME):latest || true

clean:
	mix clean
	docker rmi $(BUILDER_NAME):latest $(APP_NAME):latest
