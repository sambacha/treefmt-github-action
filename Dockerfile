# syntaxdocker/dockerfile-upstream:master-experimental
#// syntax=docker/dockerfile:1
FROM alpine:3.14 AS builder

RUN apk update && apk upgrade \
    && apk add --no-cache bash git grep coreutils \
    && rm -rf /var/cache/*/* \
    && echo "" > /root/.ash_history

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
ENV LC_ALL=en_US.UTF-8
WORKDIR /root
ENV ACTIONS_RUNNER_DEBUG=true

COPY --chmod=0744 ["treefmt", "diff.sh", "entrypoint.sh", "/usr/local/bin"]
#COPY treefmt /usr/local/bin
#COPY diff.sh  /usr/local/bin
#COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]

FROM alpine:3.14
ENV ACTIONS_RUNNER_DEBUG=true
COPY --from=builder /usr/local/bin/* /bin/
CMD ["/bin/treefmt", "-"]
