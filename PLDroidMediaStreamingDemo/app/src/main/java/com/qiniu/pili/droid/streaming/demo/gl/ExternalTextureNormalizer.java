package com.qiniu.pili.droid.streaming.demo.gl;

import android.annotation.TargetApi;
import android.opengl.GLES11Ext;
import android.os.Build;


@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
public class ExternalTextureNormalizer extends TextureProcessor {
    @Override
    protected int getTextureTarget() {
        return GLES11Ext.GL_TEXTURE_EXTERNAL_OES;
    }

    @Override
    protected String[] getShaderSources() {
        return new String[]{ GLUtils.TEXTURE_VS, GLUtils.TEXTURE_EXTERNAL_FS };
    }
}
