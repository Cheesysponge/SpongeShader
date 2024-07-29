#version 460

in vec3 vaPosition;

in vec2 vaUV0;
in vec4 vaColor;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec2 texCoord;
out vec3 foliageColor;

void main() {
    foliageColor = vaColor.rgb;


    texCoord = vaUV0;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition,1);

}