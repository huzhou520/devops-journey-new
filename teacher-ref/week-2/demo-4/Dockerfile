FROM alpine As kubectl
ENV KUBECTL_VERSION=1.22.0
WORKDIR /output
RUN apk add curl
RUN curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN chmod +x kubectl

FROM alpine As terraform
ENV TERRAFORM_VERSION=1.5.5
WORKDIR /output
RUN apk add curl zip
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64

FROM alpine
COPY --from=kubectl /output/kubectl /usr/local/bin/
COPY --from=terraform /output/terraform /usr/local/bin/