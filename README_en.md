# Medusa Framwork for Windows(Docker)
- Reference : https://github.com/Ch0pin/medusa#using-docker
- Changes : 
  - Simply modify the Dockerfile and add installation steps for apktool and aapt(included in android-sdk-build-tools).
  - Change apt source file(tsinghua mirror source here).
  - Add proxy configuration when processing git clone.
- CRLF should be changed to LF in apktool Script