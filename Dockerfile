FROM debian:jessie

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential coreutils git curl && \
    rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.6
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 5470eac05d273c74ff8bac7bef5bad0b5abbd1c4052efbdbc8db45332e836b0b

RUN curl -kfsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz

ENV PATH /usr/local/go/bin:$PATH

ADD . /src
WORKDIR /src

RUN make && mv tile38-* /usr/local/bin

CMD tile38-server
