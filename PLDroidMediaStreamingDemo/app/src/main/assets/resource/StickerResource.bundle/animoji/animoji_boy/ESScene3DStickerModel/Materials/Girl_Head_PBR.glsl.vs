attribute vec3 attPosition;
attribute vec3 attNormal;
attribute vec2 attUV;
attribute vec3 attNormalOffset;
attribute vec3 attPositionOffset;
uniform mat4 g_unif_ModelMat;
uniform mat4 g_unif_ModelViewProjMat;
uniform mat3 g_unif_NormalWorldMat;
varying vec3 g_vary_WorldPosition;
varying vec3 g_vary_WorldNormal;
varying vec2 g_vary_Texcoord0;
void main ()
{
  vec4 tmpvar_1_1;
  tmpvar_1_1.w = 1.0;
  tmpvar_1_1.xyz = (attPosition + attPositionOffset);
  g_vary_WorldPosition = (g_unif_ModelMat * tmpvar_1_1).xyz;
  g_vary_WorldNormal = (g_unif_NormalWorldMat * (attNormal + attNormalOffset));
  g_vary_Texcoord0 = attUV;
  gl_Position = (g_unif_ModelViewProjMat * tmpvar_1_1);
}

