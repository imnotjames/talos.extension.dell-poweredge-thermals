FROM ghcr.io/imnotjames/dell-poweredge-thermals:v0.0.2 AS artifact

FROM scratch AS extension

COPY dell-poweredge-thermals.yaml /rootfs/usr/local/etc/containers/
COPY manifest.yaml /

COPY --from=artifact /dell-poweredge-fan-control /rootfs/usr/local/lib/containers/dell-poweredge-thermals/dell-poweredge-thermals

ENTRYPOINT ["./dell-poweredge-thermals"]
