TEST ?= background_task.tests

# Run containers as the host user so files written to the bind mount aren't root-owned
export HOST_UID := $(shell id -u)
export HOST_GID := $(shell id -g)

DC = docker-compose
RUN = $(DC) run --rm app

.PHONY: clean build start shell test test-async tox migrations format

clean:
	$(DC) down

build:
	$(DC) build

start:
	$(DC) up

shell:
	$(RUN) bash

# make test TEST=background_task.tests.test_tasks.TestTaskModel.test_lock_uncontested
test:
	$(RUN) python manage.py test $(TEST)

test-async:
	$(DC) run --rm -e DJANGO_SETTINGS_MODULE=background_task.tests.test_settings_async app python manage.py test $(TEST)

tox:
	$(RUN) tox

migrations:
	$(RUN) python manage.py makemigrations background_task

format:
	$(RUN) black .
