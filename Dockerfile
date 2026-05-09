FROM debian:13.4-slim AS opensb

# install unzip
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

ARG OPENSB_VERSION=0.1.14
WORKDIR /scratch
ADD https://github.com/OpenStarbound/OpenStarbound/releases/download/v${OPENSB_VERSION}/OpenStarbound-Linux-Clang-Server.zip /scratch/opensb.zip
RUN unzip opensb.zip 
RUN tar -xvf server.tar

FROM debian:13.4-slim AS runtime

WORKDIR /starbound

# Install dependencies

# get the opensb image
COPY --from=opensb /scratch/server_distribution/ /starbound/
COPY entrypoint.sh /starbound/entrypoint.sh
RUN chmod +x /starbound/entrypoint.sh && \
    groupadd -r starbound && useradd -r -g starbound starbound && \
    chown -R starbound:starbound /starbound
USER starbound

CMD ["/starbound/entrypoint.sh"]