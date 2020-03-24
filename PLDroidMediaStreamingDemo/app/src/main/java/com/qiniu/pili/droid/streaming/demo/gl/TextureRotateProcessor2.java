package com.qiniu.pili.droid.streaming.demo.gl;

import android.opengl.GLES20;
import android.opengl.GLES30;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

public class TextureRotateProcessor2 {

    private int mWidth;
    private int mHeight;

    private int mProgram;

    private int mVao;
    private int mVboVertices;
    private int mVboTexCoords;

    private int mVerticesLoc;
    private int mTexCoordsLoc;
    private int mMVPMatrixLoc;
    private int mTexTransMatrixLoc;

    private static final float[] CUBE = {
            -1.0f, -1.0f,
            1.0f, -1.0f,
            -1.0f, 1.0f,
            1.0f, 1.0f,
    };
    private static final float[] TEXTURE_FLIPPED = {
            0.0f, 1.0f,
            0.0f, 0.0f,
            1.1f, 1.0f,
            1.0f, 0.0f,};

    private float[] mVertexPosition = CUBE;
    private float[] mTextureCoordinate = TEXTURE_FLIPPED;

    private volatile boolean mIsSetup;

    private int mFbo;
    private int mOutTex;

    public boolean setup() {
        if (!setupShaders()) {
            return false;
        }

        setupLocations();
        setupBuffers();
        setupFBO();

        mIsSetup = true;
        return true;
    }

    public boolean isSetup() {
        return mIsSetup;
    }

    public boolean setViewportSize(int width, int height) {
        mWidth = width;
        mHeight = height;
        releaseOutTex();
        setupTexture(width, height);
        return true;
    }

    public int getWidth() {
        return mWidth;
    }

    public int getHeight() {
        return mHeight;
    }

    public int draw(int texId) {
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, mFbo);
        GLES20.glFramebufferTexture2D(GLES20.GL_FRAMEBUFFER, GLES20.GL_COLOR_ATTACHMENT0, GLES20.GL_TEXTURE_2D, mOutTex, 0);

        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);

        GLES20.glUseProgram(mProgram);

        GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
        GLES20.glBindTexture(getTextureTarget(), texId);

        setupVBO();

        GLES20.glUniformMatrix4fv(mMVPMatrixLoc, 1, false, GlUtil.IDENTITY_MATRIX, 0);

        GLES20.glUniformMatrix4fv(mTexTransMatrixLoc, 1, false, GlUtil.IDENTITY_MATRIX, 0);

        GLES20.glViewport(0, 0, mWidth, mHeight);

        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4);

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        GLES20.glBindTexture(getTextureTarget(), 0);
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0);
        return mOutTex;
    }

    public void release() {
        mIsSetup = false;
        if (mFbo != 0) {
            GLES20.glDeleteFramebuffers(1, new int[]{mFbo}, 0);
            mFbo = 0;
        }
        releaseOutTex();
        deleteProgram();
        deleteVBO();
        deleteVAO();
    }

    private void deleteProgram() {
        if (mProgram != 0) {
            GLES20.glDeleteProgram(mProgram);
            mProgram = 0;
        }
    }

    private void deleteVBO() {
        if (mVboVertices != 0) {
            GLES20.glDeleteBuffers(1, new int[]{mVboVertices}, 0);
            mVboVertices = 0;
        }
        if (mVboTexCoords != 0) {
            GLES20.glDeleteBuffers(1, new int[]{mVboTexCoords}, 0);
            mVboTexCoords = 0;
        }
    }

    private void deleteVAO() {
        if (mVao != 0) {
            GLES30.glDeleteVertexArrays(1, new int[]{mVao}, 0);
            mVao = 0;
        }
    }

    private void setupBuffers() {
        float[] vertexPosition = getVertexPosition();

        ByteBuffer bb = ByteBuffer.allocateDirect(4 * vertexPosition.length);
        bb.order(ByteOrder.nativeOrder());
        FloatBuffer mVertices = bb.asFloatBuffer();
        mVertices.put(vertexPosition);
        mVertices.rewind();

        float[] textureCoordinate = getTextureCoordinate();

        bb = ByteBuffer.allocateDirect(4 * textureCoordinate.length);
        bb.order(ByteOrder.nativeOrder());
        FloatBuffer mTexCoords = bb.asFloatBuffer();
        mTexCoords.put(textureCoordinate);
        mTexCoords.rewind();

        // upload data to vbo
        int[] bufs = new int[2];
        GLES20.glGenBuffers(2, bufs, 0);
        mVboVertices = bufs[0];
        mVboTexCoords = bufs[1];

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVboVertices);
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, 8 * 4, mVertices, GLES20.GL_STATIC_DRAW);

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVboTexCoords);
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, 8 * 4, mTexCoords, GLES20.GL_STATIC_DRAW);

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        // setup vbo
        setupVBO();

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);
    }

    private void setupVBO() {
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVboVertices);
        GLES20.glEnableVertexAttribArray(mVerticesLoc);
        GLES20.glVertexAttribPointer(mVerticesLoc, 2, GLES20.GL_FLOAT, false, 0, 0);

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, mVboTexCoords);
        GLES20.glEnableVertexAttribArray(mTexCoordsLoc);
        GLES20.glVertexAttribPointer(mTexCoordsLoc, 2, GLES20.GL_FLOAT, false, 0, 0);
    }

    private boolean setupShaders() {
        String[] sources = getShaderSources();
        mProgram = OpenGLUtils.loadProgram(sources[0], sources[1]);
        return mProgram != 0;
    }

    private void setupLocations() {
        mVerticesLoc = GLES20.glGetAttribLocation(mProgram, "a_pos");
        mTexCoordsLoc = GLES20.glGetAttribLocation(mProgram, "a_tex");
        mMVPMatrixLoc = GLES20.glGetUniformLocation(mProgram, "u_mvp");
        mTexTransMatrixLoc = GLES20.glGetUniformLocation(mProgram, "u_tex_trans");
    }

    private void setupFBO() {
        mFbo = GlUtil.createFBO();
    }

    private boolean setupTexture(int width, int height) {
        mOutTex = OpenGLUtils.genFrameBufferTextureID(width, height);
        return mOutTex != 0;
    }

    private void releaseOutTex() {
        if (mOutTex != 0) {
            GLES20.glDeleteTextures(1, new int[]{mOutTex}, 0);
            mOutTex = 0;
        }
    }

    private float[] getVertexPosition() {
        return mVertexPosition;
    }

    private float[] getTextureCoordinate() {
        return mTextureCoordinate;
    }

    private int getTextureTarget() {
        return GLES20.GL_TEXTURE_2D;
    }

    private String[] getShaderSources() {
        return new String[]{GlUtil.TEXTURE_VS, GlUtil.TEXTURE_2D_FS};
    }
}