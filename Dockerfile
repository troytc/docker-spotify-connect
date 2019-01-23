FROM debian:stable

RUN apt-get update \
  && apt-get -y install build-essential curl portaudio19-dev unzip \
  
  && curl https://sh.rustup.rs -sSf | sh -s -- -y \
  && source $HOME/.cargo/env \
  && cd /root \
  && curl -LO https://github.com/librespot-org/librespot/archive/master.zip \
  && unzip master.zip \
  && cd librespot-master \
  && cargo build --release --features pulseaudio-backend

ENV SPOTIFY_NAME Docker
ENV SPOTIFY_USER user@example.com
ENV SPOTIFY_PASS password

CMD /root/librespot-master/target/release/librespot --backend pulseaudio -n "$SPOTIFY_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASS"
