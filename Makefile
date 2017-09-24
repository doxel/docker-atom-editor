all: docker-atom

docker-atom:
	docker build . -t atom
