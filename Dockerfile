FROM ubuntu:24.04

COPY --from=denoland/deno:bin-2.5.6 /deno /usr/local/bin/deno

# Add project source
WORKDIR /musicbot
COPY . ./
COPY ./config sample_config

RUN apt-get update
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

RUN apt-get install software-properties-common python3-pip git ffmpeg -y

RUN pip install --no-cache-dir -r requirements.txt --break-system-packages

# Create volumes for audio cache, config, data and logs
VOLUME ["/musicbot/audio_cache", "/musicbot/config", "/musicbot/data", "/musicbot/logs"]

ENV APP_ENV=docker

ENTRYPOINT ["/bin/sh", "docker-entrypoint.sh"]
