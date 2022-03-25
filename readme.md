# KubeScape Docker

This project is a simple packaging of the KubeScape cli


## How to build

```shell
export KUBESCAPE_TAG=v2.0.149
docker buildx build \
--push --build-arg version=$KUBESCAPE_TAG \
--platform linux/arm/v7,linux/arm64/v8,linux/amd64,linux/386 \
--tag ekirmayer/kubescape:$KUBESCAPE_TAG \
--tag ekirmayer/kubescape:latest .
```

## How to run

### Simple scan

```shell
docker run -it --rm -v $(pwd):/home/kubescape/src  docker.io/library/kubetest scan *.yaml
```

### With cache directory

```shell
docker run -it --rm -v $(pwd):/home/kubescape/src -v $(pwd)/.kubescape:/home/kubescape/.kubescape docker.io/library/kubetest scan *.yaml
```
