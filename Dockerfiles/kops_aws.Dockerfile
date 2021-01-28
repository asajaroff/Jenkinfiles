FROM debian:stretch-slim

ENV KOPS_VERSION=v1.17.2
ENV KUBECTL_VERSION=v1.20.1

RUN apt update && apt upgrade -y \
  && apt install -y curl

WORKDIR /home/kops

RUN curl -L https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 -O \
  && mv kops-linux-amd64 /usr/local/bin/kops \
  && curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl -O \
  && mv kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kops /usr/local/bin/kubectl

RUN apt install -y unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install

ENTRYPOINT ["/usr/local/bin/kops"]
CMD ["--help"]