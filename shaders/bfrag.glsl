 #version 460

uniform sampler2D lightmap; 
uniform sampler2D gtexture;

/* DRAWBUFFERS:0*/
layout(location = 0) out vec4 outColor0;

in vec2 texCoord;
in vec3 foliageColor;
in vec2 lightMapCoords;







void main() {
    vec4 outputColorData = pow(texture(gtexture, texCoord), vec4(2.2));


    vec3 lightColor = pow(texture(lightmap, lightMapCoords).rgb, vec3(2.2));
    
    vec3 outputColor = outputColorData.rgb*pow(foliageColor, vec3(2.2)) * lightColor;
    float transperency = outputColorData.a;
    if (transperency < 0.1){
        discard;
    }
    outColor0 = pow(vec4(outputColor, transperency), vec4(1/2.2));

}