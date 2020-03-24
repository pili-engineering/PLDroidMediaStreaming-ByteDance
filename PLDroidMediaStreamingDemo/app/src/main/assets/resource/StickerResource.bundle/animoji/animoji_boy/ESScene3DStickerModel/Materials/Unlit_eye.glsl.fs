#ifdef GL_ES
    precision highp float;
#endif
uniform sampler2D u_Tex;
varying highp vec2 g_vary_Texcoord0;
void main ()
{
  vec4 color_5_1;
  vec4 tmpvar_4_2;
  highp vec2 tmpvar_2_3;
  tmpvar_2_3.x = g_vary_Texcoord0.x;
  tmpvar_2_3.y = (1.0 - g_vary_Texcoord0.y);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (u_Tex, tmpvar_2_3);
  vec3 tmpvar_5;
  tmpvar_5 = pow (tmpvar_4.xyz, vec3(2.2, 2.2, 2.2));
  tmpvar_4_2.xyz = tmpvar_5;
  tmpvar_4_2.w = tmpvar_4.w;
  color_5_1.w = tmpvar_4_2.w;
  color_5_1.xyz = pow (tmpvar_5, vec3(0.4545454, 0.4545454, 0.4545454));
  color_5_1.xyz = clamp (color_5_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  vec4 tmpvar_6;
  tmpvar_6 = clamp (color_5_1, 0.0, 1.0);
  gl_FragColor = tmpvar_6;
}

