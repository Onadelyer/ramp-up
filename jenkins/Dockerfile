FROM jenkins/jenkins:lts

# Switch to root user to install Terraform and AWS CLI
USER root

# Install dependencies, including awscli
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    groff \
    less \
    python3 \
    python3-pip \
    awscli

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

# Switch back to the jenkins user
USER jenkins

# Expose Jenkins port
EXPOSE 8080

# Expose the Jenkins agent port
EXPOSE 50000
