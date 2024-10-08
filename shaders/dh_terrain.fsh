 #version 460 compatibility
 
uniform sampler2D lightmap;
uniform sampler2D depthtex0;
uniform float viewHeight;
uniform float viewWidth;
uniform vec3 fogColor;

/* DRAWBUFFERS:0*/
layout(location = 0) out vec4 outColor0;

in vec4 blockColor;
in vec2 lightMapCoords;
in vec3 viewSpacePosition;


void main() {
    
    
    vec3 lightColor = pow(texture(lightmap, lightMapCoords).rgb, vec3(2.2));
    
    
    vec4 outputColorData = blockColor;
    vec3 outputColor = pow(outputColorData.rgb,vec3(2.2)) * lightColor;
    float transperency = outputColorData.a;


    if (transperency < 0.1){
        discard;
    }

    vec2 texCoord = gl_FragCoord.xy/ vec2(viewWidth,viewHeight);
    float depth = texture(depthtex0, texCoord).r;

    if(depth!=1.0){
        discard;
    }
    
    
    float distanceFromCamera = distance(vec3(0), viewSpacePosition);

    float maxFogDistance = 4000;
    float minFogDistance = 2500;
    float fogBlendValue = clamp((distanceFromCamera-minFogDistance) / (maxFogDistance - minFogDistance), 0 ,1);



    outputColor = mix(outputColor,pow(fogColor, vec3(2.2)),fogBlendValue);

    outColor0 = pow(vec4(outputColor, transperency), vec4(1/2.2));

}