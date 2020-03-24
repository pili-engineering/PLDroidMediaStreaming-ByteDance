#ifdef GL_ES
    precision highp float;
#endif
uniform vec3 _AE_DIRECTIONAL_LIGHTS_DIRECTION_[1];
uniform vec3 _AE_DIRECTIONAL_LIGHTS_COLOR_[1];
uniform float _AE_DIRECTIONAL_LIGHTS_INTENSITY_[1];
uniform highp vec3 u_HairColorTint;
uniform sampler2D u_HairTex;
uniform sampler2D u_ShiftTex;
uniform highp float u_Shift;
uniform highp float u_ShiftTiling;
uniform highp float u_Shiftness;
uniform highp float u_Shininess1;
uniform highp float u_Shininess2;
uniform highp float u_SpecularIntensity;
uniform highp float u_AOIntensiy;
uniform highp vec3 g_unif_CameraWorldPos;
varying highp vec3 g_vary_WorldPosition;
varying highp vec3 g_vary_WorldNormal;
varying highp vec3 g_vary_WorldBitangent;
varying highp vec2 g_vary_Texcoord0;
void main ()
{
  highp vec4 color_25_1;
  highp vec4 tmpvar_24_2;
  highp vec3 color_15_3;
  highp vec3 tmpvar_12_0_4;
  highp float tmpvar_11_5;
  highp vec4 tmpvar_10_6;
  highp vec4 tmpvar_9_7;
  highp vec2 tmpvar_6_8;
  highp vec4 tmpvar_5_9;
  highp vec4 tmpvar_4_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(g_vary_WorldNormal);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(g_vary_WorldBitangent);
  tmpvar_6_8.x = g_vary_Texcoord0.x;
  tmpvar_6_8.y = (1.0 - g_vary_Texcoord0.y);
  tmpvar_9_7.w = tmpvar_4_10.w;
  tmpvar_10_6.w = tmpvar_5_9.w;
  vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_6_8 * u_ShiftTiling);
  tmpvar_13 = texture2D (u_ShiftTex, P_14);
  tmpvar_11_5 = ((tmpvar_13.x - 0.5) * u_Shiftness);
  tmpvar_9_7.xyz = normalize((tmpvar_12 + (
    (u_Shift + tmpvar_11_5)
   * tmpvar_11)));
  tmpvar_10_6.xyz = normalize((tmpvar_12 + (
    (u_Shift + tmpvar_11_5)
   * tmpvar_11)));
  tmpvar_12_0_4 = normalize(-(_AE_DIRECTIONAL_LIGHTS_DIRECTION_[0]));
  tmpvar_4_10 = tmpvar_9_7;
  tmpvar_5_9 = tmpvar_10_6;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_12_0_4 + normalize(
    (g_unif_CameraWorldPos - g_vary_WorldPosition)
  )));
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_9_7.xyz, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = clamp (sqrt((1.0 - 
    (tmpvar_16 * tmpvar_16)
  )), 0.0, 1.0);
  highp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_17 - -1.0) / 2.0), 0.0, 1.0);
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_10_6.xyz, tmpvar_15);
  highp float tmpvar_20;
  tmpvar_20 = clamp (sqrt((1.0 - 
    (tmpvar_19 * tmpvar_19)
  )), 0.0, 1.0);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((tmpvar_20 - -1.0) / 2.0), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = pow (texture2D (u_HairTex, tmpvar_6_8).xyz, vec3(2.2, 2.2, 2.2));
  color_15_3 = (((
    (tmpvar_22 + (((
      ((tmpvar_18 * (tmpvar_18 * (3.0 - 
        (2.0 * tmpvar_18)
      ))) * pow (tmpvar_17, u_Shininess1))
     * u_HairColorTint) + (
      ((tmpvar_21 * (tmpvar_21 * (3.0 - 
        (2.0 * tmpvar_21)
      ))) * pow (tmpvar_20, u_Shininess2))
     * 
      (u_HairColorTint * 0.5)
    )) * u_SpecularIntensity))
   * 
    pow (clamp (((
      dot (tmpvar_11, tmpvar_12_0_4)
     * 0.5) + 0.5), 0.0, 1.0), u_AOIntensiy)
  ) * _AE_DIRECTIONAL_LIGHTS_INTENSITY_[0]) * _AE_DIRECTIONAL_LIGHTS_COLOR_[0]);
  tmpvar_24_2.xyz = color_15_3;
  tmpvar_24_2.w = 1.0;
  color_25_1.w = tmpvar_24_2.w;
  color_25_1.xyz = pow (color_15_3, vec3(0.4545454, 0.4545454, 0.4545454));
  color_25_1.xyz = clamp (color_25_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  highp vec4 tmpvar_23;
  tmpvar_23 = clamp (color_25_1, 0.0, 1.0);
  gl_FragColor = tmpvar_23;
}

