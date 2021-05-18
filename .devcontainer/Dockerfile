# [Choice] .NET version: 5.0, 3.1, 2.1
FROM mcr.microsoft.com/vscode/devcontainers/dotnetcore:0-5.0

RUN apt-get update && apt-get -y install --no-install-recommends apt-transport-https curl ca-certificates lsb-release gnupg2

# Install the Azure CLI
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list \
    && curl -sL https://packages.microsoft.com/keys/microsoft.asc | (OUT=$(apt-key add - 2>&1) || echo $OUT) \
    && apt-get update \
    && apt-get install -y azure-cli

RUN az bicep install
