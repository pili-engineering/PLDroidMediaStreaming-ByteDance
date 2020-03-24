package com.qiniu.pili.droid.streaming.demo.gl;

import android.opengl.GLES20;
import android.opengl.GLES30;
import android.opengl.Matrix;
import android.os.Build;
import android.support.annotation.RequiresApi;


import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

public class TextureDrawer {
    private static final String TAG = "TextureDrawer";

    protected int mX;
    protected int mY;
    protected int mWidth;
    protected int mHeight;

    protected float mRotation;

    protected int mProgram;

    private int mVao;
    private int mVboVertices;
    private int mVboTexCoords;

    protected float[] mCustomMVP;
    protected float[] mRotateMatrix;

    private float mScaleX = 1f;
    private float mScaleY = 1f;

    private int mVerticesLoc;
    private int mTexCoordsLoc;
    private int mMVPMatrixLoc;
    private int mTexTransMatrixLoc;

    private float[] mVertexPosition = GLUtils.VERTEX_POSITION;
    private float[] mTextureCoordinate = GLUtils.TEXTURE_COORDINATE;

    private int mDrawX;
    private int mDrawY;

    private volatile boolean mIsSetup;

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public boolean setup() {
        if (!setupShaders()) {
            return false;
        }

        if (!setupLocations()) {
            return false;
        }

        if (!setupBuffers()) {
            return false;
        }

        mIsSetup = true;
        return true;
    }

    /**
     * @param widthTex width of the texture that will draw in this canvas
     * @param heightTex height of the texture that will draw in this canvas
     * @param displayMode scale type of this canvas
     * @return
     */
    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public boolean setup(int widthTex, int heightTex, PLDisplayMode displayMode) {
        if (displayMode == PLDisplayMode.FULL) {
            generateFullConfig(widthTex, heightTex);
        } else if (displayMode == PLDisplayMode.FIT) {
            generateFitConfig(widthTex, heightTex);
        }

        return setup();
    }

    public boolean isSetup() {
        return mIsSetup;
    }

    public int getDrawX() {
        return mDrawX;
    }

    public int getDrawY() {
        return mDrawY;
    }

    private void generateFullConfig(int widthTex, int heightTex) {
        mVertexPosition = GLUtils.VERTEX_POSITION;

        float canvasRatio = 1.0f * mWidth / mHeight;
        float texRatio = 1.0f * widthTex / heightTex;
        if (texRatio < canvasRatio) {// crop tex height
            float cropHeight = widthTex / canvasRatio;
            float beginPos = ((heightTex - cropHeight) / 2f) / heightTex;
            float endPos = 1 - beginPos;

            mTextureCoordinate = new float[] {
                    0.0f, beginPos,
                    0.0f, endPos,
                    1.0f, beginPos,
                    1.0f, endPos,
            };
        } else {// crop tex width
            float cropWidth = heightTex * canvasRatio;
            float beginPos = ((widthTex - cropWidth) / 2f) / widthTex;
            float endPos = 1 - beginPos;

            mTextureCoordinate = new float[] {
                    beginPos, 0.0f,
                    beginPos, 1.0f,
                    endPos, 0.0f,
                    endPos, 1.0f,
            };
        }
    }

    private void generateFitConfig(int widthTex, int heightTex) {
        mTextureCoordinate = GLUtils.TEXTURE_COORDINATE;

        float ratio = 1.0f * mWidth / mHeight;
        float texRatio = 1.0f * widthTex / heightTex;

        float originLeft;
        float originRight;
        float originTop;
        float originBottom;

        if (texRatio < ratio) {
            float fitWidth = mHeight * texRatio;
            originLeft = 0.5f - ((fitWidth / mWidth) / 2f);
            originRight = 0.5f + ((fitWidth / mWidth) / 2f);
            originTop = 0.0f;
            originBottom = 1.0f;
            mDrawX = (int) (originLeft * mWidth);
        } else {
            float fitHeight = mWidth / texRatio;
            originTop = 0.5f - (fitHeight / mHeight) / 2f;
            originBottom = 0.5f + (fitHeight / mHeight) / 2f;
            originLeft = 0.0f;
            originRight = 1.0f;
            mDrawY = (int) (originTop * mHeight);
        }

        ortho(originLeft, originRight, originTop, originBottom);
    }

    private void ortho(float originLeft, float originRight, float originTop, float originBottom) {
        float ratio = 1.0f * mWidth / mHeight;

        originLeft *= 2 * ratio;
        originTop *= 2;
        originRight *= 2 * ratio;
        originBottom *= 2;
        // 2. translate (1.0f, 1.0f) or (ratio, ratio)
        originLeft -= ratio;
        originTop -= 1.0f;
        originRight -= ratio;
        originBottom -= 1.0f;
        // 3. inverse y-axis
        originTop *= -1;
        originBottom *= -1;

        mCustomMVP = new float[16];
        Matrix.orthoM(
                mCustomMVP, 0,
                -ratio, ratio,
                -1, 1,
                -1, 1);
        Matrix.rotateM(mCustomMVP, 0, mRotation, 0.0f, 0.0f, -1.0f);

        mVertexPosition = new float[] {
                originLeft, originBottom,   // 0 bottom left
                originLeft, originTop,   // 1 top left
                originRight, originBottom,   // 2 bottom right
                originRight, originTop,   // 4 top right
        };
    }

    public void setRotation(float rotation) {
        if (mCustomMVP == null) {
            mCustomMVP = new float[16];
        }
        mRotation = rotation;
        Matrix.setIdentityM(mCustomMVP, 0);
        Matrix.rotateM(mCustomMVP, 0, rotation, 0, 0, -1);
    }

    public void setScale(float scaleX, float scaleY) {
        mScaleX = scaleX;
        mScaleY = scaleY;
    }

    public boolean setViewportSize(int width, int height) {
        mWidth = width;
        mHeight = height;
        return true;
    }

    public int getWidth() {
        return mWidth;
    }

    public int getHeight() {
        return mHeight;
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public void draw(int texId) {
        draw(texId, null);
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public void draw(int texId, float[] texTransMatrix) {
        draw(texId, texTransMatrix, -1);
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public void draw(int texId, float[] texTransMatrix, int rotateBy) {
        GLES20.glUseProgram(mProgram);

        GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
        GLES20.glBindTexture(getTextureTarget(), texId);

        if (GLUtils.isGL3()) {
            GLES30.glBindVertexArray(mVao);
        } else {
            setupVBO();
        }

        // deal with the rotate operation of video
        if (rotateBy != -1 && mRotateMatrix == null) {
            mRotateMatrix = new float[16];
            Matrix.setIdentityM(mRotateMatrix, 0);
            Matrix.rotateM(mRotateMatrix, 0, rotateBy, 0, 0, -1);
        }

        if (mScaleX != 1f || mScaleY != 1f) {
            if (mRotateMatrix != null) {
                Matrix.scaleM(mRotateMatrix, 0, mScaleX, mScaleY, 1f);
            }
            if (mCustomMVP != null) {
                Matrix.scaleM(mCustomMVP, 0, mScaleX, mScaleY, 1f);
            } else {
                mCustomMVP = new float[16];
                Matrix.setIdentityM(mCustomMVP, 0);
                Matrix.scaleM(mCustomMVP, 0, mScaleX, mScaleY, 1f);
            }
            mScaleX = 1f;
            mScaleY = 1f;
        }

        if (rotateBy == -1) {
            GLES20.glUniformMatrix4fv(mMVPMatrixLoc, 1, false, mCustomMVP != null ? mCustomMVP : GLUtils.IDENTITY_MATRIX, 0);
        } else {
            GLES20.glUniformMatrix4fv(mMVPMatrixLoc, 1, false, mRotateMatrix, 0);
        }

        if (texTransMatrix == null) {
            texTransMatrix = GLUtils.IDENTITY_MATRIX;
        }

        GLES20.glUniformMatrix4fv(mTexTransMatrixLoc, 1, false, texTransMatrix, 0);

        GLES20.glViewport(mX, mY, mWidth, mHeight);

        beforeDraw();

        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4);

        afterDraw();

        if (GLUtils.isGL3()) {
            GLES30.glBindVertexArray(0);
        }

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        GLES20.glBindTexture(getTextureTarget(), 0);
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public void release() {
        mIsSetup = false;
        deleteProgram();
        deleteVBO();
        deleteVAO();
    }

    protected void deleteProgram(){
        if (mProgram != 0) {
            GLES20.glDeleteProgram(mProgram);
            mProgram = 0;
        }
    }

    protected void deleteVBO(){
        if (mVboVertices != 0) {
            GLES20.glDeleteBuffers(1, new int[]{mVboVertices}, 0);
            mVboVertices = 0;
        }
        if (mVboTexCoords != 0) {
            GLES20.glDeleteBuffers(1, new int[]{mVboTexCoords}, 0);
            mVboTexCoords = 0;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    protected void deleteVAO(){
        if (mVao != 0) {
            GLES30.glDeleteVertexArrays(1, new int[]{mVao}, 0);
            mVao = 0;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    protected boolean setupBuffers() {
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

        // setup vao if GL 3.0
        if (GLUtils.isGL3()) {
            mVao = GLUtils.createVAO();
            GLES30.glBindVertexArray(mVao);
        }

        // setup vbo
        setupVBO();

        if (GLUtils.isGL3()) {
            GLES30.glBindVertexArray(0);
        }

        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0);

        return GLUtils.checkGlError(TAG + " setup VAO, VBOs.");
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
        mProgram = GLUtils.createProgram(sources[0], sources[1]);
        return mProgram != 0;
    }

    /**
     * get or bind attributes and uniforms
     * @return
     */
    protected boolean setupLocations() {
        mVerticesLoc = GLES20.glGetAttribLocation(mProgram, "a_pos");
        mTexCoordsLoc = GLES20.glGetAttribLocation(mProgram, "a_tex");
        mMVPMatrixLoc = GLES20.glGetUniformLocation(mProgram, "u_mvp");
        mTexTransMatrixLoc = GLES20.glGetUniformLocation(mProgram, "u_tex_trans");
        return GLUtils.checkGlError(TAG + " glBindAttribLocation");
    }

    protected void beforeDraw() {}

    protected void afterDraw() {}

    protected float[] getVertexPosition() {
        return mVertexPosition;
    }

    protected float[] getTextureCoordinate() {
        return mTextureCoordinate;
    }

    public void setTextureCoordinate(float[] textureCoordinate) {
        mTextureCoordinate = textureCoordinate;
    }

    protected int getTextureTarget() {
        return GLES20.GL_TEXTURE_2D;
    }

    protected String[] getShaderSources() {
        return new String[]{ GLUtils.TEXTURE_VS, GLUtils.TEXTURE_2D_FS };
    }
}