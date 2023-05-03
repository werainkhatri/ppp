/// written in GLSL, learn here: https://thebookofshaders.com

#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

// static
uniform vec2 resolution;
out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / resolution.xy;

  fragColor = vec4(uv.x, 0.0, uv.y, 1.0);
}







// dynamic - time and mouse based
// uniform vec2 resolution;
// uniform float u_time;
// uniform vec2 u_mouse;
// out vec4 fragColor;

// void main() {
//   vec2 uv = FlutterFragCoord().xy / resolution.xy;

//   fragColor = vec4(sin(u_time + uv.x + uv.y), sin(u_mouse.x + uv.x), sin(u_mouse.y + uv.y), 1.0);
// }