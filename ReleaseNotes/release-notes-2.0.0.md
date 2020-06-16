# PLDroidMediaStreaming-ByteDance Release Notes for 2.0.0

### 简介
PLDroidMediaStreaming-ByteDance 是七牛推出的一款适用于 Android 平台的具有高级特效功能的推流 SDK，提供了包括高级美颜、高级滤镜、动态贴纸、水印、SEI 信息发送、录屏、纯音频推流在内的多种功能，支持高度定制以及二次开发。

### 版本
- 发布 pldroid-bytedance-effect-2.0.0.jar
- 发布字节资源 v3.9 处理脚本
- 发布 libc++_shared.so
- 升级 libeffect.so
- 升级 libeffect_proxy.so

### 功能
- 修复了美妆中口红特效出现在嘴唇遮挡物上的问题
- 优化了美体的边缘效果
- 优化了 YUV 处理速度

### 注意事项
* **pldroid-bytedance-effect-2.0.0.jar 较之前版本接口变动较大，升级请仔细阅读[文档](../docs/PLDroidMediaStreaming-ByteDance.md)与 demo。**
* **此版本仅支持字节跳动资源版本 v3.9.0，如版本不匹配请重新申请资源。**
* 建议推流 SDK 选用 v2.4.1.1 及以上的版本
