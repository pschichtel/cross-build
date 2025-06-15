ARG OSXCROSS_VERSION=edge
FROM --platform=$BUILDPLATFORM ghcr.io/crazy-max/osxcross:${OSXCROSS_VERSION}-debian AS osxcross

FROM docker.io/library/debian:bookworm

RUN apt update \
 && apt full-upgrade \
 && apt install -y python3 python3-pip cmake make

RUN pip install --break-system-packages conan

RUN apt install -y clang lld libc6-dev

ARG CROSS_TRIPLE

ENV OSXCROSS_TARGET_DIR="/osxcross" \
    OSXCROSS_HOST="${CROSS_TRIPLE}23.6"

COPY --from=osxcross /osxcross/ "${OSXCROSS_TARGET_DIR}/"
COPY entrypoint.sh /entrypoint.sh
COPY "conan-profiles/${OSXCROSS_HOST}.ini" /conan-profile.ini

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]

