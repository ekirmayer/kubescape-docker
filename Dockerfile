FROM alpine:3.15.8 as builder

ARG version="v2.0.149"
RUN apk --no-cache add curl
RUN addgroup kubescape && adduser -D -G kubescape kubescape
USER kubescape
ENV BIN_DIR=/home/kubescape/bin
WORKDIR $BIN_DIR

ENV DOWNLOAD_URL="https://github.com/armosec/kubescape/releases/download/${version}/kubescape-ubuntu-latest"
ENV OUTPUT=$BIN_DIR/kubescape
RUN curl -L $DOWNLOAD_URL -o $OUTPUT
RUN chmod +x $BIN_DIR/kubescape

FROM alpine:3.15.8
RUN addgroup kubescape && adduser -D -G kubescape kubescape
USER kubescape
ENV KUBESCAPE_DIR=/home/kubescape
WORKDIR $KUBESCAPE_DIR/src
COPY --from=builder $KUBESCAPE_DIR/bin/kubescape $KUBESCAPE_DIR/bin/kubescape
ENTRYPOINT [ "/home/kubescape/bin/kubescape" ]
CMD [ "-h" ]