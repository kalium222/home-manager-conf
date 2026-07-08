# try the home-manager in this container
FROM debian:stable

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    sudo less curl xz-utils git vim \
    && apt-get clean autoclean \
    && useradd Kalium --create-home \
    && echo "Kalium ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER Kalium
ENV USER "Kalium"
ENV LANG "C.utf8"
WORKDIR /home/Kalium
RUN mkdir -p /home/Kalium/.config/nix \
    && echo "experimental-features = nix-command flakes\nuse-xdg-base-directories = true" > /home/Kalium/.config/nix/nix.conf \
    && curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --no-daemon \
    && sed -i '$s|.nix-profile|.local/state/nix/profile|g' /home/Kalium/.profile \
    && mkdir -p /home/Kalium/.config/home-manager
CMD ["bash", "--login"]
