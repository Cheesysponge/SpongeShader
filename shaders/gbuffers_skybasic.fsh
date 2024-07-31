#version 460 compatibility

uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform vec3 skyColor;

in vec4 starData; //rgb = star color, a = flag for whether or not this pixel is a star.

float fogify(float x, float w) {
	return w / (x * x + w);
}

vec3 calcSkyColor(vec3 pos) {
    vec3 newSkyColor = skyColor;
    newSkyColor = vec3(0.1,0.06,0.06);
    vec3 newFogColor = vec3(0.24,0.12,0.02);
	float upDot = dot(pos, gbufferModelView[1].xyz); //not much, what's up with you?
	return mix(newSkyColor, newFogColor, fogify(max(upDot, 0.0), 0.25));
}

vec3 screenToView(vec3 screenPos) {
	vec4 ndcPos = vec4(screenPos, 1.0) * 2.0 - 1.0;
	vec4 tmp = gbufferProjectionInverse * ndcPos;
	return tmp.xyz / tmp.w;
}

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;

void main() {
	if (starData.a > 0.5) {
		color = vec4(starData.rgb, 1.0);
	} else {
		vec3 pos = screenToView(vec3(gl_FragCoord.xy / vec2(viewWidth, viewHeight), 1.0));
		color = vec4(calcSkyColor(normalize(pos)), 1.0);
	}
}