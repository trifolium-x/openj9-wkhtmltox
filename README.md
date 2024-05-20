# openJ9-wkhtmltox
Based on semeru-runtimes(openJ9)-jre &amp; wkhtmltox image for built html to pdf java environment.

#### docker hub
[https://hub.docker.com/r/trifolium0/openj9-jdk17-wkhtmltox](https://hub.docker.com/r/trifolium0/openj9-jdk17-wkhtmltox)</br>

Based on openJ9-jre17(semeru-runtimes) & wkhtmltox image for built html to pdf java environment.<br/>
use the image to build your own html to pdf (image) java service.<br/>
### openJ9
* Optimized to run Java™ applications cost-effectively in the cloud, Eclipse OpenJ9™ is a fast and efficient JVM that delivers power and performance when you need it most.
* Optimized for the Cloud, for microservices and monoliths too!
* Faster Startup
* Faster Ramp-up, when deployed to cloud
* Smaller
### wkhtmltox
* wkhtmltopdf and wkhtmltoimage are open source (LGPLv3) command line tools to render HTML into PDF and various image formats using the Qt WebKit rendering engine. These run entirely "headless" and do not require a display or display service.

### usage sample
1. ```docker pull trifolium0/openj9-jdk17-wkhtmltox:latest```
2. edit Dockerfile
  ```
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
```
### java wkhtmltopdf dependency
```
<dependency>
    <groupId>com.github.jhonnymertz</groupId>
    <artifactId>java-wkhtmltopdf-wrapper</artifactId>
    <version>1.3.0-RELEASE</version>
</dependency>
```
```
private String generatePDFFile(String html) throws Exception {

        Pdf pdf = new Pdf(new WrapperConfig(executable));
        pdf.setTimeout(30);
        pdf.addParam(new Param("--enable-javascript"));
        Page page = pdf.addPageFromString(html);
        //TODO 设置page参数

        String pdfPath = "pdf/test.pdf";
        pdf.saveAs(pdfPath);

        return pdfPath;
    }
```
