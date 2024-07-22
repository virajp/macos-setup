# Microsoft .NET

Here's how to install .NET on macOS

## Install

```bash
brew install --cask dotnet-sdk
```

## Install .NET Aspire

> First update the workload list

```bash
sudo dotnet workload update
```

> Now, install Aspire

```bash
sudo dotnet workload install aspire
```

> Check the list of workloads installed

```bash
dotnet workload list
```

## Configuration

> Container Runtime
> Not required for Docker Desktop

```bash
export DOTNET_ASPIRE_CONTAINER_RUNTIME=podman
```
