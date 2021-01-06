FROM gcr.io/cloud-builders/gcloud-slim

ARG TERRAFORM_DOCS_VERSION=0.9.1

ENV ENV_TERRAFORM_DOCS_VERSION=$TERRAFORM_DOCS_VERSION

RUN apt-get update && \
   /builder/google-cloud-sdk/bin/gcloud -q components install alpha beta && \
    apt-get -y install curl wget jq unzip ca-certificates gawk git && \
    git clone https://github.com/cunymatthieu/tgenv.git /builder/tgenv && \
    git clone https://github.com/tfutils/tfenv.git /builder/tfenv && \
    curl -Lo ./terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${ENV_TERRAFORM_DOCS_VERSION}/terraform-docs-v${ENV_TERRAFORM_DOCS_VERSION}-$(uname | tr '[:upper:]' '[:lower:]')-amd64 && \
    chmod +x ./terraform-docs && \
    mkdir -p /builder/terraform-docs && \
    mv terraform-docs /builder/terraform-docs/ && \
    export PATH="/builder/tfenv/bin:$PATH" && \
    export PATH="/builder/tgenv/bin:$PATH" && \
    tfenv install && \
    tgenv install latest && \
    export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache/" && \
    apt-get --purge -y autoremove

ENV PATH=/builder/tgenv/bin:$PATH
ENV PATH=/builder/tfenv/bin:$PATH
COPY entrypoint.bash /builder/entrypoint.bash
RUN chmod +x /builder/entrypoint.bash
ENTRYPOINT ["/builder/entrypoint.bash"]
