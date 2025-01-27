# Multi stage build Dockerfile

# There's no point in using the edge (development branch of alpine)
FROM alpine:3.17 AS build
# folder structure
WORKDIR /usr/src/yt-dlp-webui
# install core dependencies
RUN apk update && \
    apk add nodejs npm go
# copia la salsa
COPY . .
# build frontend
WORKDIR /usr/src/yt-dlp-webui/frontend
RUN npm install
RUN npm run build
# build backend + incubator
WORKDIR /usr/src/yt-dlp-webui
RUN go build -o yt-dlp-webui

# but here yes :)
FROM alpine:edge

WORKDIR /downloads
VOLUME /downloads

WORKDIR /app

RUN apk update && \
    apk add psmisc ffmpeg yt-dlp

COPY --from=build /usr/src/yt-dlp-webui /app
RUN chmod +x /app/yt-dlp-webui

EXPOSE 3033
CMD [ "./yt-dlp-webui" , "--out", "/downloads" ]
