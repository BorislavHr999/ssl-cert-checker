FROM debian:stable-slim
LABEL maintainer="Borislav Hristov/BHristov999"
RUN apt-get update && apt-get install -y \
    bash \
    openssl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/bin
COPY  check_ssl.sh .
RUN chmod +x check_ssl.sh
ENTRYPOINT [ "./check_ssl.sh" ]