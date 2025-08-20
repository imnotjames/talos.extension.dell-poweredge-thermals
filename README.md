# Talos Extension for Dell Poweredge Thermal Management


## Build an Installer

```bash
export IMAGE_EXT="ghcr.io/imnotjames/talos.extension.dell-poweredge-thermals"
export IMAGE_INSTALLER="ghcr.io/imnotjames/talos.extension.dell-poweredge-thermals/installer"
export TALOS_VERSION="1.10"
export ARCH="amd64"

# Build the installer image
docker run \
    --rm \
    -t \
    --privileged \
    -v /dev:/dev \
    -v "$(pwd)/_out:/out" \
    "ghcr.io/siderolabs/imager:${TALOS_VERSION}" \
    --arch "${ARCH}" \
    --system-extension-image ${IMAGE_EXT}:main \
    installer

# Load the image into the local Docker daemon
docker load -i ./_out/installer-amd64.tar

# Re-tag the image for your registry
docker tag \
    ghcr.io/siderolabs/installer:${TALOS_VERSION} \
    ${IMAGE_INSTALLER}:${TALOS_VERSION}


# Push the image to your registry
docker push ${IMAGE_INSTALLER}:${TALOS_VERSION}

# Upgrade your cluster
talosctl upgrade -n 192.168.1.100 -i ${IMAGE_INSTALLER}:${TALOS_VERSION}
```