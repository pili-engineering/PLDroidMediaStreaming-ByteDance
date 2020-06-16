precision mediump float;
varying highp vec2 textureCoord;

uniform sampler2D srcImageTex;
uniform sampler2D lookUpCustom;

uniform lowp float whiten;

void main()
{
    vec3 colorEPM = texture2D(srcImageTex, textureCoord).rgb;
    highp float blueColor_custom = colorEPM.b * 63.0;
    highp vec2 quad1_custom;
    quad1_custom.y = floor(floor(blueColor_custom) / 8.0);
    quad1_custom.x = floor(blueColor_custom) - (quad1_custom.y * 8.0);
    highp vec2 quad2_custom;
    quad2_custom.y = floor(ceil(blueColor_custom) /8.0);
    quad2_custom.x = ceil(blueColor_custom) - (quad2_custom.y * 8.0);
    highp vec2 texPos1_custom;
    texPos1_custom.x = (quad1_custom.x * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * colorEPM.r);
    texPos1_custom.y = (quad1_custom.y * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * colorEPM.g);
    highp vec2 texPos2_custom;
    texPos2_custom.x = (quad2_custom.x * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * colorEPM.r);
    texPos2_custom.y = (quad2_custom.y * 1.0/8.0) + 0.5/512.0 + ((1.0/8.0 - 1.0/512.0) * colorEPM.g);
    vec3 newColor1 = texture2D(lookUpCustom, texPos1_custom).rgb;
    vec3 newColor2 = texture2D(lookUpCustom, texPos2_custom).rgb;
    lowp vec3 color_custom = mix(newColor1, newColor2, fract(blueColor_custom));
    colorEPM = mix(colorEPM, color_custom, whiten);
    
    gl_FragColor = vec4(colorEPM, 1.0);
}