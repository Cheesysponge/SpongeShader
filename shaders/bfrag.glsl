 #version 460

in vec2 texCoord;
in vec3 foliageColor;
uniform sampler2D gtexture;

/* DRAWBUFFERS:0*/
layout(location = 0) out vec4 outColor0;
void main() {
    vec4 outputColorData = texture(gtexture, texCoord);
    vec3 outputColor = outputColorData.rgb*foliageColor;
    float transperency = outputColorData.a;
    if (transperency < 0.1){
        discard;
    }
    outColor0 = vec4(outputColor, transperency);

}