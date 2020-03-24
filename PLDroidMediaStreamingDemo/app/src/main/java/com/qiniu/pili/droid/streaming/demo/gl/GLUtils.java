package com.qiniu.pili.droid.streaming.demo.gl;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.opengl.EGL14;
import android.opengl.GLES20;
import android.opengl.GLES30;
import android.opengl.Matrix;
import android.os.Build;
import android.util.Log;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.ShortBuffer;

public class GLUtils {

    private static final String TAG = "GLUtils";

    private static int GL_VERSION = 2;

    public static final Object GL_RENDER_FENCE = new Object();

    public static final String TEXTURE_VS =
            "attribute vec2 a_pos;\n" +
            "attribute vec2 a_tex;\n" +
            "varying vec2 v_tex_coord;\n" +
            "uniform mat4 u_mvp;\n" +
            "uniform mat4 u_tex_trans;\n" +
            "void main() {\n" +
            "   gl_Position = u_mvp * vec4(a_pos, 0.0, 1.0);\n" +
            "   v_tex_coord = (u_tex_trans * vec4(a_tex, 0.0, 1.0)).st;\n" +
            "}\n";

    public static final String TEXTURE_2D_FS =
            "precision mediump float;\n" +
            "uniform sampler2D u_tex;\n" +
            "varying vec2 v_tex_coord;\n" +
            "void main() {\n" +
            "  gl_FragColor = texture2D(u_tex, v_tex_coord);\n" +
            "}\n";

    public static final String TEXTURE_EXTERNAL_FS =
            "#extension GL_OES_EGL_image_external : require\n" +
            "precision mediump float;\n" +
            "uniform samplerExternalOES u_tex;\n" +
            "varying vec2 v_tex_coord;\n" +
            "void main() {\n" +
            "  gl_FragColor = texture2D(u_tex, v_tex_coord);\n" +
            "}\n";

    public static final String TEXTURE_VS_REVERT_Y =
            "attribute vec2 a_pos;\n" +
                    "attribute vec2 a_tex;\n" +
                    "varying vec2 v_tex_coord;\n" +
                    "uniform mat4 u_mvp;\n" +
                    "uniform mat4 u_tex_trans;\n" +
                    "void main() {\n" +
                    "   gl_Position = u_mvp * vec4(a_pos, 0.0, 1.0);\n" +
                    "   gl_Position.y = -gl_Position.y;\n" +
                    "   v_tex_coord = (u_tex_trans * vec4(a_tex, 0.0, 1.0)).st;\n" +
                    "}\n";

    public static float[] VERTEX_POSITION = {
            -1.0f, -1.0f,
            -1.0f,  1.0f,
            1.0f, -1.0f,
            1.0f,  1.0f,
    };

    public static float[] TEXTURE_COORDINATE = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 0.0f,
            1.0f, 1.0f,
    };

    public static float[] TEXTURE_COORDINATE_VERTICAL_FLIP = {
            0.0f, 1.0f,
            0.0f, 0.0f,
            1.0f, 1.0f,
            1.0f, 0.0f,
    };

    // base on the above vertices, do horizontal flip, aka mirror.
    public static float[] HORIZONTAL_FLIP_VERTEX_POSITION = {
            1.0f, -1.0f,
            1.0f,  1.0f,
            -1.0f, -1.0f,
            -1.0f,  1.0f,
    };

    /**
     * Identity matrix for general use.  Don't modify or life will get weird.
     */
    public static final float[] IDENTITY_MATRIX;

    static {
        IDENTITY_MATRIX = new float[16];
        Matrix.setIdentityM(IDENTITY_MATRIX, 0);
    }

    public static boolean isGL3() {
        return GL_VERSION > 2;
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    public static boolean isSupportEGL14() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            try {
                EGL14.eglGetCurrentContext();
            } catch (NoClassDefFoundError e) {
                Log.i(TAG, "EGL14 isn't supported on this platform, change to use EGL10.");
                return false;
            }
        } else {
            return false;
        }
        return true;
    }

    public static int createTexture() {
        int[] textures = createTextures(1);
        return textures[0];
    }

    public static int[] createTextures(int num) {
        int[] textures = new int[num];
        GLES20.glGenTextures(num, textures, 0);
        return textures;
    }

    public static int createProgram(String vertexShader, String fragmentShader) {
        int vertexShaderId = compileShader(GLES20.GL_VERTEX_SHADER, vertexShader);
        int fragmentShaderId = compileShader(GLES20.GL_FRAGMENT_SHADER, fragmentShader);
        if (vertexShaderId == 0 || fragmentShaderId == 0) {
            return -1;
        }
        int program = GLES20.glCreateProgram();
        /**
         * link vertex shade and fragment shade
         */
        GLES20.glAttachShader(program, vertexShaderId);
        GLES20.glAttachShader(program, fragmentShaderId);
        GLES20.glLinkProgram(program);
        /**
         * Check compile result
         */
        final int[] linkStatus = new int[1];
        GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, linkStatus, 0);
        if (linkStatus[0] == 0) {
            GLES20.glDeleteProgram(program);
            Log.d(TAG, "Linking of program failed !");
            return -1;
        }
        if (!validateProgram(program)) {
            return -1;
        }
        return program;
    }

    private static boolean validateProgram(int programObjectId) {
        GLES20.glValidateProgram(programObjectId);
        final int[] validateStatus = new int[1];
        GLES20.glGetProgramiv(programObjectId, GLES20.GL_VALIDATE_STATUS, validateStatus, 0);
        Log.d(TAG, "Results of validating program: " + validateStatus[0]
                + "\nLog:" + GLES20.glGetProgramInfoLog(programObjectId));
        return validateStatus[0] != 0;
    }

    private static int compileShader(int type, String shaderCode) {
        /**
         * create shader
         */
        int objectId = GLES20.glCreateShader(type);
        /**
         * bind shader source code
         */
        GLES20.glShaderSource(objectId, shaderCode);
        /**
         * compile shader
         */
        GLES20.glCompileShader(objectId);
        /**
         * Check compile result
         */
        final int[] compileStatus = new int[1];
        GLES20.glGetShaderiv(objectId, GLES20.GL_COMPILE_STATUS, compileStatus, 0);
        if (compileStatus[0] == 0) {
            GLES20.glDeleteShader(objectId);
            Log.e(TAG, "Compilation of shader failed.");
            return 0;
        }
        return objectId;
    }

    public static ShortBuffer createShortBuffer(short[] coords) {
        ShortBuffer bb = ByteBuffer.allocateDirect(coords.length * 2)
                .order(ByteOrder.nativeOrder())
                .asShortBuffer();
        bb.put(coords).position(0);
        return bb;
    }

    public static FloatBuffer createFloatBuffer(float[] coords) {
        FloatBuffer bb = ByteBuffer.allocateDirect(coords.length * 4)
                .order(ByteOrder.nativeOrder())
                .asFloatBuffer();
        bb.put(coords).position(0);
        return bb;
    }

    /**
     * Checks to see if a GLES error has been raised.
     */
    public static boolean checkGlError(String op) {
        int error = GLES20.glGetError();
        if (error != GLES20.GL_NO_ERROR) {
            String msg = op + ": glError 0x" + Integer.toHexString(error);
            Log.e(TAG, msg);
            return false;
        }
        return true;
    }

    /**
     * Create a VAO
     */
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    public static int createVAO() {
        int[] vao = new int[1];
        GLES30.glGenVertexArrays(1, vao, 0);
        return vao[0];
    }

    /**
     * Create a FBO
     */
    public static int createFBO() {
        int[] fbo = new int[1];
        GLES20.glGenFramebuffers(1, fbo, 0);
        return fbo[0];
    }

    /**
     * Creates a texture from raw data.
     *
     * @param data   Image data, in a "direct" ByteBuffer.
     * @param width  Texture width, in pixels (not bytes).
     * @param height Texture height, in pixels.
     * @param format Image data format (use constant appropriate for glTexImage2D(), e.g. GL_RGBA).
     * @return Handle to texture.
     */
    public static int createImageTexture(ByteBuffer data, int width, int height, int format) {
        int[] textureHandles = new int[1];
        int textureHandle;

        GLES20.glGenTextures(1, textureHandles, 0);
        textureHandle = textureHandles[0];
        checkGlError("glGenTextures");

        // Bind the texture handle to the 2D texture target.
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, textureHandle);

        // Configure min/mag filtering, i.e. what scaling method do we use if what we're rendering
        // is smaller or larger than the source image.
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER,
                GLES20.GL_LINEAR);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER,
                GLES20.GL_LINEAR);
        GLES20.glTexParameterf(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S,
                GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameterf(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T,
                GLES20.GL_CLAMP_TO_EDGE);
        checkGlError("loadImageTexture");

        // Load the data from the buffer into the texture handle.
        GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, /*level*/ 0, format,
                width, height, /*border*/ 0, format, GLES20.GL_UNSIGNED_BYTE, data);
        checkGlError("loadImageTexture");
        return textureHandle;
    }


    private static Bitmap getResizedBitmap(Bitmap bm, int newWidth, int newHeight) {
        int width = bm.getWidth();
        int height = bm.getHeight();
        float scaleWidth = ((float) newWidth) / width;
        float scaleHeight = ((float) newHeight) / height;

        android.graphics.Matrix matrix = new android.graphics.Matrix();
        matrix.postScale(scaleWidth, scaleHeight);
        Bitmap resizedBitmap = Bitmap.createBitmap(
                bm, 0, 0, width, height, matrix, false);
        bm.recycle();
        return resizedBitmap;
    }

    public static TextureDrawer createAndInitTexDrawer(int width, int height) {
        TextureDrawer textureDrawer = new TextureDrawer();
        textureDrawer.setViewportSize(width, height);
        textureDrawer.setup();
        return textureDrawer;
    }
}
