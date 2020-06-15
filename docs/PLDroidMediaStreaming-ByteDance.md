# 1. 概述
PLDroidMediaStreaming-ByteDance 是七牛推出的一款适用于 Android 平台的具有高级特效功能的推流 SDK，提供了包括高级美颜、高级滤镜、动态贴纸、水印、SEI 信息发送、录屏、纯音频推流在内的多种功能，支持高度定制以及二次开发。

# 2. 阅读对象
本文档为技术文档，需要阅读者：

- 具有基本的 Android 开发能力
- 准备接入七牛推流

# 3. 开发准备
## 3.1 开发环境
* Android Studio 开发工具，官方 [下载地址](http://developer.android.com/intl/zh-cn/sdk/index.html)
* Android 官方开发 SDK，官方 [下载地址](https://developer.android.com/intl/zh-cn/sdk/index.html)

## 3.2 设备以及系统要求

- 设备要求：搭载 Android 系统的设备
- 系统要求：Android 4.4(API 19) 及其以上

## 3.3 下载和导入 SDK
PLDroidMediaStreaming-ByteDance 包含两部分内容，分别为 PLDroidMediaStreaming（推流 SDK）和 PLDroidByteDanceEffect（特效插件 SDK），**PLDroidByteDanceEffect 的版本需要在 1.0.1 及以上方可成功接入**。SDK 主要包含 Demo 代码、SDK jar 包，以及 SDK 依赖的动态库文件，以 armeabi-v7a 架构为例，说明如下：

| 文件名称                           | 功能      | 大小    | 备注          |
| ------------------------------ | ------- | ----- | ----------- |
| pldroid-media-streaming-x.y.z.jar   | 推流 SDK 库   | 448KB | 必须依赖     |
| pldroid-bytedance-effect-x.y.z.jar      | 特效插件 SDK 库| 98KB | 必须依赖        |
| libpldroid\_streaming\_core.so | 推流核心库  | 92KB | 必须依赖       |
| libeffect.so                   | 特效插件核心库 | 8.2MB | 必须依赖   |
| libeffect_proxy.so             | 特效插件接口层 | 22KB  | 必须依赖    |
| libc++_shared.so               | c++ 静态链接库 | 657KB | 必须依赖   |
| libpldroid\_mmprocessing.so    | 内置美颜模块 | 539KB  | 必须依赖 |
| libpldroid\_streaming\_puic.so | QUIC模块 | 1.7MB     | 必须依赖    |
| libpldroid\_streaming\_aac\_encoder.so   | AAC 音频编码库    | 114KB | 不使用音频软编可以去掉 |
| llibpldroid\_streaming\_amix.so  | 混音模块    | 210KB | 不使用混音可以去掉 |
| libpldroid\_streaming\_h264_encoder.so  | h.264编码模块 | 846KB | 不使用H.264软编可以去掉 |

## 3.4 修改 build.gradle
在您工程目录下的 `build.gradle` 中添加如下依赖（代码中的`x.y.z`为具体的版本号）：

```java
dependencies {
    implementation files('libs/pldroid-media-streaming-x.y.z.jar')
    implementation files('libs/pldroid-bytedance-effect-x.y.z.jar')
    implementation 'com.qiniu:happy-dns:0.2.13'
}
```
**注意：PLDroidByteDanceEffect SDK 版本必须为 v1.0.1 及以上。建议接入推流 SDK 的版本在 v2.4.1.1 及以上**

## 3.5 修改代码混淆规则
为 proguard-rules.pro 增加如下规则:

```java
-keep class com.qiniu.pili.droid.streaming.**{*;}
-keep class com.qiniu.bytedanceplugin.**{*;}
```

## 3.6 添加相关权限
在 app/src/main 目录中的 AndroidManifest.xml 中增加如下 `uses-permission` 和 `uses-feature` 声明：

```
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
    <uses-feature android:glEsVersion="0x00020000" android:required="true" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

## 3.7 注册 Activity
在 app/src/main 目录中的 AndroidManifest.xml 中增加如下 `Activity` 声明：

```
<activity android:name="com.qiniu.pili.droid.streaming.screen.ScreenCaptureRequestActivity"/>

```

## 3.8 添加特效素材
| 文件名称                           | 文件类型      | 大小    | 备注          |
| ------------------------------ | ------- | ----- | ----------- |
| ComposeMakeup.bundle           | 高级美颜、微整形、美妆、美体素材 | 4.2MB | 包含若干款美颜、微整形、美妆、美体特效 |
| FilterResource.bundle          | 高级滤镜素材  |  12.3MB  | 包含 48 款滤镜 |
| LicenseBag.bundle              | 授权文件   | 3KB  | 该包内应包含有一个与包名所对应的授权文件，文件名内包含了所绑定的包名和授权的起止日期 |
| ModelResource.bundle           | 模型文件  | 13.8MB  | 用于人脸识别、手势识别等的模型文件 |
| StickerResource.bundle         | 动态贴纸素材 | 39.4MB | 包含 20 款动态贴纸 |

- 如您需要更多款式的特效素材，可在特效君 APP 上选择，联系七牛商务咨询进行购买。
- **授权文件是有到期时间的，如果过期，需要替换 LicenseBag.bundle 文件为新申请的授权文件。所以需要在授权文件过期前，替换 apk 中的 LicenseBag.bundle 文件（建议支持 LicenseBag.bundle 的云端下发功能）。**

# 4. 快速开始
## 4.1 资源的配置处理
为了方便的获取特效的信息列表，首先应该对字节跳动的资源进行配置处理，分别为高级美颜、微整形、美妆、美体素材（ComposeMakeup.bundle）、高级滤镜素材（FilterResource.bundle）和动态贴纸素材（StickerResource.bundle）配置 config.json 文件与 icons 文件夹。此项配置是为了后面可以通过调用类似于 `getStickerList()` 的方法快速获取特效信息，投放入 Adapter 来生成视图，也是为了可以通过云端下发特效文件和配置文件的方式在不更新 APP 的情况下更新特效资源。
由于资源配置的过程较为繁琐，我们为您提供了一个处理脚本，您只需将字节提供的 resource 和 icons 文件夹拷入脚本同级目录，在脚本所在目录下运行脚本即可，具体的使用方式请参见本目录下的 script 文件夹，运行脚本成功后您可更改对应素材文件下的 config.json 文件来修改特效图标、特效名称、特效初始强度甚至特效所在类别等信息。

## 4.2 把资源从 assets 拷贝到手机本地目录
在 Android 开发中携带额外的资源文件通常是会将其放入到 assets 文件夹中，当 apk 安装后会放到 /data/app/*.apk 目录下，以 apk 形式存在，assets 被绑定在 apk 中，并不会解压到 /data/data/YourApp 目录下去，所以我们无法直接获取到 assets 中文件的绝对路径。在进行 sdk 的初始化时和设置特效时都需要传入特效资源的地址，所以在此之前需要将资源从 assets 拷贝到本地目录中，可参考 demo 中的 LoadResourcesTask 类。

## 4.3 获取特效信息
如果拷贝成功，就可以传入 ByteDancePlugin 的初始化方法中，从而完成 ByteDancePlugin 的初始化：

```java
//该路径为上一步特效资源文件拷贝到外部存储中的路径
String resourcePath = getExternalFilesDir("assets") + File.separator + "resource";
mByteDancePlugin = new ByteDancePlugin(context, ByteDancePlugin.PluginType.record);
mByteDancePlugin.init(resourcePath) //初始化操作在渲染线程调用
```
ByteDancePlugin 是提供特效相关接口的核心类，您可以通过它获取特效资源信息列表：

```java
//获取所有滤镜信息
ByteDancePlugin.getFilterList()
//获取所有贴纸信息
ByteDancePlugin.getStickerList()
//获取所有美颜信息
ByteDancePlugin.getComposerList(ComposerType.BEAUTY);
//获取所有微整形信息
ByteDancePlugin.getComposerList(ComposerType.RESHAPE);
//获取所有美体信息
ByteDancePlugin.getComposerList(ComposerType.BODY);
//获取所有美妆信息
ByteDancePlugin.getMakeupList();
``` 
需要说明的是，获取美妆信息的接口与其它获取特效信息列表的接口有所不同，因为美妆资源是二级列表，其结构如下：

```
├── 美妆模块
│   └── 口红
│       ├── 复古红
│       ├── 少女粉
│       ├── 西柚色
│       ├── 西瓜红
│       └── ***
│   └── 腮红
│       ├── 微醺
│       ├── 日常
│       ├── 蜜桃
│       └── ***
│   └── ***
```
`getMakeupList()` 返回的是一个 List<MakeupModel> ,可调用 `MakeupMode.getEffects()` 来取得该类别的具体特效列表。

## 4.4 特效处理
特效处理是使用的核心步骤，建议参考 demo 中的 VideoRecordActivity 类。整体的步骤分为三步：  
1.为 MediaStreamingManager 添加回调
 
```java
mMediaStreamingManager.setSurfaceTextureCallback(mSurfaceTextureCallback);
mMediaStreamingManager.setStreamingPreviewCallback(mStreamingPreviewCallback);
```
2.创建 ByteDancePlugin 对象，如果是软编场景，需要开启 YUV 处理
```java
ByteDancePlugin mByteDancePlugin = new ByteDancePlugin(context, ByteDancePlugin.PluginType.record);
mByteDancePlugin.enableProcessYUV(true);
```
3.在纹理和 YUV 的回调中利用 ByteDancePlugin 进行特效处理，并将特效处理后的结果返回。

```java
SurfaceTextureCallback mSurfaceTextureCallback = new SurfaceTextureCallback() {
    private int count = 0;

    @Override
    public void onSurfaceCreated() {
    	// 此地址为资源文件在手机本地的根路径地址
        final String resourcePath = getExternalFilesDir("assets") + File.separator + "resource";
        // 初始化操作应在渲染线程调用
        mByteDancePlugin.init(resourcePath);
        // destroy() 后重新 init() 需要执行此操作恢复之前设置的特效
        mByteDamcePlugin.recoverEffects();
    }

    @Override
    public void onSurfaceChanged(int width, int height) {
        count = 0;
    }

    @Override
    public void onSurfaceDestroyed() {
        mByteDancePlugin.destroy();
    }

    @Override
    public int onDrawFrame(int texId, int width, int height, float[] transformMatrix) {
        if (mIsCameraSwitching || !mIsReady || mMediaStreamingManager.isPictureStreaming()) {
            return texId;
        }
        // 跳过两帧是为了等待 OpenGL 环境的初始化完成，之后可以正常处理纹理
        if (count < 2) {
            count++;
            return texId;
        }
        // onDrawFrame 返回的纹理格式为 OES ，经过 ByteDancePlugin.drawFrame 成功处理后的纹理格式为 2D
        // 如果 ByteDancePlugin 未初始化或特效处理被关闭，返回的纹理为原纹理
        return mByteDancePlugin.drawFrame(texId, width, height, System.nanoTime(), mProcessTypes, true);
    }
};

StreamingPreviewCallback mStreamingPreviewCallback = new StreamingPreviewCallback() {
    @Override
    public boolean onPreviewFrame(final byte[] data, final int width, final int height, int rotation, int fmt, final long tsInNanoTime) {
        addProcessType(rotation);
        if (mEncodingConfig.mCodecType != AVCodecType.SW_VIDEO_WITH_SW_AUDIO_CODEC && mEncodingConfig.mCodecType != AVCodecType.HW_VIDEO_YUV_AS_INPUT_WITH_HW_AUDIO_CODEC) {
            //非软编,不处理
            return false;
        }
        if (mIsCameraSwitching || mMediaStreamingManager.isPictureStreaming()) {
            return false;
        }
        mByteDancePlugin.processBuffer(data);
        return true;
    }
};
```
需要注意的是：  

-  ByteDancePlugin 处理纹理的时候，需要传入 ProcessType 类型的列表，该列表表明了需要将纹理方向转正所需要的操作，此列表的改变在 StreamingPreviewCallback 中，这是因为前后置摄像头返回的纹理在不同的手机上，方向或者镜像有可能不同，所以我们需要根据摄像头的前后置和回调纹理的方向来配置该列表（可参看 demo 中 AVStreamingActivity 类的 addProcessType 方法）。
-  软编场景下，需要对 YUV 进行处理，因此，在初始化 ByteDancePlugin 的时候需要使用 enableProcessYUV 来开启 YUV 处理，这样 processBuffer 才可以正常工作。

## 4.5 设置特效
特效的设置或更新是通过 ByteDancePlugin 的一系列方法实现的，需要特别注意的是，设置或更新特效的方法需要在 OpenGL 线程中调用。

``` java
// 设置美颜、微整形、美妆、美体等特效
mByteDancePlugin.setComposerNodes(nodes)
// 更新美颜、微整形、美妆、美体特效的强度
mByteDancePlugin.updateComposerNode(filePath, key, value)
// 设置滤镜特效
mByteDancePlugin.setFilter(filePath)
// 更新滤镜特效强度
mByteDancePlugin.updateFilterIntensity(intensity)
// 设置动态贴纸特效
mByteDancePlugin.setSticker(filePath)
// 设置 composer 类型特效（美颜、微整形、美妆、美体）可以与贴纸特效叠加
mByteDancePlugin.setComposerMode(ComposerMode.SHARE);
```
**凡是与特效相关的操作，包括设置、更新、处理等皆需要在渲染线程调用**

```java
// 如果因为某些原因导致特效消失，可调用此方法来恢复之前设置的特效
mByteDancePlugin.recoverEffects();
// 确定不再使用特效可以使用此方法释放特效资源
mByteDancePlugin.destroy();
```

# 5. 接口设计
PLDroidMediaStreaming-ByteDance 包含两部分内容，分别为 PLDroidMediaStreaming（推流 SDK）和 PLDroidByteDanceEffect（特效插件 SDK），有关于推流 SDK 的接口设计与使用请阅读[推流 SDK 使用文档](https://developer.qiniu.com/pili/sdk/3719/PLDroidMediaStreaming-function-using)，下面介绍特效插件 SDK 的接口设计：

## 5.1 特效插件对象的创建
```java
ByteDancePlugin mByteDancePlugin = new ByteDancePlugin(this, pluginType);
```
参数 pluginType 为插件类型，此参数为一个枚举类型，对于推流来说只需要传入 `record` 类型即可，它的结构如下所示：

```java
/**
 * 特检插件类型，创建插件时需要传入
 */
public enum PluginType {
    /**
     * 录制特效插件
     */
    record,
    /**
     * 编辑特效插件
     */
    edit
}
```

## 5.2 特效插件对象的初始化与销毁
```java
/**
 * 初始化资源与特效处理组件，需要在渲染线程调用
 *
 * @param resourcePath 特效资源路径
 * @return 初始化是否成功
 */
public boolean init(String resourcePath)

/**
 * 释放特效资源，需要在渲染线程调用
 */
public void destroy()

/**
 * 释放特效资源，需要在渲染线程中调用
 * 仅适用于七牛短视频中编辑场景下保存时调用
 */
public void destroyForSaving()
```
需要注意的是 ByteDancePlugin 的初始化、销毁与特效处理都应该工作在预览渲染线程。

## 5.3 设置特效的叠加模式
```java
/**
 * 设置 composer 类型特效（美颜、微整形、美体、美妆）是否可以与贴纸特效叠加
 * 如果设置为不可叠加，设置动态贴纸特效会覆盖掉 composer 类型特效，但 composer 类型特效不会覆盖动态贴纸特效
 * 需要在渲染线程调用
 *
 * @param mode ALONE 代表不可叠加，SHARE 代表可叠加，默认为可叠加
 * @return 设置是否成功
 */
public boolean setComposerMode(BytedEffectConstants.ComposerMode mode)
```

## 5.4 设置动态贴纸
```java
/**
 * 设置贴纸，如果 path 为 null 或者 ""，则关闭贴纸
 * 需要在渲染线程调用
 *
 * @param filePath 贴纸素材的文件路径
 * @return 设置是否成功
 */
public boolean setSticker(String filePath)
```

## 5.5 设置滤镜
```java
/**
 * 设置滤镜效果,如果 filePath 为 null 或者 "",则关闭滤镜
 * 需要在渲染线程调用
 *
 * @param filePath 滤镜资源文件路径
 * @return 设置是否成功
 */
public boolean setFilter(String filePath)
```

## 5.6 设置特效组合
```java
/**
 * 开启 composer 类型特效（美颜、微整形、美体、美妆）的处理节点，可支持美颜、微整形、美体、美妆特效的任意叠加
 * 需要在渲染线程调用
 *
 * @param nodes 资源路径名称数组
 * @return 设置是否成功
 */
public boolean setComposerNodes(String[] nodes)
```

## 5.7 更新某个特效的强度
```java
/**
 * 更新某个 composer 类型特效（美颜、微整形、美体、美妆）的强度
 * 需要在渲染线程调用
 * @param filePath 特效资源文件路径
 * @param key      特效所对应的 key
 * @param value    特效强度，范围 0~1
 * @return 设置是否成功
 */
public boolean updateComposerNode(String filePath, String key, float value)
```

## 5.8 更新滤镜的特效强度
```java
/**
 * 设置滤镜效果,如果 filePath 为 null 或者 "",则关闭滤镜
 * 需要在渲染线程调用
 *
 * @param filePath 滤镜资源文件路径
 * @return 设置是否成功
 */
public boolean updateFilterIntensity(float intensity)
```

## 5.9 恢复特效设置
```java
/**
 * 恢复之前特效设置
 * 可在意外情况丢失特效的情况下使用，需要在渲染线程调用
 */
public void recoverEffects()
```

## 5.10 获取滤镜的信息列表
```java
/**
 * 获取所有滤镜信息，需要在 init 或 updateEffectsInfo 之后调用才会有数据
 * 可使用 updateEffectsInfo 来更新列表
 *
 * @return 滤镜列表
 */
public static List<FilterItem> getFilterList()
```

## 5.11 获取动态贴纸的信息列表
```java
/**
 * 获取所有贴纸信息，需要在 init 或 updateEffectsInfo 之后调用才会有数据
 * 可使用 updateEffectsInfo 来更新列表
 *
 * @return 贴纸列表
 */
public static List<StickerItem> getStickerList()
```

## 5.12 获取指定类别的特效信息列表
```java
/**
 * 获取指定类型的特效信息，需要在 init 或 updateEffectsInfo 之后调用才会有数据
 * 可使用 updateEffectsInfo 来更新列表
 *
 * @return 特效信息列表
 */
public static List<ComposerModel> getComposerList(ComposerType composerType)
```
其中的 composerType 参数可指定三种类别：

```java
public enum ComposerType {
    BEAUTY,
    RESHAPE,
    BODY
}
```

## 5.13 获取美妆信息列表
```java
/**
 * 获取所有美妆信息，需要在 init 或 updateEffectsInfo 之后调用才会有数据
 * 可使用 updateEffectsInfo 来更新列表
 *
 * @return 美妆信息列表
 */
public static List<MakeupModel> getMakeupList()
```

## 5.14 更新特效信息列表
```java
/**
 * 根据提供的资源地址更新特效信息
 *
 * @param resourcePath 特效资源文件根路径
 */
public static void updateEffectsInfo(String resourcePath)
```
此方法会触发重新解析特效资源配置文件，更新特效资源信息列表。

## 5.15 预览时处理纹理
```java
/**
 * 预览时特效处理
 *
 * @param texId        纹理
 * @param texWidth     纹理宽度
 * @param texHeight    纹理高度
 * @param timestampNs  时间戳
 * @param processTypes 处理类型列表
 * @param isOES        是否为 OES 格式纹理
 * @return 处理后的纹理，如果处理成功则纹理格式为 2D，否则返回原纹理
 */
public int drawFrame(int texId, int texWidth, int texHeight, long timestampNs, List<ProcessType> processTypes, boolean isOES)
```
`processTypes` 参数中存储的应为将纹理转正所需要的处理类型，推流 SDK 回调的纹理会因为摄像头的前后置、横竖屏而回调方向不同的纹理、YUV 数据，例如前置竖屏回调的纹理、YUV 数据是旋转了 90 度并做了竖向镜像的，转正需要经过旋转 270 度并横向镜像处理，使用该方法进行处理时， `processTypes` 应该顺序添加 `ProcessType.ROTATE_270` 与 `ProcessType.FLIPPED_HORIZONTAL` 来对纹理进行转正处理，其它情况请参见 PLDroidMediaStreamingDemo。传入的时间戳的变化速率会影响特效中动画的执行速度。
在推流的回调中纹理的格式为 OES ，所以 isOES 参数应为 true。

## 5.16 开关 YUV 处理
```java
/**
 * 开关 YUV 数据的处理
 *
 * @param enable true 为开启
 */
public void enableProcessYUV(boolean enable)
```
开关 YUV 数据的处理，软编场景下，需要对 YUV 进行处理，需要传入 true 开启 YUV 的数据处理以使得 processData 方法正常工作。

## 5.17 处理 YUV 数据
```java
/**
 * 处理 YUV 数据
 *
 * @param data   待处理 YUV 数据
 * @return 处理是否成功
 */
public boolean processData(byte[] data)
```
此方法的调用需要依赖 enableProcessYUV 为 true 的情况。

# 6. 资源相关
## 6.1 LicenseBag 授权文件
SDK 会根据该文件夹下的文件进行鉴权，请确保该文件夹下的文件中只有一个文件名称中包含应用的 ApplicationId。如果授权过期可通过动态下发文件来替换之前的文件即可（文件下发的逻辑需要您自行实现），无需更新 APP。

## 6.2 素材购买与更新
如果您想要购买更多样的特效素材，可前往特效君 App 进行挑选。
如果您需要在 APP 中新增或者更新素材，可通过动态下发特效资源文件和配置文件到手机上的素材文件夹（文件下发的逻辑由您来做），无需更新 APP。

# 7. 历史记录
* 2.0.0
  - 发布 pldroid-bytedance-effect-2.0.0.jar
  - 发布 libc++_shared.so
  - 升级 libeffect.so
  - 升级 libeffect_proxy.so
  - 修复了美妆中口红特效出现在唇部遮挡物上的问题
  - 优化了美体的边缘效果
  - 优化了 YUV 处理速度
* 1.0.2
  - 发布 ByteDancePlugin-1.0.2.jar
  - 新增获取可支持的美妆类型列表的接口
  - 新增获取可支持的具体美妆效果集合的接口
  - 新增获取可支持的美体效果列表的接口
  - 新增更新 composer 类型特效（指的是美颜、美型、美妆、美体）列表的接口
  - 新增更新可支持的滤镜列表的接口
  - 新增更新可支持的动态贴纸列表接口
  - 新增更新所有特效列表的接口
* 1.0.1
  - 发布 pldroid-media-streaming-2.4.1.1.jar
  - 发布 ByteDancePlugin-1.0.1.jar
  - 发布 libpldroid_mmprocessing.so
  - 发布 libpldroid\_streaming\_aac\_encoder.so
  - 发布 libpldroid\_streaming\_amix.so
  - 发布 libpldroid\_streaming\_core.so
  - 发布 libpldroid\_streaming\_h264\_encoder.so
  - 发布 libpldroid\_streaming\_puic.so
  - 发布 libeffect.so
  - 发布 libeffect_proxy.so
  - 高级美颜、美型
  - 高级滤镜
  - 动态贴纸
  - 支持 H.264 和 AAC 硬编
  - 支持录屏
  - 支持构造带安全授权凭证的 RTMP 推流地址
  - 支持 RTMP 封包及推流
  - 支持 RTMP 推流自适应网络质量动态切换码率或自定义策略
  - 支持数据源回调接口，可自定义 Filter (滤镜) 特效处理
  - 支持前后置摄像头，以及动态切换
  - 支持自动对焦
  - 支持手动对焦
  - 支持动态水印
  - 支持美颜，以及调节磨皮、美白、红润效果
  - 支持 Encoding Mirror 设置
  - 支持 Zoom 操作
  - 支持 Mute/Unmute
  - 支持闪光灯操作
  - 支持纯音频推流，以及后台运行
  - 支持截帧功能
  - 支持动态更改 Encoding Orientation
  - 支持动态切换横竖屏
  - 支持蓝牙麦克风
  - 支持后台推流
  - 支持双声道立体声
  - 支持 QUIC 推流
  - 支持 ARMv7a, ARM64v8a 主流芯片体系架构
  - 支持 SEI 信息发送

# 8. FAQ
## 8.1 如何获取此 SDK 授权？
答：可通过 400-808-9176 转 2 号线联系七牛商务咨询，或者 [通过工单](https://support.qiniu.com/?ref=developer.qiniu.com) 联系七牛的技术支持。

## 8.2 是否支持更多的动态贴纸、滤镜效果？
答：支持，您可以额外购买动态贴纸、滤镜等素材，可在特效君 APP 上进行选择，联系七牛商务进行购买。

## 8.3 特效素材是否通用？
答：不通用，素材与包名绑定，不同包名不可以混用素材。

## 8.4 如何使用 demo 中的授权进行测试？
答：将 ApplicationID 修改为 `com.qiniu.pili.droid.streaming.bytedance.demo` 并将资源文件正确配置即可开始测试。

## 8.5 授权到期必须通过发布新版本强制用户更新吗？
答：正式授权到期需替换新授权文件，但不一定需要发布新版本，建议可以通过类似文件下发服务的方式将新授权文件下发下去，替换原授权文件的位置即可，这属于应用层逻辑。

## 8.6 授权失败可能的原因有哪些？
答：请先检查是否为下面的原因  
1.检查手机系统时间是否正常  
2.检查 ApplicationId 是否与授权包名一致  
3.检查 check_license 与对应版本号是否一致  
常见的授权错误码返回：

| 授权错误码名称                         | 错误码编号  | 解释                |
| ------------------------------------ | --------   | -----------------  |
| BEF_RESULT\_INVALID\_LICENSE         |   -114   | 无效的license      |
| BEF_RESULT\_NULL\_BUNDLEID           |   -115    | ApplicationId 为空 |
| BEF_RESULT\_LICENSE\_STATUS\_INVALID |   -116   | 非法授权文件      |
| BEF_RESULT\_LICENSE\_STATUS\_EXPIRED |   -117    | 授权文件过期 |
| BEF_RESULT\_LICENSE\_STATUS\_NO\_FUNC|   -118   | 请求功能不匹配      |
| BEF_RESULT\_LICENSE\_STATUS\_ID\_NOT\_MATCH  |    -119    | ApplicationId 不匹配 |
| BEF_RESULT\_LICENSE\_BAG\_NULL\_PATH |   -120   | 授权包路径为空      |
| BEF_RESULT\_LICENSE\_BAG\_INVALID\_PATH |   -121    | 错误的授权包路径 |
| BEF_RESULT\_LICENSE\_BAG\_TYPE\_NOT\_MATCH |   -122   | 授权包类型不匹配      |
| BEF_RESULT\_LICENSE\_BAG\_INVALID\_VERSION |   -123    | 无效的版本 |
| BEF_RESULT\_LICENSE\_BAG\_INVALID\_BLOCK\_COUNT |   -124   | 无效的数据块      |
| BEF_RESULT\_LICENSE\_BAG\_INVALID\_BLOCK\_LEN |   -125    | 无效的数据块长度 |
| BEF_RESULT\_LICENSE\_BAG\_INCOMPLETE\_BLOCK |   -126   | 数据块不完整      |
| BEF_RESULT\_LICENSE\_BAG\_UNAUTHORIZED\_FUNC |   -127    | 未授权的功能 |

4.检查 log 是否存在 EffectSDK ERROR: Parser: cJson parse fail，出现这个报错一般是素材与 license 绑定的 ApplicationId 不匹配（每套素材都会与其授权绑定，需配套使用），请检查使用的素材与授权是否配套。  

如确定不是以上问题，请[通过工单](https://support.qiniu.com/?ref=developer.qiniu.com) 联系七牛的技术支持。

## 8.7 资源文件体积较大，可以做文件下发吗？
答：可以，ByteDancePlugin 初始化的时候并不会检查资源文件的完整性，但要确保授权文件的存在，特效信息的获取是根据您在特效资源中的配置来返回的，与其中指向的特效资源文件是否存在无关，您可以根据使用接口获取的特效信息来判断特效文件是否存在，向客户展示不同的图标，当用户选择一个特效文件不存在的特效时请求服务器，将得到的文件放到对应的资源路径，随后调用设置特效接口即可。

## 8.8 新购买了额外的特效素材，如何更新到已经上线的 APP 中
答：借助文件下发（此功能需要由您自行实现），将旧的资源文件替换为新的资源文件即可。