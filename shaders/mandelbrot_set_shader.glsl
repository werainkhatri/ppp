#define N 64.
#define B 4.

vec4 fragment (vec2 uv, vec2 fragCoord) {
  vec2 R = fragCoord / uv;
  vec2 uv2 = (2. * fragCoord - R - 1.) / R.y;
  vec2 z = vec2(0), c = uv2;
  float i2 = -1.;

  for(float i=0.; i < N; ++i) {
      z = mat2(z, -z.y, z.x) * z + c;
      if(dot(z, z) > B*B) {
        i2 = i;
        break;
      }
  }

  if(i2==N) { i2 = 0.; } // mark interior black
  return vec4(vec3(i2/N), 1.);
}