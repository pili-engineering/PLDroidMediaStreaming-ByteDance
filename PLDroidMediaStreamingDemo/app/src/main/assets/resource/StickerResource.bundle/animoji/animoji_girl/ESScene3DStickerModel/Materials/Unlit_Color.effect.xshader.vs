attribute vec3 attPosition;
attribute vec3 attPositionOffset;
uniform mat4 g_unif_ModelViewProjMat;
void main ()
{
  vec4 tmpvar_1_1;
  tmpvar_1_1.w = 1.0;
  tmpvar_1_1.xyz = (attPosition + attPositionOffset);
  gl_Position = (g_unif_ModelViewProjMat * tmpvar_1_1);
}

