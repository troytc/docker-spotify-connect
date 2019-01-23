FROM debian:stable

RUN apt-get -y install \
  build-essential \
  portaudio19-dev \
  
  && curl https://sh.rustup.rs -sSf | sh -s -- -y \
  && cd /root \
  && curl -LO https://github.com/librespot-org/librespot/archive/master.zip \
  && unzip master.zip \
  && cd librespot-master \
  && cargo build --release --features pulseaudio-backend

ENV SPOTIFY_NAME Docker
ENV SPOTIFY_USER
ENV SPOTIFY_PASS

CMD /root/librespot-master/target/release/librespot --backend pulseaudio -n "$SPOTIFY_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASS"
