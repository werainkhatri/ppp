/// created using umbra_cli: https://pub.dev/packages/umbra_cli
/// written in GLSL, learn here: https://thebookofshaders.com

/// create shader file:
/// $ umbra create hello_world_shader

/// generate flutter widget from shader:
/// $ umbra generate --target flutter-widget \
///      shaders/hello_world_shader.glsl --output lib/shader_widgets

// vec4 fragment (vec2 uv, vec2 fragCoord) {
//     return vec4(uv.x, uv.y, 0.0, 1.0);
// }

// time and mouse based
uniform float u_time;
uniform vec2 u_mouse;
vec4 fragment (vec2 uv, vec2 fragCoord) {
    return vec4(sin(u_time), sin(u_mouse.x), sin(u_mouse.y), 1.0);
}

