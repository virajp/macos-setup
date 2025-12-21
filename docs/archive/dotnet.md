# Microsoft .NET

Here's how to install .NET on macOS

## Install

```shell
brew install --cask dotnet-sdk
```

## Install .NET Aspire

> First update the workload list

```shell
sudo dotnet workload update
```

> Now, install Aspire

```shell
sudo dotnet workload install aspire
```

> Check the list of workloads installed

```shell
dotnet workload list
```

## Configuration

> Container Runtime
> Not required for Docker Desktop

```shell
export DOTNET_ASPIRE_CONTAINER_RUNTIME=podman
```
