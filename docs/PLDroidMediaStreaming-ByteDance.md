# 1. 概述
PLDroidMediaStreaming-ByteDance 是七牛推出的一款适用于 Android 平台的具有高级特效功能的推流 SDK，提供了包括高级美颜、高级滤镜、动态贴纸、水印、SEI 信息发送、录屏、纯音频推流在内的多种功能，支持高度定制以及二次开发。

# 2. 阅读对象
本文档为技术文档，需要阅读者：

- 具有基本的 Android 开发能力
- 准备接入七牛推流

#3. 开发准备
## 3.1 开发环境
* Android Studio 开发工具，官方 [下载地址](http://developer.android.com/intl/zh-cn/sdk/index.html)
* Android 官方开发 SDK，官方 [下载地址](https://developer.android.com/intl/zh-cn/sdk/index.html)

## 3.2 设备以及系统要求

- 设备要求：搭载 Android 系统的设备
- 系统要求：Android 4.4(API 19) 及其以上

## 3.3 下载和导入 SDK
PLDroidMediaStreaming-ByteDance 包含两部分内容，分别为 PLDroidMediaStreaming（推流 SDK） 和 ByteDancePlugin（特效插件 SDK），**ByteDancePlugin 的版本需要在 1.0.1 及以上方可成功接入**。SDK 主要包含 Demo 代码、SDK jar 包，以及 SDK 依赖的动态库文件，以 armeabi-v7a 架构为例，说明如下：

| 文件名称                           | 功能      | 大小    | 备注          |
| ------------------------------ | ------- | ----- | ----------- |
| pldroid-media-streaming-x.y.z.jar   | 推流 SDK 库   | 448KB | 必须依赖     |
| ByteDancePlugin-x.y.z.jar      | 特效插件 SDK 库| 93KB | 必须依赖        |
| libpldroid\_streaming\_core.so | 推流核心库  | 92KB | 必须依赖        |
| libeffect.so                   | 特效插件核心库 | 11.6MB | 必须依赖       |
| libeffect_proxy.so             | 特效插件接口层 | 84KB  | 必须依赖        |
| libpldroid\_mmprocessing.so            | 内置美颜模块 | 539KB  | 必须依赖 |
| libpldroid\_streaming\_puic.so                        | QUIC模块 | 1.7MB     | 必须依赖    |
| libpldroid\_streaming\_aac\_encoder.so           | AAC 音频编码库    | 114KB | 不使用音频软编可以去掉 |
| llibpldroid\_streaming\_amix.so             | 混音模块    | 210KB | 不使用混音可以去掉 |
| libpldroid\_streaming\_h264_encoder.so          | h.264编码模块 | 846KB | 不使用H.264软编可以去掉 |

## 3.4 修改 build.gradle
双击打开您的工程目录下的 `build.gradle` ，确保已经添加了如下依赖（代码中的`x.y.z`为具体的版本号），如下所示：

```java
dependencies {
    implementation files('libs/pldroid-media-streaming-x.y.z.jar')
    implementation files('libs/ByteDancePlugin-x.y.z.jar')
    implementation 'com.qiniu:happy-dns:0.2.13'
}
```
**注意：ByteDancePlugin SDK 版本必须为 v1.0.1 及以上。建议接入推流 SDK 的版本在 v2.4.1.1 及以上**

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
| ComposeMakeup.bundle           | 高级美颜、美型、美妆素材 | 3.6MB | 包含若干款美颜、美型、美妆特效 |
| FilterResource.bundle          | 高级滤镜素材  |  12.3MB  | 包含 48 款滤镜 |
| LicenseBag.bundle              | 授权文件   | 426字节  | 该包内有且只有一个文件，文件名内包含了所绑定的包名和授权的起止日期 |
| ModelResource.bundle           | 模型文件  | 6.6MB  | 用于人脸识别、手势识别 |
| StickerResource.bundle         | 动态贴纸素材 | 61.3MB | 包含 20 款动态贴纸 |

如用户需要更多款式的美颜、美型、滤镜、动态贴纸素材，可在特效君 APP 上选择，联系七牛商务咨询进行购买。

# 4. 接口设计
PLDroidMediaStreaming-ByteDance 包含两部分内容，分别为 PLDroidMediaStreaming（推流 SDK）和 ByteDancePlugin（特效插件 SDK），有关于推流 SDK 的接口设计与使用请阅读[推流 SDK 使用文档](https://developer.qiniu.com/pili/sdk/3719/PLDroidMediaStreaming-function-using)，下面介绍特效插件 SDK 的接口设计：

## 4.1 创建特效插件对象
```java
ByteDancePlugin mByteDancePlugin = new ByteDancePlugin(this, pluginType, resourcePath);
```
参数 resourcePath 为资源文件的根路径，该路径需为手机本地文件路径，建议放在 assets 文件目录下，并自行拷贝至手机本地  
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

## 4.2 设置动态贴纸
```java
/**
  * 开启或者关闭贴纸，如果 path 为 null 或 ""，取消贴纸
  *
  * @param fileName 贴纸素材的文件名称
  * @return 设置是否成功
  */
public boolean setSticker(String fileName)
```

## 4.3 设置滤镜
```java
/**
 * 开启或者关闭滤镜，如果 path 为 null 或 "", 取消滤镜
 *
 * @param fileName 滤镜资源文件名称
 * @return 设置是否成功
 */
public boolean setFilter(String fileName)
```

## 4.4 设置特效组合
```java
/**
 * 设置特效组合，目前仅支持美颜、美型两种特效的任意叠加
 *
 * @param nodes 资源路径数组
 * @return 设置是否成功
 */
public boolean setComposeNodes(String[] nodes)
```

## 4.5 设置 composer 特效是否可叠加
```java
/**
 * 设置 composer 类型特效（美颜、美妆）是否可以与贴纸特效叠加
 * 如果设置为不可叠加，设置贴纸特效会覆盖掉 composer 类型特效
 *
 * @param mode ALONE 代表不可叠加，SHARE 代表可叠加
 * @return 设置是否成功
 */
public boolean setComposerMode(BytedEffectConstants.ComposerMode mode)
```

## 4.6 更新某个特效的强度
```java
/**
 * 更新某个特效的强度
 *
 * @param key   特效所对应的 key
 * @param value 特效强度
 * @return 设置是否成功
 */
public boolean updateComposeNode(String key, float value)
```

## 4.7 设置某类型特效强度
```java
/**
 * 设置美颜、滤镜强度
 *
 * @param intensityType 强度类型
 * @param intensity     强度值 范围 0~1
 * @return 是否设置成功
 */
public boolean updateIntensity(BytedEffectConstants.IntensityType intensityType, float intensity)
```
与 4.6 稍有不同，该方法需要传入的 intensityType 参数为一个枚举类型，具体解释如下:

```java
public enum IntensityType {
    // 调节滤镜
    Filter(12),
    // 调节美白 
    BeautyWhite(1),
    // 调节磨皮
    BeautySmooth(2),
    // 同时调节瘦脸和大眼
    FaceReshape(3),
    // 调整锐化
    BeautySharp(9);

    private int id;

    public int getId() {
        return id;
    }

    IntensityType(int id) {
        this.id = id;
    }
}
```

## 4.8 获得已经开启的特效节点名称
```java
/**
 * 获得已经开启的特效节点
 * 
 * @return 已开启特效节点名称数组
 */
public String[] getComposeNodes()
```

## 4.9 恢复特效设置
```java
/**
 * 恢复特效设置
 */
public void recoverStatus()
```

## 4.10 释放特效资源
```java
/**
 * 释放特效资源，需要工作在渲染线程
 */
public void destroyEffectSDK()
```

## 4.11 获取支持的滤镜列表
```java
/**
 * 获取所有滤镜
 *
 * @return 滤镜列表
 */
public static List<FilterItem> getFilterList()
```

## 4.12 获取支持的贴纸列表
```java
/**
 * 获取所有贴纸
 *
 * @return 贴纸列表
 */
public static List<StickerItem> getStickerList()
```

## 4.13 获取支持的美颜列表
```java
/**
 * 获取所有美颜
 *
 * @return 美颜列表
 */
public static List<MakeUpModel> getBeautyList()
```

## 4.14 获取支持的美型列表
```java
/**
 * 获取所有美型
 *
 * @return 美型列表
 */
public static List<MakeUpModel> getShapeList()
```

## 4.15 获取支持的美妆类型列表
```java
/**
 * 获取所有美妆类型
 *
 * @return 美妆类型列表，具体到某一部位
 */
public static List<MakeUpModel> getMakeUpList()
```

## 4.16 获取支持的美妆效果集合
```java
/**
 * 获取所有具体的美妆效果集合
 *
 * @return 美妆效果集合，具体到某一部位的某一种效果
 */
public static Map<String, List<MakeUpModel>> getMakeUpOptionItems()
```

## 4.17 获取支持的美体列表
```java
/**
 * 获取所有美体信息
 *
 * @return 美体列表
 */
public static List<MakeUpModel> getBodyList()
```

## 4.18 更新 compose 类型特效列表
```java
/**
 * 从资源中重新解析配置文件，更新美颜、微整形、美妆、美体效果列表
 */
public static void updateComposeList()
```

## 4.19 更新滤镜效果列表
```java
/**
 * 从资源中重新解析配置文件，更新滤镜效果列表
 */
public static void updateFilterList()
```

## 4.20 更新动态贴纸列表
```java
/**
 * 从资源中重新解析配置文件，更新动态贴纸列表
 */
public static void updateStickerList()
```

## 4.21 更新全部特效列表
```java
/**
 * 从资源中重新解析配置文件，更新全部特效列表
 */
public static void updateAllList()
```

## 4.22 判断是否正在使用特效
```java
/**
 * 判断是否正在使用特效
 *
 * @return 如果已经使用了至少一种特效则返回 true ,否则返回 false
 */
public boolean isUsingEffect()
```

## 4.23 预览时处理纹理
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
 * @return 处理后的纹理，纹理格式为 2D ，处理失败会返回原纹理
 */
public int onDrawFrame(int texId, int texWidth, int texHeight, long timestampNs, List<ProcessType> processTypes, boolean isOES)
```
`processTypes` 参数中存储的应为将纹理转正所需要的处理类型，推流 SDK 回调的纹理会因为摄像头的前后置、横竖屏而回调方向不同的纹理、YUV 数据，例如前置竖屏回调的纹理、YUV 数据是旋转了 90 度并做了竖向镜像的，转正需要经过旋转 270 度并横向镜像处理，使用该方法进行处理时， `processTypes` 应该顺序添加 `ProcessType.ROTATE_270` 与 `ProcessType.FLIPPED_HORIZONTAL` 来对纹理进行转正处理，其它情况请参见 PLDroidMediaStreamingDemo。传入的时间戳的变化速率会影响特效中动画的执行速度。

ProcessType 的类结构如下所示：

```java
public enum ProcessType {
    //旋转 0 度
    ROTATE_0,
    //旋转 90 度
    ROTATE_90,
    //旋转 180 度
    ROTATE_180,
    //旋转 270 度
    ROTATE_270,
    //竖直镜像
    FLIPPED_VERTICAL,
    //横向镜像
    FLIPPED_HORIZONTAL
}
```

## 4.24 处理 YUV 数据
```java
/**
 * 处理 YUV 数据
 *
 * @param inputData    YUV 数据
 * @param imageWidth   图像宽度
 * @param imageHeight  图像高度
 * @param processTypes 处理类型列表
 * @param outputData   处理后的 YUV 数据
 * @param timestampNs  YUV 数据的时间戳
 * @return 处理是否成功
 */
public boolean processBuffer(byte[] inputData, int imageWidth, int imageHeight, byte[] outputData, List<ProcessType> processTypes, long timestampNs)
```
该方法的调用必须在其预览的 OpenGL 线程中，并且需要注意一点，如果未添加特效经过此方法处理会返回错误的数据，需要在外部添加判断。 `processTypes` 参数的使用与预览处理纹理相同，请参见 4.16 小节。传入的时间戳的变化速率会影响特效中动画的执行速度。

## 4.18 检测 SDK 是否已经初始化完毕
```java
/**
 * 返回是否已成功初始化 SDK
 *
 * @return 成功返回 true
 */
public boolean isEffectSDKInited()
```

## 4.19 Surface 生命周期
```java
public void onSurfaceCreated()
public void onSaveSurfaceChanged(int width, int height)
public void onSurfaceDestroy()
```
这些方法应该随 Surface 的生命周期回调的调用而调用，如果是旋转摄像头，需要手动调用 `onSurfaceDestroy`。

# 5 快速开始
在开始编码之前请确保 jar、build.gradle、so、素材文件、混淆规则已正确配置，此处只展示大致的使用方式，详细的使用请参照 PLDroidStreamingDemo ,有关于推流 SDK 的使用请参照[推流 SDK 使用文档](https://developer.qiniu.com/pili/sdk/3719/PLDroidMediaStreaming-function-using)

## 5.1 初始化 ByteDancePlugin
```java
//此路径为之前拷贝资源的地址，请在此之前自行将资源文件拷贝到手机本地
String resourcePath = getExternalFilesDir("assets") + File.separator + "resource";
//创建一个录制类型的 ByteDancePlugin
ByteDancePlugin mByteDancePlugin = new ByteDancePlugin(this, ByteDancePlugin.PluginType.record, resourcePath);
//设置 ComposerMode 为 BytedEffectConstants.ComposerMode.SHARE ，贴纸和美颜、美型可共存
mByteDancePlugin.setComposerMode(BytedEffectConstants.ComposerMode.SHARE);
//初始化处理类型列表，处理纹理、YUV 数据时需要传入
mProcessTypes = new ArrayList<>();
```

## 5.2 硬编处理
```java
//对纹理回调的各个部分进行实现
SurfaceTextureCallback mSurfaceTextureCallback = new SurfaceTextureCallback() {
    private int count = 0;
    @Override
    public void onSurfaceCreated() {
        mByteDancePlugin.onSurfaceCreated();
    }

    @Override
    public void onSurfaceChanged(int width, int height) {
        mByteDancePlugin.onSurfaceChanged(width, height);
        count = 0;
    }

    @Override
    public void onSurfaceDestroyed() {
        mByteDancePlugin.onSurfaceDestroy();
    }

    @Override
    public int onDrawFrame(int texId, int width, int height, float[] transformMatrix) {
    	//如果摄像头正在旋转过程中或者未准备好，返回原纹理
        if (mIsCameraSwitching || !mIsReady || mMediaStreamingManager.isPictureStreaming()) {
            return texId;
        }
        //跳过两帧是为了等待 OpenGL 环境的初始化完成，之后可以正常处理纹理
        if (count < 2) {
            count++;
            return texId;
        }
        //如果至少设置了一种特效则进行特效处理，否则返回原纹理
        if (mByteDancePlugin.isUsingEffect()) {
            return mByteDancePlugin.onDrawFrame(texId, width, height, System.nanoTime(), mProcessTypes, true);
        } else {
            return texId;
        }
    }
};
//将回调接口的实现设置到推流的管理类上
mMediaStreamingManager.setSurfaceTextureCallback(mSurfaceTextureCallback);
```
## 5.3 软编处理
```java
//对 YUV 数据的回调进行实现
StreamingPreviewCallback mStreamingPreviewCallback = new StreamingPreviewCallback() {
    @Override
    public boolean onPreviewFrame(final byte[] data, final int width, final int height, int rotation, int fmt, final long tsInNanoTime) {
	addProcessType(rotation);
        if (mEncodingConfig.mCodecType != AVCodecType.SW_VIDEO_WITH_SW_AUDIO_CODEC
                && mEncodingConfig.mCodecType != AVCodecType.HW_VIDEO_YUV_AS_INPUT_WITH_HW_AUDIO_CODEC) {
            //非软编,不处理
            return false;
        }
	//如果正在旋转摄像头或正在进行图片推流，直接返回
        if (mIsCameraSwitching || mMediaStreamingManager.isPictureStreaming()) {
            return true;
        }
	//如果宽高发生了变化，重新设置 YUV 数据的容器
        if (mImageWidth != width || mImageHeight != height) {
            mImageWidth = width;
            mImageHeight = height;
            mOutputData = new byte[data.length];
        }
	//如果至少使用了一种特效，那么进行处理，否则跳过
        if (mByteDancePlugin.isUsingEffect()) {
            //使用同步辅助类来完成线程同步
            final CountDownLatch countDownLatch = new CountDownLatch(1);
            //将 YUV 数据的处理切到 GL 线程中执行
            mCameraPreviewFrameView.queueEvent(new Runnable() {
                @Override
                public void run() {
                    if (!mIsCameraSwitching) {
                        mEffectProcessSuccess = mByteDancePlugin.processBuffer(data, width, height, mOutputData, mProcessTypes, System.nanoTime());
                        //如果处理成功且处理后的数据不为 null，则进行拷贝
                        if (mEffectProcessSuccess && mOutputData != null) {
                            System.arraycopy(mOutputData, 0, data, 0, data.length);
                        }
                    }
                    countDownLatch.countDown();
                }
            });
            try {
                countDownLatch.await();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        return mEffectProcessSuccess;
    }
};
```

## 5.4 更新处理类型列表
此处展示摄像头在不同情况下，处理类型列表所需要填入的参数，需要随摄像头方向的改变而改变。

```java
/**
 * 根据传入的旋转角度和摄像头的前后置情况对纹理、YUV 所需要进行的处理进行改变
 */
private void addProcessType(int rotation) {
    if (mRotation == rotation && mCurrentCamFacingIndex == mCameraStreamingSetting.getReqCameraId()) {
        return;
    } else {
        mRotation = rotation;
        mCurrentCamFacingIndex = mCameraStreamingSetting.getReqCameraId();
    }
    switch (rotation) {
        case 0:
            addProcessType(ProcessType.ROTATE_0);
            break;
        case 90:
            addProcessType(ProcessType.ROTATE_90);
            break;
        case 180:
            addProcessType(ProcessType.ROTATE_180);
            break;
        case 270:
            addProcessType(ProcessType.ROTATE_270);
            break;
        default:
            addProcessType(ProcessType.ROTATE_0);
            break;
    }
}

/**
 * 根据当前摄像头的前后置状态为 mProcessTypes 变量添加不同的 processType
 */
private void addProcessType(ProcessType processType) {
    mProcessTypes.clear();
    mProcessTypes.add(processType);
    if (mCurrentCamFacingIndex == CameraStreamingSetting.CAMERA_FACING_ID.CAMERA_FACING_FRONT.ordinal()) {
        mProcessTypes.add(ProcessType.FLIPPED_HORIZONTAL);
    }
}
```

## 5.5 特效的设置
```java
//设置一个动态贴纸，传入 "" 代表取消贴纸
mByteDancePlugin.setSticker(stickerFileName);
//设置一个滤镜，传入 "" 代表取消滤镜
mByteDancePlugin.setFilter(FilterFileName);
//更新滤镜效果强度，value 值范围为 0~1
mByteDancePlugin.updateIntensity(BytedEffectConstants.IntensityType.Filter, value);
//加载特效，nodes 为特效名称字符串数组
mByteDancePlugin.setComposeNodes(nodes);
//更新某个特效节点强度，key 值为特效节点特征值，固定且唯一，配置在 config.json 中，可查看该文档第七节资源格式，value 值范围为 0~1
mByteDancePlugin.updateComposeNode(key, value);
//开启与关闭特效，默认为开启状态
mByteDancePlugin.setEffectOn(isOn);
```
**注意：设置与更新特效的操作请确保工作在 OpenGL 线程**

```java
//如果因为某些原因导致特效消失，可调用此方法来恢复之前设置的特效
mByteDancePlugin.recoverStatus();
//确定不再使用特效可以使用此方法释放特效资源
mByteDancePlugin.destroyEffectSDK();
```

# 6 资源相关
## 6.1 资源格式
### 6.1.1 ComposeMakeup 美颜、美型、美妆、美体
SDK 会根据该目录下的 config.json 文件来解析素材文件，可使用 `getBeautyList` 获取可支持的美颜信息列表，使用 `getShapeList` 获取美型信息列表，使用 `getMakeUpList` 获取美妆类型信息列表，使用 `getMakeUpOptionItems` 获取具体的美妆信息集合，使用 `getBodyList` 获取美体信息列表，用户可按照格式修改其内容，详细配置请参考 demo ,大致格式如下：

```java
{
  "beauty": [
    {
      "fileName": "beauty_Android", //美颜素材文件夹名称
      "iconName": "smooth.png", //特效图标名称，请放在美颜素材文件夹下
      "effectName": "磨皮", //特效名称
      "key": "smooth", //特效特征值，不可更改
      "defaultIntensity": 0.5 //默认特效强度，范围 0~1
    },
    
    ...
    
  ],
  "reshape": [
    {
      "fileName": "reshape", //美型素材文件夹名称
      "iconName": "cheek.png", //特效图标名称，请放在美型素材文件夹下
      "effectName": "瘦脸", //特效名称
      "key": "Internal_Deform_Overall", //特效特征值，不可更改
      "defaultIntensity": 0.5 //默认特效强度，范围 0~1
    },
    
    ...
    
  ]，
  "makeUp": {
    "blush": { //美妆素材文件夹名称
      "effectClassName": "腮红", //美妆类型名称
      "iconName": "blush.png", //该类美妆类型所展示的图标名称，请放在对应的素材文件夹下
      "key": "Internal_Makeup_Blusher", //该类美妆特效的特征值，不可更改
      "effect": [ //该类美妆类型中所包含的具体的特效效果
        {
          "fileName": "weixun", //具体特效的文件夹名称，请在此文件夹下放入 icon.png 作为图标
          "effectName": "微醺", //具体特效的名称
          "defaultIntensity": 0.5 //具体特效的默认强度，范围 0~1
        },
        
        ...
        
    	]
    },
    "eyebrow": {
      "effectClassName": "眉毛",
      "iconName": "eyebrow.png",
      "key": "Internal_Makeup_Brow",
      "effect": [
        {
          "fileName": "BR01",
          "effectName": "BRO1",
          "defaultIntensity": 0.5
        },
           
        ...
        
    	]
    }
  },
  "body": [
    {
      "fileName": "body/longleg", //美体素材文件夹路径
      "iconName": "leg.png", //特效图标名称，请放在美体素材文件夹下
      "effectName": "长腿", //特效名称
      "key": "", //特效特征值，不可更改
      "defaultIntensity": 0.5 //默认特效强度，范围 0~1
    },
    
    ...
    
  ]
}
```

### 6.1.2 FilterResource 滤镜
SDK 会根据该目录下的 config.json 文件来解析素材文件，可使用 `getFilterList` 来获取滤镜信息，用户可按照格式修改其内容，json 格式如下：  

```
[
  {
    "fileName":"Filter_01_38", //滤镜素材文件夹名称,该文件夹下的 icon.png 为滤镜效果图，用户可自行更换
    "filterName": "柔白", //滤镜名称
    "defaultIntensity": 0.8 //滤镜默认强度
  },
  
  ...
  
]
```

### 6.1.3 StickerResource 动态贴纸
SDK 会根据该目录下的 config.json 文件来解析素材文件，可使用 `getStickerList` 来获取动态贴纸信息，用户可按照格式修改其内容，json 格式如下：

```java
[
  {
    "fileName": "bawanglong", //动态贴纸素材文件夹名称,该文件夹下的 icon.png 为动态贴纸效果图，用户可自行更换
    "stickerName": "霸王龙", //动态贴纸名称
    "tip": "嗷呜~" //动态贴纸附加内容
  },
  
  ...
  
]
```

### 6.1.4 LicenseBag 授权文件
SDK 会根据该文件夹下的文件进行鉴权，请确保该文件夹下文件有且只有一个。如果授权过期可通过动态下发文件来替换该文件即可（文件下发的逻辑需要您自行实现），无需更新 APP。

## 6.2 素材购买与更新
如果用户想要购买更多样的特效素材，可前往特效君 App 进行挑选，只限美颜、美型、滤镜与动态贴纸。
如果用户需要在 APP 中新增或者更新素材，可通过动态下发素材文件到素材文件夹，无需更新 APP。

## 6.3 常见错误
### 6.3.1 EffectSDK ERROR: Parser: cJson parse fail 
EffectSDK ERROR: Parser: cJson parse fail 出现这个报错一般是素材与 license 绑定的 ApplicationID 不匹配（每套素材都会与其授权绑定，需配套使用），请检查使用的素材与授权是否配套。

### 6.3.2 ERROR: FileUtil: readFile: file ……… xxx.config.json is not exist
出现上述日志，表示设置的素材路径可能不正确，SDK内部没有正确读到素材的配置文件，请检查素材路径是否正确。

# 7. 历史记录
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
答：支持，用户可以额外购买动态贴纸、滤镜等素材，可在特效君 APP 上进行选择，联系七牛商务进行购买。

## 8.3 素材是否通用？
答：不通用，素材与包名绑定，不同包名不可以混用素材

## 8.4 如何使用 demo 中默认授权进行测试？
答：将 ApplicationID 修改为 `com.qiniu.pili.droid.streaming.bytedance.demo` 并将资源文件正确配置即可开始测试。

## 8.5 正式授权到期必需替换新授权发布新版本强制用户更新吗？
答：正式授权到期需替换新授权文件，但不一定需要发布新版本，建议可以通过类似文件下发服务的方式将新授权文件下发下去，这属于应用层逻辑。

## 8.6 授权失败可能的原因有哪些？
答：请先检查是否为下面的原因  
1.检查手机系统时间是否正常  
2.检查 ApplicationId 是否与授权包名一致  
3.检查 check_license 与对应版本号是否一致  
如确定不是以上问题，请[通过工单](https://support.qiniu.com/?ref=developer.qiniu.com) 联系七牛的技术支持。

## 8.7 资源文件体积较大，可以做文件下发吗？
答：可以，ByteDancePlugin 实例化的时候并不会检查资源文件的完整性，但要确保授权文件的存在，随后可根据使用接口获取的特效信息来判断特效文件是否存在，向客户展示不同的图标，当用户选择一个特效文件不存在的特效时请求服务器，将得到的文件放到对应的资源路径，随后调用设置特效接口即可。

## 8.8 新购买了额外的特效素材，如何更新到已经上线的 APP 中
答：借助文件下发，将旧的资源文件替换为新的资源文件即可。

## 8.9 特效素材文件需要配置 json ,其中的 key 值从哪里可以找到？
答：在 demo 资源文件的 config.json 中可以查询每种特效所对应的 key 。