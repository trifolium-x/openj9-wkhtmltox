## amd64
## FROM --platform=linux/amd64 ibm-semeru-runtimes:open-8u412-b08-jre-jammy as build_base_image_amd64
FROM --platform=linux/amd64 ibm-semeru-runtimes:open-17.0.10_7-jre-jammy as build_base_image_amd64
LABEL app="trifolium0/openj9-jdk17-wkhtmltox-amd64" version="1.0.1-amd64" by="trifolium.wang"
MAINTAINER trifolium <trifolium.wang@gmail.com>

RUN mkdir /wkhtmltox

COPY lib/simsun.ttc /usr/share/fonts/simsun.ttc
COPY lib/wkhtmltox_0.12.6.1-2.jammy_amd64.deb /wkhtmltox/lib/wkhtmltox.deb

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y libjpeg-turbo8 libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
    && dpkg -i /wkhtmltox/lib/wkhtmltox.deb \
    && rm -r /wkhtmltox/lib

CMD wkhtmltopdf -V


## arm64
## FROM --platform=linux/arm64 ibm-semeru-runtimes:open-8u412-b08-jre-jammy as build_base_image_arm64
FROM --platform=linux/arm64 ibm-semeru-runtimes:open-17.0.10_7-jre-jammy as build_base_image_arm64
LABEL app="trifolium0/openj9-jdk17-wkhtmltox-arm64" version="1.0.1-arm64" by="trifolium.wang"
MAINTAINER trifolium <trifolium.wang@gmail.com>

RUN mkdir /wkhtmltox

COPY lib/simsun.ttc /usr/share/fonts/simsun.ttc
COPY lib/wkhtmltox_0.12.6.1-2.jammy_arm64.deb /wkhtmltox/lib/wkhtmltox.deb

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y libjpeg-turbo8 libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
    && dpkg -i /wkhtmltox/lib/wkhtmltox.deb \
    && rm -r /wkhtmltox/lib

CMD wkhtmltopdf -V