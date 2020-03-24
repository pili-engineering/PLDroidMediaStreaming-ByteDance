#ifdef GL_ES
    precision highp float;
#endif
uniform highp vec3 u_Albedo;
uniform highp float u_Alpha;
void main ()
{
  highp vec4 color_3_1;
  highp vec4 tmpvar_2_2;
  highp vec3 final_color_1_3;
  final_color_1_3 = ((u_Albedo * (
    (2.51 * u_Albedo)
   + 0.03)) / ((u_Albedo * 
    ((2.43 * u_Albedo) + 0.59)
  ) + 0.14));
  tmpvar_2_2.xyz = final_color_1_3;
  tmpvar_2_2.w = u_Alpha;
  color_3_1.w = tmpvar_2_2.w;
  color_3_1.xyz = pow (final_color_1_3, vec3(0.4545454, 0.4545454, 0.4545454));
  color_3_1.xyz = clamp (color_3_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  highp vec4 tmpvar_4;
  tmpvar_4 = clamp (color_3_1, 0.0, 1.0);
  gl_FragColor = tmpvar_4;
}

