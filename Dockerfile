ARG BUILDPLATFORM

FROM --platform=${BUILDPLATFORM} golang:1.27.3-alpine@sha256:d200d2dd76b03a99b52651fd1325aff7dcd35422c35c01bac56571b0507f3deb AS build

WORKDIR "/build/"

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

# To improve layer caching
COPY go.mod go.sum ./
RUN go mod download

COPY . .

ARG GIT_DESCRIBE

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} GOARM=${TARGETVARIANT#v} \
    go build -tags "timetzdata" -trimpath -ldflags="-w -s" \
    -o /app/server .

FROM scratch AS minimal
COPY --from=build /app/server /bin/
EXPOSE 8000
VOLUME /public
ENTRYPOINT ["/bin/server"]
