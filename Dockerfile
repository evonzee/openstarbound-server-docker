FROM debian:12.10 AS opensb

# install unzip
RUN apt-get update && apt-get install -y unzip

ARG OPENSB_VERSION=0.1.9
WORKDIR /scratch
ADD https://github.com/OpenStarbound/OpenStarbound/releases/download/v${OPENSB_VERSION}/OpenStarbound-Linux-Server.zip /scratch/opensb.zip
RUN unzip opensb.zip 
RUN tar -xvf server.tar

FROM debian:12.10 AS runtime

WORKDIR /starbound

# Install dependencies

ARG OPENSB_VERSION=0.1.8

# get the opensb image
COPY --from=opensb /scratch/server_distribution/ /starbound/
COPY entrypoint.sh /starbound/entrypoint.sh
RUN chmod +x /starbound/entrypoint.sh
# Install dependencies


CMD ["/starbound/entrypoint.sh"]