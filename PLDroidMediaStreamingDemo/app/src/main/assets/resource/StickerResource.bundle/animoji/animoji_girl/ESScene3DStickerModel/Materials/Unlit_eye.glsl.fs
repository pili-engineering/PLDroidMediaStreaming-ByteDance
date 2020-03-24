#ifdef GL_ES
    precision highp float;
#endif
uniform sampler2D u_Tex;
varying highp vec2 g_vary_Texcoord0;
void main ()
{
  vec4 color_4_1;
  vec4 tmpvar_3_2;
  highp vec2 tmpvar_2_3;
  tmpvar_2_3.x = g_vary_Texcoord0.x;
  tmpvar_2_3.y = (1.0 - g_vary_Texcoord0.y);
  vec3 tmpvar_4;
  tmpvar_4 = pow (texture2D (u_Tex, tmpvar_2_3).xyz, vec3(2.2, 2.2, 2.2));
  tmpvar_3_2.xyz = tmpvar_4;
  tmpvar_3_2.w = 1.0;
  color_4_1.w = tmpvar_3_2.w;
  color_4_1.xyz = pow (tmpvar_4, vec3(0.4545454, 0.4545454, 0.4545454));
  color_4_1.xyz = clamp (color_4_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  vec4 tmpvar_5;
  tmpvar_5 = clamp (color_4_1, 0.0, 1.0);
  gl_FragColor = tmpvar_5;
}

