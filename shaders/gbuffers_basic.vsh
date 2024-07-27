#version 460

in vec3 vaPosition;

void main() {
    gl_Position = vec4(vaPosition,1);

}