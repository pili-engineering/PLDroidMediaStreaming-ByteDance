attribute vec3 attPosition;
attribute vec2 attUV;
attribute vec3 attPositionOffset;
uniform mat4 g_unif_ModelViewProjMat;
varying vec2 g_vary_Texcoord0;
void main ()
{
  vec4 tmpvar_1_1;
  tmpvar_1_1.w = 1.0;
  tmpvar_1_1.xyz = (attPosition + attPositionOffset);
  g_vary_Texcoord0 = attUV;
  gl_Position = (g_unif_ModelViewProjMat * tmpvar_1_1);
}

