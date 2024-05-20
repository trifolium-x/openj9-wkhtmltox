## 构建jdk基础镜像
FROM ibm-semeru-runtimes:open-17.0.10_7-jre-jammy as build_base_image
LABEL app="trifolium0/openj9-jdk17-wkhtmltox" version="1.0" by="trifolium.wang"
MAINTAINER trifolium <trifolium.wang@gmail.com>

RUN mkdir /wkhtmltox

COPY docker/lib/simsun.ttc /usr/share/fonts/simsun.ttc
COPY docker/lib/wkhtmltox_0.12.6.1-2.jammy_amd64.deb /wkhtmltox/lib/wkhtmltox.deb

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y libjpeg-turbo8 libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base \
    && dpkg -i /wkhtmltox/lib/wkhtmltox.deb \
    && rm -r /wkhtmltox/lib

CMD wkhtmltopdf -V


## 构建app镜像
FROM trifolium0/openj9-jdk17-wkhtmltox:latest as build_app_image
LABEL app="test-htmltopdf" version="1.0.0" by="trifolium.wang"
MAINTAINER trifolium <trifolium.wang@gmail.com>

ENV APP_VERSION 1.0.0

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \
&& rm -rf /app \
&& mkdir /app

WORKDIR /app

COPY target/test-htmltopdf.jar /app/app.jar

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:InitialRAMPercentage=70.0", \
"-XX:MaxRAMPercentage=70.0", "-jar", "app.jar"]

EXPOSE 8080
