#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

// #define N 64.
// #define B 4.
#define maxIterations 100.

out vec4 fragColor;

uniform vec2 resolution;

vec2 squareImaginary(vec2 number) {
	return vec2(
		pow(number.x,2)-pow(number.y,2),
		2*number.x*number.y
	);
}

float iterateMandelbrot(vec2 coord) {
	vec2 z = vec2(0,0);
	for(float i=0;i<maxIterations;i++){
		z = squareImaginary(z) + coord;
		if(length(z)>2) return i/maxIterations;
	}
	return maxIterations;
}

// vec4 fragment (vec2 uv, vec2 fragCoord) {
//   vec2 R = resolution;
//   vec2 uv2 = (2. * fragCoord - R - 1.) / R.y;
//   vec2 z = vec2(0), c = uv2;
//   float i2 = -1.;

//   for(float i=0.; i < N; ++i) {
//     z = mat2(z, -z.y, z.x) * z + c;
//     if(dot(z, z) > B*B) {
//       i2 = i;
//       break;
//     }
//   }

//   if(i2==N) { i2 = 0.; } // mark interior black
//   return vec4(vec3(i2/N), 1.);
// }

void main() {
  vec2 uv = FlutterFragCoord().xy / resolution.xy;
  vec2 fragCoord = FlutterFragCoord().xy;

  // scales uv from (0,1) to (-1,1) [both x and y as this assumes the canvas
  // is a square].
  vec2 uv2 = 4. * (uv - vec2(.5));

  fragColor = vec4(vec3(iterateMandelbrot(uv2)), 1.);
}
