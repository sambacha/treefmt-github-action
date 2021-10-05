RUN curl --retry 5 --retry-delay 5 -sLO https://raw.githubusercontent.com/rhysd/actionlint/main/scripts/download-actionlint.bash \
    && chmod +x download-actionlint.bash \
    && ./download-actionlint.bash \
    && rm download-actionlint.bash \
    && mv actionlint /usr/bin/actionlint \