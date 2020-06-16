precision mediump float;
varying highp vec2 textureCoord;

varying highp vec4 texEpmShift1;
varying highp vec4 texEpmShift2;
varying highp vec4 texEpmShift3;
varying highp vec4 texEpmShift4;

uniform sampler2D srcImageTex;
uniform sampler2D blurImageTex;

uniform lowp float blurAlpha;
uniform highp float sharpen;

const float theta = 0.1;

void main()
{
    //firstly, smooth
    lowp vec4 preColor = texture2D(blurImageTex, textureCoord);
    
    lowp vec4 inColor = texture2D(srcImageTex, textureCoord);
    lowp vec3 meanColor = preColor.rgb;

    
    mediump float p = clamp((min(inColor.r, meanColor.r-0.1)-0.2)*4.0, 0.0, 1.0);
    mediump float kMin = (1.0 - preColor.a / (preColor.a + theta)) * p * blurAlpha;
    
    lowp vec3 smoothColor = mix(inColor.rgb, meanColor.rgb, kMin);
    
    //secondly, sharpen
    mediump float epmSum = 0.25 * inColor.g;
    epmSum += 0.125 * texture2D(srcImageTex, texEpmShift1.xy).g;
    epmSum += 0.125 * texture2D(srcImageTex, texEpmShift1.zw).g;
    epmSum += 0.125 * texture2D(srcImageTex, texEpmShift2.xy).g;
    epmSum += 0.125 * texture2D(srcImageTex, texEpmShift2.zw).g;
    epmSum += 0.0625 * texture2D(srcImageTex, texEpmShift3.xy).g;
    epmSum += 0.0625 * texture2D(srcImageTex, texEpmShift3.zw).g;
    epmSum += 0.0625 * texture2D(srcImageTex, texEpmShift4.xy).g;
    epmSum += 0.0625 * texture2D(srcImageTex, texEpmShift4.zw).g;
    
    float hPass = inColor.g - epmSum + 0.5;
    float flag = step(0.5, hPass);
    
    highp vec3 tmpColor = vec3(2.0 * hPass + smoothColor - 1.0);
    highp vec3 sharpColor = mix(max(vec3(0.0), tmpColor), min(vec3(1.0), tmpColor), flag);

    gl_FragColor = vec4(mix(smoothColor.rgb, sharpColor, sharpen), 1.0);
}