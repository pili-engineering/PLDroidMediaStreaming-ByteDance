package com.qiniu.pili.droid.streaming.demo.gl;

import android.annotation.TargetApi;
import android.opengl.GLES20;
import android.os.Build;

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
public class TextureProcessor extends TextureDrawer {
    private static final String TAG = "TextureProcessor";

    protected int mFbo;
    protected int mOutTex;

    @Override
    public boolean setup() {
        setupFBO();
        return super.setup();
    }

    @Override
    public boolean setViewportSize(int width, int height) {
        super.setViewportSize(width, height);
        releaseOutTex();
        return setupTexture(width, height);
    }

    public int process(int texId, float[] texTransMatrix) {
        return process(texId, texTransMatrix, mOutTex);
    }

    public int process(int inTexID, float[] texTransMatrix, int outTexID) {
        return process(inTexID, texTransMatrix, outTexID, -1);
    }

    public int process(int inTexID, float[] texTransMatrix, int outTexID, int rotateBy) {
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, mFbo);
        GLES20.glFramebufferTexture2D(GLES20.GL_FRAMEBUFFER, GLES20.GL_COLOR_ATTACHMENT0, GLES20.GL_TEXTURE_2D, outTexID, 0);

        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
        draw(inTexID, texTransMatrix, rotateBy);

        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);

        return outTexID;
    }

    public int process(int texId) {
        return process(texId, null);
    }

    public int processRotateOfTex(int inTexId, float[] texTransMatrix, int rotateBy) {
        return process(inTexId, texTransMatrix, mOutTex, rotateBy);
    }

    private void releaseOutTex() {
        if (mOutTex != 0) {
            GLES20.glDeleteTextures(1, new int[]{mOutTex}, 0);
            mOutTex = 0;
        }
    }

    @Override
    public void release() {
        super.release();
        if (mFbo != 0) {
            GLES20.glDeleteFramebuffers(1, new int[]{mFbo}, 0);
            mFbo = 0;
        }
        releaseOutTex();
    }

    private boolean setupTexture(int width, int height) {
        mOutTex = GLUtils.createImageTexture(null, width, height, GLES20.GL_RGBA);
        return true;
    }

    private void setupFBO() {
        mFbo = GLUtils.createFBO();
    }

}
