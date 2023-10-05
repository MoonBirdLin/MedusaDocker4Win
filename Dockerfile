FROM python:3
# 换源
# RUN touch /etc/apt/sources.list
# RUN sed -i "s@http://deb.debian.org@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && rm -Rf /var/lib/apt/lists/*
COPY ./sources.list /etc/apt/
RUN apt-get clean
# apt 更新 + 安装adb, aapt, git等依赖工具
RUN apt-get update --fix-missing && apt-get -y upgrade --fix-missing && apt-get install --fix-missing -y android-tools-adb git android-sdk-build-tools
RUN apt-get update && apt-get -y upgrade && apt-get install -y android-tools-adb git android-sdk-build-tools
# 安装apktool, 这里原本应该是wget下来, 但是网络总是不稳定, 采用本地copy
# RUN wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -o /usr/local/bin/apktool
COPY ./apktool /usr/local/bin/
# RUN wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.8.1.jar -o /usr/local/bin/apktool.jar
COPY ./apktool.jar /usr/local/bin/
RUN chmod +x /usr/local/bin/apktool
RUN chmod +x /usr/local/bin/apktool.jar
# 安装medusa
## 后面是设置代理, xxx.xxx.xxx.2是docker子网中主机的地址(子网号是自己配置的), 1080是自己的代理的端口
## 关闭ssl验证防止代理出现莫名其妙的证书问题
RUN git clone https://github.com/ch0pin/medusa --config "http.proxy=http://192.168.65.2:1080" --config "http.sslverify=false"
# RUN git clone https://github.com/ch0pin/medusa
RUN pip install --upgrade pip
RUN cd /medusa && pip install -r requirements.txt --upgrade
RUN export PATH="$PATH:/usr/local/bin"
CMD ["/bin/bash"]