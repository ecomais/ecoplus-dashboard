![Grafana](https://img.shields.io/badge/Grafana-12.1-orange)
[![ECO+](https://img.shields.io/badge/ECO+-Website-green)](https://ecoautomacao.com.br/bu-softwares-servicos/)
![Docker Build](https://img.shields.io/badge/Docker-passing-blue)

# ECO+ Dashboard

## 🎯 Objective

The ECO+ Dashboard solution is a comprehensive monitoring and visualization platform designed to provide real-time data insights, alerting, and analytics tailored for the ECO+ ecosystem. It serves as a centralized interface to support operational decision-making and enhance visibility into key metrics.

## 🚀 Deployment

This solution can be deployed both locally for development and testing, and in the cloud for production use. Below are detailed instructions for each deployment scenario.

### 🖥️ Local Deployment

You can run the ECO+ Dashboard solution locally using Docker and Docker Compose. This is useful for development, testing, and debugging.

#### 📋 Prerequisites

- 🐳 Docker installed on your local machine.
- 🔐 Access to the project repository with the necessary environment configuration files (e.g., `.env`).

#### ⚙️ Steps

1. **Build the Docker Image** 🏗️

   Build the Docker image locally using the provided `Dockerfile`:

   ```bash
   docker build -t your-dockerhub-username/ecoplus-dashboard:latest .
   ```

2. **Run with Docker Compose** 🐙

   Use Docker Compose to start the solution locally:

   ```bash
   docker-compose up
   ```

   This command uses the `docker-compose.yml` file, which builds the image and sets environment variables from the `.env` file. The Grafana service will be available on port 3000.

3. **Access the Dashboard** 🌐

   Open your browser and navigate to `http://localhost:3000` to access the Grafana dashboard.

### ☁️ Cloud Deployment

For production or staging environments, deploy the ECO+ Dashboard solution to Azure Web App for Containers.

#### 📋 Prerequisites

- 🔧 Azure CLI installed and authenticated.
- 🔑 An Azure subscription with permissions to create resource groups and web apps.
- 🔐 Access to the project repository with the necessary environment configuration files (e.g., `.env`).

#### 🚀 Deployment Steps

Use the deployment script `scripts/deploy_azure_webapp.sh` to deploy the container image to Azure:

```bash
./scripts/deploy_azure_webapp.sh -g <resourceGroup> -n <appName> -i <containerImage> [-l <location>] [-t <tags>]
```

- `-g`: Azure Resource Group name (will be created if it does not exist).
- `-n`: Azure Web App name.
- `-i`: Container image name (e.g., `docker.io/ecomais/ecoplus-dashboard:latest`).
- `-l`: (Optional) Azure region/location (default is `eastus`).
- `-t`: (Optional) Tags to apply to the Azure resources.

The script will:

- Create the resource group if it does not exist.
- Create or update an App Service plan.
- Create or update the Azure Web App configured to use the specified container image.
- Set application settings based on environment variables converted from the `.env` file.
- Apply tags if provided.
- Restart the web app to apply changes.

#### 🛠️ Environment Configuration

- Environment variables are managed via the `.env` file in the project root.
- The deployment script uses a helper script `scripts/convert_env_az_to_azure_cli.sh` to convert `.env` variables into Azure CLI app settings.
- Ensure sensitive information such as database credentials and API keys are properly set in the `.env` file before deployment.

#### 🔌 Ports and Access

- The Grafana dashboard runs on port 3000 inside the container.
- When running locally, port 3000 is mapped to the host.
- On Azure, the web app will expose the service on the default HTTP/HTTPS ports.


## 📜 License

This project is licensed under the Apache License Version 2.0. For more details, see the [LICENSE](https://github.com/ecomais/ecoplus-dashboard/blob/main/LICENSE) file.
