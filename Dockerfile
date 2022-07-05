# syntaxdocker/dockerfile-upstream:master-experimental
FROM alpine:3.15 AS builder
RUN apk upgrade
RUN apk update && apk add --no-cache \
    && apk add --no-cache bash git grep coreutils \
    && rm -rf /var/cache/*/* \
    && echo "" > /root/.ash_history;

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
ENV LC_ALL=en_US.UTF-8

RUN addgroup -g 10001 -S nonroot && adduser -u 10000 -S -G nonroot -h /home/nonroot nonroot

WORKDIR /root
ENV ACTIONS_RUNNER_DEBUG=true

ADD https://github.com/numtide/treefmt/releases/download/v0.4.1/treefmt-x86_64-unknown-linux-musl.tar.gz
RUN mv treefmt /usr/local/bin

COPY --chmod=0744 ["entrypoint.sh", "/usr/local/bin"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

FROM alpine:3.15
ENV ACTIONS_RUNNER_DEBUG=true
COPY --from=builder /usr/local/bin/* /bin/
CMD ["/bin/treefmt", "-"]
