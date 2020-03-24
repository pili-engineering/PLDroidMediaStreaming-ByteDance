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
uniform sampler2D u_MaskTex;
uniform highp vec3 u_SkinColor;
uniform highp float u_SkinRoughness;
uniform highp float u_SkinRho;
uniform highp float u_LipRoughness;
uniform highp float u_LipRho;
uniform highp vec3 g_unif_CameraWorldPos;
varying highp vec3 g_vary_WorldPosition;
varying highp vec3 g_vary_WorldNormal;
varying highp vec2 g_vary_Texcoord0;
void main ()
{
  highp vec4 color_32_1;
  highp vec4 tmpvar_31_2;
  highp vec2 tmpvar_29_3;
  highp vec3 tmpvar_27_4;
  highp vec3 color_25_5;
  highp vec3 shadow_coord_16_6;
  highp float shadow_factor_15_7;
  highp float tmpvar_14_8;
  highp float tmpvar_12_0_9;
  highp vec3 tmpvar_11_0_10;
  highp vec3 tmpvar_10_0_11;
  vec4 tmpvar_9_12;
  highp vec2 tmpvar_6_13;
  vec4 tmpvar_4_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((g_unif_CameraWorldPos - g_vary_WorldPosition));
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(g_vary_WorldNormal);
  tmpvar_6_13.x = g_vary_Texcoord0.x;
  tmpvar_6_13.y = (1.0 - g_vary_Texcoord0.y);
  tmpvar_9_12.yzw = tmpvar_4_14.yzw;
  vec3 tmpvar_17;
  tmpvar_17 = pow (texture2D (u_FaceTex, tmpvar_6_13).xyz, vec3(2.2, 2.2, 2.2));
  tmpvar_9_12.x = pow (texture2D (u_MaskTex, tmpvar_6_13).w, 2.2);
  tmpvar_10_0_11 = normalize(-(_AE_DIRECTIONAL_LIGHTS_DIRECTION_[0]));
  tmpvar_11_0_10 = _AE_DIRECTIONAL_LIGHTS_COLOR_[0];
  tmpvar_12_0_9 = _AE_DIRECTIONAL_LIGHTS_INTENSITY_[0];
  if ((_AE_DIRECTIONAL_LIGHT0_SHADOW_ENABLED_ < 1.0)) {
    tmpvar_14_8 = 1.0;
  } else {
    highp float tmpvar_21_18;
    highp vec3 tmpvar_20_19;
    highp vec4 tmpvar_19_20;
    highp vec4 tmpvar_18_21;
    highp float tmpvar_22;
    tmpvar_22 = max (dot (tmpvar_16, tmpvar_10_0_11), 0.0);
    tmpvar_18_21.w = 1.0;
    tmpvar_18_21.xyz = g_vary_WorldPosition;
    tmpvar_19_20 = (_AE_DIRECTIONAL_LIGHT0_SHADOW_MATRIX_ * tmpvar_18_21);
    tmpvar_20_19 = (tmpvar_19_20.xyz / tmpvar_19_20.w);
    shadow_coord_16_6.xy = tmpvar_20_19.xy;
    shadow_coord_16_6.z = clamp (tmpvar_20_19.z, 0.0, 1.0);
    tmpvar_21_18 = (1.570796 - (sign(tmpvar_22) * (1.570796 - 
      (sqrt((1.0 - abs(tmpvar_22))) * (1.570796 + (abs(tmpvar_22) * (-0.2146018 + 
        (abs(tmpvar_22) * (0.08656672 + (abs(tmpvar_22) * -0.03102955)))
      ))))
    )));
    highp float tmpvar_23;
    tmpvar_23 = clamp ((_AE_DIRECTIONAL_LIGHT0_SHADOW_BIAS_ + clamp (
      ((sin(tmpvar_21_18) / cos(tmpvar_21_18)) / 1000.0)
    , 0.0, 0.001)), 0.0, 1.0);
    shadow_factor_15_7 = 1.0;
    if ((0.0 < _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFT_)) {
      float tmpvar_24;
      tmpvar_24 = dot (texture2D (_AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_, tmpvar_20_19.xy), vec4(6.030863e-08, 1.53787e-05, 0.003921569, 1.0));
      if ((shadow_coord_16_6.z > (tmpvar_24 + tmpvar_23))) {
        shadow_factor_15_7 = (1.0 - ((
          (((shadow_coord_16_6.z - tmpvar_24) - tmpvar_23) / tmpvar_23)
         / _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFTNESS_) / 3.0));
        shadow_factor_15_7 = (1.0/((1.0 + exp(
          ((-(clamp (shadow_factor_15_7, 0.0, 1.0)) + 0.5) * 7.5)
        ))));
        shadow_factor_15_7 = (_AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_ + ((1.0 - _AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_) * shadow_factor_15_7));
        shadow_factor_15_7 = clamp (shadow_factor_15_7, 0.0, 1.0);
      };
    } else {
      float tmpvar_25;
      tmpvar_25 = dot (texture2D (_AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_, tmpvar_20_19.xy), vec4(6.030863e-08, 1.53787e-05, 0.003921569, 1.0));
      shadow_factor_15_7 = float((shadow_coord_16_6.z <= (tmpvar_25 + tmpvar_23)));
    };
    highp float tmpvar_26;
    tmpvar_26 = min (clamp ((tmpvar_22 - 0.01872654), 0.0, 1.0), shadow_factor_15_7);
    shadow_factor_15_7 = tmpvar_26;
    if ((tmpvar_26 < 1.0)) {
      shadow_factor_15_7 = mix (1.0, tmpvar_26, _AE_DIRECTIONAL_LIGHT0_SHADOW_STRENGTH_);
    };
    tmpvar_14_8 = shadow_factor_15_7;
  };
  tmpvar_4_14 = tmpvar_9_12;
  tmpvar_27_4 = (tmpvar_10_0_11 + tmpvar_15);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_27_4);
  tmpvar_29_3.x = dot (tmpvar_16, tmpvar_27);
  tmpvar_29_3.y = (1.0 - mix (u_SkinRoughness, u_LipRoughness, tmpvar_9_12.x));
  highp float tmpvar_28;
  tmpvar_28 = pow ((1.0 - dot (tmpvar_15, tmpvar_27)), 5.0);
  float tmpvar_29;
  tmpvar_29 = pow ((2.0 * texture2D (u_SpecLUTTex, tmpvar_29_3).x), 10.0);
  color_25_5 = (((
    (((tmpvar_17 * u_SkinColor) + ((
      (max (0.0, dot (tmpvar_16, tmpvar_10_0_11)) * mix (u_SkinRho, u_LipRho, tmpvar_9_12.x))
     * 
      max (((tmpvar_29 * (tmpvar_28 + 
        (0.028 * (1.0 - tmpvar_28))
      )) / dot (tmpvar_27_4, tmpvar_27_4)), 0.0)
    ) * 10.0)) * clamp (((
      dot (tmpvar_16, tmpvar_10_0_11)
     * 0.5) + 0.5), 0.0, 1.0))
   * tmpvar_12_0_9) * tmpvar_11_0_10) * tmpvar_14_8);
  tmpvar_31_2.xyz = color_25_5;
  tmpvar_31_2.w = 1.0;
  color_32_1.w = tmpvar_31_2.w;
  color_32_1.xyz = pow (color_25_5, vec3(0.4545454, 0.4545454, 0.4545454));
  color_32_1.xyz = clamp (color_32_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  highp vec4 tmpvar_30;
  tmpvar_30 = clamp (color_32_1, 0.0, 1.0);
  gl_FragColor = tmpvar_30;
}

