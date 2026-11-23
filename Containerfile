ARG UCORE_TAG=stable

FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

FROM ghcr.io/ublue-os/ucore-hci:${UCORE_TAG}

COPY cosign.pub /etc/pki/containers/cosign.pub

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

RUN bootc container lint
