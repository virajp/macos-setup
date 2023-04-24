# Install Colima & MiniKube

```bash
# Install alternate to Docker-Desktop (colima)
brew install --formulae docker docker-buildx docker-scan kubectl colima minikube

# First setup colima
colima start --arch "x86_64" --cpu 4 --memory 8 --disk 72 --mount "~/Projects:w" --mount-type "9p"

# Second setup minikube
minikube start --cpus="max" --driver=docker
```
