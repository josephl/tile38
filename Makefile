GIT_SHORT = $(shell git rev-parse --short HEAD)

all: 
	@./build.sh
clean:
	rm -f tile38-server
	rm -f tile38-cli
test:
	@./build.sh test
install: all
	cp tile38-server /usr/local/bin
	cp tile38-cli /usr/local/bin
uninstall: 
	rm -f /usr/local/bin/tile38-server
	rm -f /usr/local/bin/tile38-cli
docker:
	docker build -t tile38:$(GIT_SHORT) .
	docker tag tile38:$(GIT_SHORT) tile38:latest
