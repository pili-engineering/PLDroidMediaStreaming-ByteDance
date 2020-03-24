package com.qiniu.pili.droid.streaming.demo.gl;

import android.opengl.GLES20;
import android.opengl.Matrix;


public class GlUtil {

    /** Identity matrix for general use.  Don't modify or life will get weird. */
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

    /**
     * Identity matrix for general use.  Don't modify or life will get weird.
     */
    public static final float[] IDENTITY_MATRIX;

    static {
        IDENTITY_MATRIX = new float[16];
        Matrix.setIdentityM(IDENTITY_MATRIX, 0);
    }

    private GlUtil() { // do not instantiate
    }

    /**
     * Create a FBO
     */
    public static int createFBO() {
        int[] fbo = new int[1];
        GLES20.glGenFramebuffers(1, fbo, 0);
        return fbo[0];
    }
}
