TEST?=tasks

clean:
	docker-compose down

build:
	docker-compose build

start:
	docker-compose up



