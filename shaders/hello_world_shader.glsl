vec4 fragment (vec2 uv, vec2 fragCoord) {
    return vec4(uv.x, uv.y, 0., 1.);
}








// // time and mouse based
// uniform float u_time;
// uniform vec2 u_mouse;
// vec4 fragment (vec2 uv, vec2 fragCoord) {
//     return vec4(sin(u_time), sin(u_mouse.x), sin(u_mouse.y), 1.);
// }
