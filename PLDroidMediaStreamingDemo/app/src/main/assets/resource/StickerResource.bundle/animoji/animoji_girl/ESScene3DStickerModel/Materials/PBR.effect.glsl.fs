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
uniform sampler2D u_RadianceTex;
uniform sampler2D u_IrradianceTex;
uniform sampler2D u_MRAOTex;
uniform sampler2D u_AlbedoTex;
uniform sampler2D u_NormalTex;
uniform sampler2D u_BentNormalTex;
uniform sampler2D u_EmissiveTex;
uniform highp vec3 u_Albedo;
uniform highp float u_Roughness;
uniform highp float u_Metallic;
uniform highp float u_Specular;
uniform highp float u_IBLIntensity;
uniform highp float u_EmissiveIntensity;
uniform highp float u_Alpha;
uniform highp float u_IBLOffset;
uniform highp float u_HorizonFade;
uniform highp float u_UsingBentNormal;
uniform highp float u_BentNormalFlatness;
uniform highp float u_UVTiling;
uniform highp vec3 g_unif_CameraWorldPos;
varying highp vec3 g_vary_WorldPosition;
varying highp vec3 g_vary_WorldNormal;
varying highp vec3 g_vary_WorldTangent;
varying highp vec3 g_vary_WorldBitangent;
varying highp vec2 g_vary_Texcoord0;
void main ()
{
  highp vec4 color_97_1;
  highp vec4 tmpvar_96_2;
  highp vec3 color_95_3;
  highp vec2 tmpvar_94_4;
  highp vec4 tmpvar_93_5;
  highp float tmpvar_91_6;
  highp float tmpvar_90_7;
  highp float tmpvar_89_8;
  highp float tmpvar_88_9;
  highp float tmpvar_57_10;
  highp float tmpvar_54_11;
  highp vec2 tmpvar_53_12;
  highp float tmpvar_52_13;
  highp float tmpvar_51_14;
  highp float tmpvar_50_15;
  highp float vec_x_49_16;
  highp vec3 I_47_17;
  highp vec2 coord_46_18;
  highp vec3 tmpvar_45_19;
  highp vec2 tmpvar_43_20;
  highp vec2 tmpvar_42_21;
  highp float tmpvar_41_22;
  highp float tmpvar_40_23;
  highp float tmpvar_39_24;
  highp float vec_x_38_25;
  vec3 tmpvar_37_26;
  highp vec3 shadow_coord_28_27;
  highp float shadow_factor_27_28;
  highp float tmpvar_26_29;
  highp float tmpvar_24_0_30;
  highp vec3 tmpvar_23_0_31;
  highp vec3 tmpvar_22_0_32;
  bool tmpvar_21_33;
  highp vec3 tmpvar_17_34;
  float tmpvar_16_35;
  highp float tmpvar_15_36;
  highp float tmpvar_14_37;
  highp float tmpvar_13_38;
  highp vec3 tmpvar_12_39;
  highp vec3 tmpvar_11_40;
  highp mat3 tmpvar_10_41;
  highp vec2 tmpvar_8_42;
  highp vec3 tmpvar_4_43;
  float DiffOcclusion_3_44;
  float SpecOcclusion_2_45;
  highp vec3 final_color_1_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize((g_unif_CameraWorldPos - g_vary_WorldPosition));
  tmpvar_10_41[0] = normalize(g_vary_WorldTangent);
  tmpvar_10_41[1] = normalize(g_vary_WorldBitangent);
  tmpvar_10_41[2] = normalize(g_vary_WorldNormal);
  tmpvar_8_42.x = g_vary_Texcoord0.x;
  tmpvar_8_42.y = (1.0 - g_vary_Texcoord0.y);
  tmpvar_17_34 = vec3(0.0, 0.0, 1.0);
  vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (tmpvar_8_42 * u_UVTiling);
  tmpvar_48 = texture2D (u_MRAOTex, P_49);
  vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (tmpvar_8_42 * u_UVTiling);
  tmpvar_50 = texture2D (u_AlbedoTex, P_51);
  vec3 tmpvar_52;
  tmpvar_52 = pow (tmpvar_50.xyz, vec3(2.2, 2.2, 2.2));
  tmpvar_11_40 = (tmpvar_52 * u_Albedo);
  tmpvar_14_37 = (tmpvar_48.x * u_Metallic);
  tmpvar_13_38 = (tmpvar_48.y * u_Roughness);
  tmpvar_16_35 = tmpvar_48.z;
  highp vec2 P_53;
  P_53 = (tmpvar_8_42 * u_UVTiling);
  vec3 tmpvar_54;
  tmpvar_54 = pow (texture2D (u_EmissiveTex, P_53).xyz, vec3(2.2, 2.2, 2.2));
  tmpvar_12_39 = (tmpvar_54 * u_EmissiveIntensity);
  tmpvar_15_36 = (tmpvar_50.w * u_Alpha);
  vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (tmpvar_8_42 * u_UVTiling);
  tmpvar_55 = texture2D (u_NormalTex, P_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = normalize((tmpvar_10_41 * (
    (tmpvar_55.xyz * 2.0)
   - 1.0)));
  if ((u_UsingBentNormal == 0.0)) {
    tmpvar_21_33 = bool(0);
  } else {
    tmpvar_21_33 = bool(1);
  };
  if (tmpvar_21_33) {
    vec4 tmpvar_58;
    highp vec2 P_59;
    P_59 = (tmpvar_8_42 * u_UVTiling);
    tmpvar_58 = texture2D (u_BentNormalTex, P_59);
    tmpvar_17_34 = normalize((tmpvar_10_41 * (
      (mix (tmpvar_58.xyz, vec3(0.0, 0.0, 1.0), u_BentNormalFlatness) * 2.0)
     - 1.0)));
  };
  tmpvar_22_0_32 = normalize(-(_AE_DIRECTIONAL_LIGHTS_DIRECTION_[0]));
  tmpvar_23_0_31 = _AE_DIRECTIONAL_LIGHTS_COLOR_[0];
  tmpvar_24_0_30 = _AE_DIRECTIONAL_LIGHTS_INTENSITY_[0];
  if ((_AE_DIRECTIONAL_LIGHT0_SHADOW_ENABLED_ < 1.0)) {
    tmpvar_26_29 = 1.0;
  } else {
    highp float tmpvar_33_60;
    highp vec3 tmpvar_32_61;
    highp vec4 tmpvar_31_62;
    highp vec4 tmpvar_30_63;
    highp float tmpvar_64;
    tmpvar_64 = max (dot (tmpvar_57, tmpvar_22_0_32), 0.0);
    tmpvar_30_63.w = 1.0;
    tmpvar_30_63.xyz = g_vary_WorldPosition;
    tmpvar_31_62 = (_AE_DIRECTIONAL_LIGHT0_SHADOW_MATRIX_ * tmpvar_30_63);
    tmpvar_32_61 = (tmpvar_31_62.xyz / tmpvar_31_62.w);
    shadow_coord_28_27.xy = tmpvar_32_61.xy;
    shadow_coord_28_27.z = clamp (tmpvar_32_61.z, 0.0, 1.0);
    tmpvar_33_60 = (1.570796 - (sign(tmpvar_64) * (1.570796 - 
      (sqrt((1.0 - abs(tmpvar_64))) * (1.570796 + (abs(tmpvar_64) * (-0.2146018 + 
        (abs(tmpvar_64) * (0.08656672 + (abs(tmpvar_64) * -0.03102955)))
      ))))
    )));
    highp float tmpvar_65;
    tmpvar_65 = clamp ((_AE_DIRECTIONAL_LIGHT0_SHADOW_BIAS_ + clamp (
      ((sin(tmpvar_33_60) / cos(tmpvar_33_60)) / 1000.0)
    , 0.0, 0.001)), 0.0, 1.0);
    shadow_factor_27_28 = 1.0;
    if ((0.0 < _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFT_)) {
      float tmpvar_66;
      tmpvar_66 = dot (texture2D (_AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_, tmpvar_32_61.xy), vec4(6.030863e-08, 1.53787e-05, 0.003921569, 1.0));
      if ((shadow_coord_28_27.z > (tmpvar_66 + tmpvar_65))) {
        shadow_factor_27_28 = (1.0 - ((
          (((shadow_coord_28_27.z - tmpvar_66) - tmpvar_65) / tmpvar_65)
         / _AE_DIRECTIONAL_LIGHT0_SHADOW_SOFTNESS_) / 3.0));
        shadow_factor_27_28 = (1.0/((1.0 + exp(
          ((-(clamp (shadow_factor_27_28, 0.0, 1.0)) + 0.5) * 7.5)
        ))));
        shadow_factor_27_28 = (_AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_ + ((1.0 - _AE_DIRECTIONAL_LIGHT0_SHADOW_INIT_STRENGTH_) * shadow_factor_27_28));
        shadow_factor_27_28 = clamp (shadow_factor_27_28, 0.0, 1.0);
      };
    } else {
      float tmpvar_67;
      tmpvar_67 = dot (texture2D (_AE_DIRECTIONAL_LIGHT0_SHADOW_TEXTURE_, tmpvar_32_61.xy), vec4(6.030863e-08, 1.53787e-05, 0.003921569, 1.0));
      shadow_factor_27_28 = float((shadow_coord_28_27.z <= (tmpvar_67 + tmpvar_65)));
    };
    highp float tmpvar_68;
    tmpvar_68 = min (clamp ((tmpvar_64 - 0.01872654), 0.0, 1.0), shadow_factor_27_28);
    shadow_factor_27_28 = tmpvar_68;
    if ((tmpvar_68 < 1.0)) {
      shadow_factor_27_28 = mix (1.0, tmpvar_68, _AE_DIRECTIONAL_LIGHT0_SHADOW_STRENGTH_);
    };
    tmpvar_26_29 = shadow_factor_27_28;
  };
  vec_x_38_25 = -(tmpvar_57.z);
  tmpvar_40_23 = (min (abs(
    (tmpvar_57.x / vec_x_38_25)
  ), 1.0) / max (abs(
    (tmpvar_57.x / vec_x_38_25)
  ), 1.0));
  tmpvar_41_22 = (tmpvar_40_23 * tmpvar_40_23);
  tmpvar_41_22 = (((
    ((((
      ((((-0.01213232 * tmpvar_41_22) + 0.05368138) * tmpvar_41_22) - 0.1173503)
     * tmpvar_41_22) + 0.1938925) * tmpvar_41_22) - 0.3326756)
   * tmpvar_41_22) + 0.9999793) * tmpvar_40_23);
  tmpvar_41_22 = (tmpvar_41_22 + (float(
    (abs((tmpvar_57.x / vec_x_38_25)) > 1.0)
  ) * (
    (tmpvar_41_22 * -2.0)
   + 1.570796)));
  tmpvar_39_24 = (tmpvar_41_22 * sign((tmpvar_57.x / vec_x_38_25)));
  highp float tmpvar_69;
  tmpvar_69 = abs(vec_x_38_25);
  highp float tmpvar_70;
  tmpvar_70 = abs(tmpvar_57.x);
  if ((tmpvar_69 > (1e-08 * tmpvar_70))) {
    if ((vec_x_38_25 < 0.0)) {
      if ((tmpvar_57.x >= 0.0)) {
        tmpvar_39_24 += 3.141593;
      } else {
        tmpvar_39_24 = (tmpvar_39_24 - 3.141593);
      };
    };
  } else {
    tmpvar_39_24 = (sign(tmpvar_57.x) * 1.570796);
  };
  tmpvar_42_21.x = (((tmpvar_39_24 / 3.141593) + 1.0) * 0.5);
  tmpvar_42_21.y = ((1.570796 - (
    sign(tmpvar_57.y)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(tmpvar_57.y)
    )) * (1.570796 + (
      abs(tmpvar_57.y)
     * 
      (-0.2146018 + (abs(tmpvar_57.y) * (0.08656672 + (
        abs(tmpvar_57.y)
       * -0.03102955))))
    ))))
  )) / 3.141593);
  tmpvar_43_20.x = (float(mod ((tmpvar_42_21.x + u_IBLOffset), 1.0)));
  tmpvar_43_20.y = tmpvar_42_21.y;
  vec4 tmpvar_71;
  tmpvar_71 = texture2D (u_IrradianceTex, tmpvar_43_20);
  tmpvar_37_26 = (tmpvar_71.xyz * exp2((
    (tmpvar_71.w * 255.0)
   - 128.0)));
  I_47_17 = -(tmpvar_47);
  highp vec3 tmpvar_72;
  tmpvar_72 = normalize((I_47_17 - (2.0 * 
    (dot (tmpvar_57, I_47_17) * tmpvar_57)
  )));
  vec_x_49_16 = -(tmpvar_72.z);
  tmpvar_51_14 = (min (abs(
    (tmpvar_72.x / vec_x_49_16)
  ), 1.0) / max (abs(
    (tmpvar_72.x / vec_x_49_16)
  ), 1.0));
  tmpvar_52_13 = (tmpvar_51_14 * tmpvar_51_14);
  tmpvar_52_13 = (((
    ((((
      ((((-0.01213232 * tmpvar_52_13) + 0.05368138) * tmpvar_52_13) - 0.1173503)
     * tmpvar_52_13) + 0.1938925) * tmpvar_52_13) - 0.3326756)
   * tmpvar_52_13) + 0.9999793) * tmpvar_51_14);
  tmpvar_52_13 = (tmpvar_52_13 + (float(
    (abs((tmpvar_72.x / vec_x_49_16)) > 1.0)
  ) * (
    (tmpvar_52_13 * -2.0)
   + 1.570796)));
  tmpvar_50_15 = (tmpvar_52_13 * sign((tmpvar_72.x / vec_x_49_16)));
  highp float tmpvar_73;
  tmpvar_73 = abs(vec_x_49_16);
  highp float tmpvar_74;
  tmpvar_74 = abs(tmpvar_72.x);
  if ((tmpvar_73 > (1e-08 * tmpvar_74))) {
    if ((vec_x_49_16 < 0.0)) {
      if ((tmpvar_72.x >= 0.0)) {
        tmpvar_50_15 += 3.141593;
      } else {
        tmpvar_50_15 = (tmpvar_50_15 - 3.141593);
      };
    };
  } else {
    tmpvar_50_15 = (sign(tmpvar_72.x) * 1.570796);
  };
  tmpvar_53_12.x = (((tmpvar_50_15 / 3.141593) + 1.0) * 0.5);
  tmpvar_53_12.y = ((1.570796 - (
    sign(tmpvar_72.y)
   * 
    (1.570796 - (sqrt((1.0 - 
      abs(tmpvar_72.y)
    )) * (1.570796 + (
      abs(tmpvar_72.y)
     * 
      (-0.2146018 + (abs(tmpvar_72.y) * (0.08656672 + (
        abs(tmpvar_72.y)
       * -0.03102955))))
    ))))
  )) / 3.141593);
  tmpvar_54_11 = (tmpvar_13_38 * 6.99);
  highp float tmpvar_75;
  tmpvar_75 = floor(tmpvar_54_11);
  highp float tmpvar_76;
  tmpvar_76 = exp2(tmpvar_75);
  tmpvar_57_10 = (tmpvar_76 * 2.0);
  coord_46_18.x = ((float(mod ((tmpvar_53_12.x + u_IBLOffset), 1.0))) / tmpvar_76);
  coord_46_18.y = (((tmpvar_53_12.y / tmpvar_57_10) + 1.0) - (1.0/(tmpvar_76)));
  vec4 tmpvar_77;
  tmpvar_77 = texture2D (u_RadianceTex, coord_46_18);
  coord_46_18.x = ((float(mod ((tmpvar_53_12.x + u_IBLOffset), 1.0))) / tmpvar_57_10);
  coord_46_18.y = (((tmpvar_53_12.y / 
    (tmpvar_57_10 * 2.0)
  ) + 1.0) - (1.0/(tmpvar_57_10)));
  vec4 tmpvar_78;
  tmpvar_78 = texture2D (u_RadianceTex, coord_46_18);
  highp float tmpvar_79;
  tmpvar_79 = clamp ((1.0 + (u_HorizonFade * 
    dot (tmpvar_57, tmpvar_72)
  )), 0.0, 1.0);
  vec3 x_80;
  x_80 = (tmpvar_77.xyz * exp2((
    (tmpvar_77.w * 255.0)
   - 128.0)));
  vec3 y_81;
  y_81 = (tmpvar_78.xyz * exp2((
    (tmpvar_78.w * 255.0)
   - 128.0)));
  tmpvar_45_19 = (mix (x_80, y_81, (tmpvar_54_11 - tmpvar_75)) * (tmpvar_79 * tmpvar_79));
  tmpvar_4_43 = (tmpvar_11_40 - (tmpvar_11_40 * vec3(tmpvar_14_37)));
  highp vec3 tmpvar_82;
  tmpvar_82 = mix (vec3((0.08 * u_Specular)), tmpvar_11_40, tmpvar_14_37);
  DiffOcclusion_3_44 = tmpvar_16_35;
  SpecOcclusion_2_45 = tmpvar_16_35;
  if (tmpvar_21_33) {
    highp float tmpvar_78_83;
    highp float tmpvar_76_84;
    highp float tmpvar_75_85;
    highp float tmpvar_73_86;
    highp float tmpvar_72_87;
    float tmpvar_71_88;
    highp float tmpvar_69_89;
    highp float tmpvar_68_90;
    highp float tmpvar_66_91;
    highp vec3 tmpvar_64_92;
    float tmpvar_63_93;
    highp float SpecOcclusion_62_94;
    tmpvar_63_93 = ((0.75 + (1.25 * 
      sqrt((1.0 - tmpvar_48.z))
    )) / tmpvar_48.z);
    tmpvar_64_92 = ((2.133 * tmpvar_57) + (tmpvar_63_93 * tmpvar_17_34));
    highp float tmpvar_95;
    tmpvar_95 = sqrt(dot (tmpvar_64_92, tmpvar_64_92));
    highp float tmpvar_96;
    tmpvar_96 = max (0.02, tmpvar_13_38);
    tmpvar_68_90 = (tmpvar_96 * tmpvar_96);
    tmpvar_69_89 = (tmpvar_68_90 * tmpvar_68_90);
    highp float tmpvar_97;
    tmpvar_97 = clamp ((abs(
      dot (tmpvar_57, tmpvar_47)
    ) + 1e-05), 0.0, 1.0);
    tmpvar_71_88 = (tmpvar_63_93 * 2.0);
    tmpvar_72_87 = ((2.0 / tmpvar_69_89) * 0.5);
    tmpvar_66_91 = ((1.0/((3.141593 * tmpvar_69_89))) * 1.009848);
    tmpvar_66_91 = (tmpvar_66_91 * (3.141593 / (
      (tmpvar_72_87 + ((tmpvar_63_93 * 2.0) * (tmpvar_97 * tmpvar_97)))
     * 
      (tmpvar_72_87 + tmpvar_71_88)
    )));
    highp float tmpvar_98;
    tmpvar_98 = max (0.02, tmpvar_13_38);
    tmpvar_75_85 = (tmpvar_98 * tmpvar_98);
    tmpvar_76_84 = (tmpvar_75_85 * tmpvar_75_85);
    highp float tmpvar_99;
    tmpvar_99 = clamp ((abs(
      dot (tmpvar_57, tmpvar_47)
    ) + 1e-05), 0.0, 1.0);
    tmpvar_78_83 = ((2.0 / tmpvar_76_84) * 0.5);
    tmpvar_73_86 = ((1.0/((3.141593 * tmpvar_76_84))) * 1.009848);
    tmpvar_73_86 = (tmpvar_73_86 * (3.141593 / (
      (tmpvar_78_83 + (1.62 * (tmpvar_99 * tmpvar_99)))
     * 
      (tmpvar_78_83 + 1.62)
    )));
    SpecOcclusion_62_94 = ((tmpvar_66_91 * exp(
      (((2.0 * (tmpvar_72_87 * tmpvar_71_88)) / (tmpvar_72_87 + tmpvar_71_88)) * (dot (tmpvar_57, normalize(
        (tmpvar_47 + tmpvar_17_34)
      )) - 1.0))
    )) / (tmpvar_73_86 * exp(
      (((tmpvar_78_83 * 3.24) / (tmpvar_78_83 + 1.62)) * (dot (tmpvar_57, normalize(
        (tmpvar_47 + tmpvar_57)
      )) - 1.0))
    )));
    highp float tmpvar_100;
    tmpvar_100 = clamp (SpecOcclusion_62_94, 0.0, 1.0);
    SpecOcclusion_62_94 = tmpvar_100;
    highp float tmpvar_101;
    tmpvar_101 = clamp (((
      ((exp((tmpvar_95 - 
        (2.133 + tmpvar_63_93)
      )) * 7.423718) / tmpvar_95)
     * 
      (1.0 - exp((-2.0 * tmpvar_95)))
    ) * 0.42277), 0.0, 1.0);
    DiffOcclusion_3_44 = tmpvar_101;
    SpecOcclusion_2_45 = tmpvar_100;
  };
  highp float tmpvar_102;
  tmpvar_102 = dot (tmpvar_57, tmpvar_22_0_32);
  highp float tmpvar_103;
  tmpvar_103 = dot (tmpvar_57, tmpvar_47);
  highp float tmpvar_104;
  tmpvar_104 = dot (tmpvar_22_0_32, tmpvar_47);
  highp float tmpvar_105;
  tmpvar_105 = inversesqrt((2.0 + (2.0 * tmpvar_104)));
  highp float tmpvar_106;
  tmpvar_106 = clamp (((tmpvar_102 + tmpvar_103) * tmpvar_105), 0.0001, 1.0);
  highp float tmpvar_107;
  tmpvar_107 = clamp (tmpvar_102, 0.0001, 1.0);
  highp float tmpvar_108;
  tmpvar_108 = clamp ((abs(tmpvar_103) + 1e-05), 0.0001, 1.0);
  tmpvar_88_9 = (tmpvar_13_38 * tmpvar_13_38);
  tmpvar_89_8 = (tmpvar_88_9 * tmpvar_88_9);
  tmpvar_90_7 = (((
    (tmpvar_106 * tmpvar_89_8)
   - tmpvar_106) * tmpvar_106) + 1.0);
  tmpvar_91_6 = (tmpvar_13_38 * tmpvar_13_38);
  highp float tmpvar_109;
  tmpvar_109 = pow ((1.0 - clamp (
    (tmpvar_105 + (tmpvar_105 * tmpvar_104))
  , 0.0001, 1.0)), 5.0);
  final_color_1_46 = (((
    ((((tmpvar_4_43 * 0.3183099) + (
      ((tmpvar_89_8 / ((3.141593 * tmpvar_90_7) * tmpvar_90_7)) * (0.5 / ((
        (tmpvar_107 * ((tmpvar_108 * (1.0 - tmpvar_91_6)) + tmpvar_91_6))
       + 
        (tmpvar_108 * ((tmpvar_107 * (1.0 - tmpvar_91_6)) + tmpvar_91_6))
      ) + 1e-05)))
     * 
      ((clamp ((50.0 * tmpvar_82.y), 0.0, 1.0) * tmpvar_109) + ((1.0 - tmpvar_109) * tmpvar_82))
    )) * tmpvar_107) * tmpvar_24_0_30)
   * tmpvar_23_0_31) * tmpvar_26_29) + tmpvar_12_39);
  final_color_1_46 = (final_color_1_46 + ((tmpvar_37_26 * tmpvar_4_43) * max (vec3(DiffOcclusion_3_44), 
    ((((
      (DiffOcclusion_3_44 * ((2.0404 * tmpvar_4_43) - 0.3324))
     + 
      ((-4.7951 * tmpvar_4_43) + 0.6417)
    ) * DiffOcclusion_3_44) + ((2.7552 * tmpvar_4_43) + 0.6903)) * DiffOcclusion_3_44)
  )));
  tmpvar_93_5 = ((tmpvar_13_38 * vec4(-1.0, -0.0275, -0.572, 0.022)) + vec4(1.0, 0.0425, 1.0, -0.04));
  tmpvar_94_4 = ((vec2(-1.04, 1.04) * (
    (min ((tmpvar_93_5.x * tmpvar_93_5.x), exp2((-9.28 * 
      max (dot (tmpvar_57, tmpvar_47), 0.0)
    ))) * tmpvar_93_5.x)
   + tmpvar_93_5.y)) + tmpvar_93_5.zw);
  final_color_1_46 = (final_color_1_46 + ((tmpvar_45_19 * 
    ((tmpvar_82 * tmpvar_94_4.x) + tmpvar_94_4.y)
  ) * max (vec3(SpecOcclusion_2_45), 
    ((((
      (SpecOcclusion_2_45 * ((2.0404 * tmpvar_82) - 0.3324))
     + 
      ((-4.7951 * tmpvar_82) + 0.6417)
    ) * SpecOcclusion_2_45) + ((2.7552 * tmpvar_82) + 0.6903)) * SpecOcclusion_2_45)
  )));
  color_95_3 = (final_color_1_46 * u_IBLIntensity);
  final_color_1_46 = ((color_95_3 * (
    (2.51 * color_95_3)
   + 0.03)) / ((color_95_3 * 
    ((2.43 * color_95_3) + 0.59)
  ) + 0.14));
  tmpvar_96_2.xyz = final_color_1_46;
  tmpvar_96_2.w = tmpvar_15_36;
  color_97_1.w = tmpvar_96_2.w;
  color_97_1.xyz = pow (final_color_1_46, vec3(0.4545454, 0.4545454, 0.4545454));
  color_97_1.xyz = clamp (color_97_1.xyz, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
  highp vec4 tmpvar_110;
  tmpvar_110 = clamp (color_97_1, 0.0, 1.0);
  gl_FragColor = tmpvar_110;
}

