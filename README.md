# test-image

A minimal container image to verify Kubernetes `imagePullPolicy: Always` behavior.

The image prints a build-time value and then sleeps indefinitely, making it easy to confirm which image version actually ran.

## Build

```bash
# Replace MY_VALUE with something unique (e.g., a timestamp or Git SHA)
docker build --build-arg BUILD_VALUE="MY_VALUE" -t myrepo/test-image:latest .
```

## Run Locally

```bash
docker run --rm myrepo/test-image:latest
```
You should see `MY_VALUE` printed once, after which the container will keep running.

## Deploy to Kubernetes

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-image
spec:
  containers:
  - name: test-image
    image: myrepo/test-image:latest
    imagePullPolicy: Always  # Ensure the image is always pulled
```

Update `MY_VALUE` and rebuild / push to verify that new pods pick up the latest image. 