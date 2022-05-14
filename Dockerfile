FROM alpine

ENV LANG C.UTF-8

# Install dependencies
RUN apk add --no-cache \
    bash \
    ffmpeg \
    nginx \
    nginx-mod-rtmp \
    python3 \
    py-pip

# Install python dependencies
RUN pip install -r /Controller/requirements.txt

# Nginx setup
COPY nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /tmp/streaming/thumbnails
RUN mkdir /tmp/streaming/hls

# Copy data for add-on
COPY run.sh /
COPY Controller /Controller
COPY data /data
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
