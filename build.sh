#!/bin/bash
echo "开始构建清单"
docker manifest create trifolium0/openj9-jdk17-wkhtmltox:latest trifolium0/openj9-jdk17-wkhtmltox:1.0.1-amd64 trifolium0/openj9-jdk17-wkhtmltox:1.0.1-arm64