#ifdef GL_ES
    precision highp float;
#endif
uniform vec3 _AE_DIRECTIONAL_LIGHTS_DIRECTION_[1];
uniform vec3 _AE_DIRECTIONAL_LIGHTS_COLOR_[1];
uniform float _AE_DIRECTIONAL_LIGHTS_INTENSITY_[1];
uniform highp mat4 _AE_DIRECTIONAL_LIGHT0_SHADOW_MATRIX_;
uniform highp float _AE_DIRECTIONAL_LIGHT0_SHADOW_ENABLED_;
uniform highp float _AE_DIRECTIONAL_LIGHT0_SHADOW_BIAS_;
uniform highp float _AE_DIRECTIONAL_LIGHT0_SHADOW_STRENGTH_;
uniform highp float _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFT_;
uniform highp float _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFTNESS_;
uniform sampler2D _AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_;
uniform highp float _AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_;
uniform sampler2D u_FaceTex;
uniform sampler2D u_SpecLUTTex;
uniform highp vec3 u_SkinColor;
uniform highp float u_SkinRoughness;
uniform highp float u_SkinRho;
uniform highp vec3 g_unif_CameraWorldPos;
varying highp vec3 g_vary_WorldPosition;
varying highp vec3 g_vary_WorldNormal;
varying highp vec2 g_vary_Texcoord0;
void main ()
{
  highp vec4 color_30_1;
  highp vec4 tmpvar_29_2;
  highp vec2 tmpvar_27_3;
  highp vec3 tmpvar_25_4;
  highp vec3 color_23_5;
  highp vec3 shadow_coord_14_6;
  highp float shadow_factor_13_7;
  highp float tmpvar_12_8;
  highp float tmpvar_10_0_9;
  highp vec3 tmpvar_9_0_10;
  highp vec3 tmpvar_8_0_11;
  highp vec2 tmpvar_5_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((g_unif_CameraWorldPos - g_vary_WorldPosition));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(g_vary_WorldNormal);
  tmpvar_5_12.x = g_vary_Texcoord0.x;
  tmpvar_5_12.y = (1.0 - g_vary_Texcoord0.y);
  vec3 tmpvar_15;
  tmpvar_15 = pow (texture2D (u_FaceTex, tmpvar_5_12).xyz, vec3(2.2, 2.2, 2.2));
  tmpvar_8_0_11 = normalize(-(_AE_DIRECTIONAL_LIGHTS_DIRECTION_[0]));
  tmpvar_9_0_10 = _AE_DIRECTIONAL_LIGHTS_COLOR_[0];
  tmpvar_10_0_9 = _AE_DIRECTIONAL_LIGHTS_INTENSITY_[0];
  if ((_AE_DIRECTIONAL_LIGHT0_SHADOW_ENABLED_ < 1.0)) {
    tmpvar_12_8 = 1.0;
  } else {
    highp float tmpvar_19_16;
    highp vec3 tmpvar_18_17;
    highp vec4 tmpvar_17_18;
    highp vec4 tmpvar_16_19;
    highp float tmpvar_20;
    tmpvar_20 = max (dot (tmpvar_14, tmpvar_8_0_11), 0.0);
    tmpvar_16_19.w = 1.0;
    tmpvar_16_19.xyz = g_vary_WorldPosition;
    tmpvar_17_18 = (_AE_DIRECTIONAL_LIGHT0_SHADOW_MATRIX_ * tmpvar_16_19);
    tmpvar_18_17 = (tmpvar_17_18.xyz / tmpvar_17_18.w);
    shadow_coord_14_6.xy = tmpvar_18_17.xy;
    shadow_coord_14_6.z = clamp (tmpvar_18_17.z, 0.0, 1.0);
    tmpvar_19_16 = (1.570796 - (sign(tmpvar_20) * (1.570796 - 
      (sqrt((1.0 - abs(tmpvar_20))) * (1.570796 + (abs(tmpvar_20) * (-0.2146018 + 
        (abs(tmpvar_20) * (0.08656672 + (abs(tmpvar_20) * -0.03102955)))
      ))))
    )));
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_AE_DIRECTIONAL_LIGHT0_SHADOW_BIAS_ + clamp (
      ((sin(tmpvar_19_16) / cos(tmpvar_19_16)) / 1000.0)
    , 0.0, 0.001)), 0.0, 1.0);
    shadow_factor_13_7 = 1.0;
    if ((0.0 < _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFT_)) {
      float tmpvar_22;
      tmpvar_22 = dot (texture2D (_AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_, tmpvar_18_17.xy), vec4(6.030863e-08, 1.53787e-05, 0.003921569, 1.0));
      if ((shadow_coord_14_6.z > (tmpvar_22 + tmpvar_21))) {
        shadow_factor_13_7 = (1.0 - ((
          (((shadow_coord_14_6.z - tmpvar_22) - tmpvar_21) / tmpvar_21)
         / _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFTNESS_) / 3.0));
        shadow_factor_13_7 = (1.0/((1.0 + exp(
          ((-(clamp (shadow_factor_13_7, 0.0, 1.0)) + 0.5) * 7.5)
        ))));
        shadow_factor_13_7 = (_AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_ + ((1.0 - _AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_) * shadow_factor_13_7));
        shadow_factor_13_7 = clamp (shadow_factor_13_7, 0.0, 1.0);
      };
    } else {
      float tmpvar_23;
      tmpvar_23 = dot (texture2D (_AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_, tmpvar_18_17.xy), vec4(6.030863e-08, 1.53787e-05, 0.003921569, 1.0));
      shadow_factor_13_7 = float((shadow_coord_14_6.z <= (tmpvar_23 + tmpvar_21)));
    };
    highp float tmpvar_24;
    tmpvar_24 = min (clamp ((tmpvar_20 - 0.01872654), 0.0, 1.0), shadow_factor_13_7);
    shadow_factor_13_7 = tmpvar_24;
    if ((tmpvar_24 < 1.0)) {
      shadow_factor_13_7 = mix (1.0, tmpvar_24, _AE_DIRECTIONAL_LIGHT0_SHADOW_STRENGTH_);
    };
    tmpvar_12_8 = shadow_factor_13_7;
  };
  tmpvar_25_4 = (tmpvar_8_0_11 + tmpvar_13);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(tmpvar_25_4);
  tmpvar_27_3.x = dot (tmpvar_14, tmpvar_25);
  tmpvar_27_3.y = (1.0 - u_SkinRoughness);
  highp float tmpvar_26;
  tmpvar_26 = pow ((1.0 - dot (tmpvar_13, tmpvar_25)), 5.0);
  float tmpvar_27;
  tmpvar_27 = pow ((2.0 * texture2D (u_SpecLUTTex, tmpvar_27_3).x), 10.0);
  color_23_5 = (((
    (((tmpvar_15 * u_SkinColor) + ((
      (max (0.0, dot (tmpvar_14, tmpvar_8_0_11)) * u_SkinRho)
     * 
      max (((tmpvar_27 * (tmpvar_26 + 
        (0.028 * (1.0 - tmpvar_26))
      )) / dot (tmpvar_25_4, tmpvar_25_4)), 0.0)
    ) * 10.0)) * clamp (((
      dot (tmpvar_14, tmpvar_8_0_11)
     * 0.5) + 0.5), 0.0, 1.0))
   * tmpvar_10_0_9) * tmpvar_9_0_10) * tmpvar_12_8);
  tmpvar_29_2.xyz = color_23_5;
  tmpvar_29_2.w = 1.0;
  color_30_1.w = tmpvar_29_2.w;
  color_30_1.xyz = pow (color_23_5, vec3(0.4545454, 0.4545454, 0.4545454));
  color_30_1.xyz = clamp (color_30_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  highp vec4 tmpvar_28;
  tmpvar_28 = clamp (color_30_1, 0.0, 1.0);
  gl_FragColor = tmpvar_28;
}

