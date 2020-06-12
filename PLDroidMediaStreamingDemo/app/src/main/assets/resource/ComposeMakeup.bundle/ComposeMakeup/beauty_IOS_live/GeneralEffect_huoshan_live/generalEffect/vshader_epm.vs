attribute vec3 attPosition;
attribute vec2 attUV;

varying vec2 textureCoord;

uniform float texEpmWidthOffset;
uniform float texEpmHeightOffset;

varying vec4 texEpmShift1;
varying vec4 texEpmShift2;
varying vec4 texEpmShift3;
varying vec4 texEpmShift4;

void main()
{
    gl_Position = vec4(attPosition, 1.0);
    textureCoord = attUV;
   
    texEpmShift1 = vec4(attUV + vec2(-texEpmWidthOffset, 0.0), attUV + vec2(texEpmWidthOffset, 0.0));
    texEpmShift2 = vec4(attUV + vec2(0.0, -texEpmHeightOffset), attUV + vec2(0.0, texEpmHeightOffset));
    texEpmShift3 = vec4(attUV + vec2(texEpmWidthOffset, texEpmHeightOffset), attUV + vec2(-texEpmWidthOffset, -texEpmHeightOffset));
    texEpmShift4 = vec4(attUV + vec2(-texEpmWidthOffset, texEpmHeightOffset), attUV + vec2(texEpmWidthOffset, -texEpmHeightOffset));
}
