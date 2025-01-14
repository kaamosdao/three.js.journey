#define PI 3.1415926535897932384626433832795

varying vec2  vUv;

float random(vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, float angle, vec2 pivot) {
  float s = sin(angle);
  float c = cos(angle);
  uv -= pivot;
  vec2 rotatedUV = vec2(
    uv.x * c - uv.y * s,
    uv.x * s + uv.y * c
  );
  return rotatedUV + pivot;
}

// or 
// vec2 rotate(vec2 uv, float rotation, vec2 mid)
// {
//     return vec2(
//       cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
//       cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
//     );
// }

void main() {
  // pattern 10
  // float strength = mod(vUv.y * 10.0, 1.0);
  // strength = step(0.8, strength);
 
  // pattern 11
//   float strengthY = mod(vUv.y * 10.0, 1.0);
//   strengthY = step(0.8, strengthY);

//   float strengthX = mod(vUv.x * 10.0, 1.0);
//   strengthX = step(0.8, strengthX);
 
//  float strength = strengthX + strengthY;

 // or
//  float strength = step(0.8, mod(vUv.x * 10.0, 1.0));
//  strength += step(0.8, mod(vUv.y * 10.0, 1.0));

  // pattern 13
//   float strengthY = mod(vUv.y * 10.0, 1.0);
//   strengthY = step(0.8, strengthY);

//   float strengthX = mod(vUv.x * 10.0, 1.0);
//   strengthX = step(0.4, strengthX);
 
//  float strength = strengthX * strengthY;

  // pattern 14
//   float strengthY = mod(vUv.y * 10.0, 1.0);
//   float strengthYFull = step(0.8, strengthY);
//   float strengthYHalf = step(0.4, strengthY);

//   float strengthX = mod(vUv.x * 10.0, 1.0);
//   float strengthXFull = step(0.8, strengthX);
//   float strengthXHalf = step(0.4, strengthX);
 
//  float strength = strengthYFull * strengthXHalf + strengthYHalf * strengthXFull;

  // pattern 15
//   float strengthY = step(0.8, mod(vUv.x * 10.0 + 0.2, 1.0));
//   strengthY *= step(0.4, mod(vUv.y * 10.0, 1.0));

//   float strengthX = step(0.4, mod(vUv.x * 10.0, 1.0));
//   strengthX *= step(0.8, mod(vUv.y * 10.0 + 0.2, 1.0));
  
//  float strength = strengthY + strengthX;

    // pattern 16
  // float strength = min(abs(vUv.x  - 0.5), abs(vUv.y  - 0.5));

    // pattern 19
  // float strength = step(0.2, max(abs(vUv.x  - 0.5), abs(vUv.y - 0.5)));

    // pattern 20
  // float strength1 = step(0.2, max(abs(vUv.x  - 0.5), abs(vUv.y  - 0.5)));

  // float strength2 =  1.0 - step(0.4, max(abs(vUv.x  - 0.5), abs(vUv.y  - 0.5)));

  // float strength = strength1 - strength2;
  // // float strength = strength1 * strength2;

  // pattern 21
  // float strength = floor(vUv.x * 10.) / 10.;

  // pattern 22
  // float strength = floor(vUv.x * 10.) / 10.;
  // strength *= floor(vUv.y * 10.) / 10.;

  // pattern 23
  // float strength = random(vUv); 

  // pattern 24
  // vec2 gridUv = vec2(floor(vUv.x * 10.) / 10., floor(vUv.y * 10.) / 10.);

  // pattern 25
  // vec2 gridUv = vec2(
  //   floor(vUv.x * 10.) / 10., 
  //   floor(vUv.y * 10. + vUv.x * 5.) / 10.
  // );

  // pattern 26
  // float strength = length(vUv);

  // pattern 27
  // vec2 center = vec2(0.5);
  // // float strength = length(vUv - center);

  // // or
  // float strength = distance(vUv, center);

  // pattern 28
  // vec2 center = vec2(0.5);
  // float strength = 1. - distance(vUv, center);

  // pattern 29
  // vec2 center = vec2(0.5);
  // float strength = 0.015 / (distance(vUv, center));

  // pattern 30
  // vec2 center = vec2(0.5, 0.5);
  // float strength = 0.015 / (distance(vec2(vUv.x * 0.1 + 0.45, vUv.y * 0.5 + 0.25), center));

  // pattern 31
  // vec2 center = vec2(0.5, 0.5);
  // float strength1 = 0.015 / (distance(vec2(vUv.x * 0.1 + 0.45, vUv.y * 0.5 + 0.25), center));
  // float strength2 = 0.015 / (distance(vec2(vUv.x * 0.5 + 0.25, vUv.y * 0.1 + 0.45), center));
  // float strength = strength1 * strength2;

  // pattern 32
  // vec2 center = vec2(0.5, 0.5);
  // vec2 rotatedUv = rotate(vUv, PI / 4., center);

  // vec2 vUv1 = vec2(rotatedUv.x * 0.1 + 0.45, rotatedUv.y * 0.5 + 0.25);
  // vec2 vUv2 = vec2(rotatedUv.x * 0.5 + 0.25, rotatedUv.y * 0.1 + 0.45);

  // float strength1 = 0.015 / (distance(vUv1, center));
  // float strength2 = 0.015 / (distance(vUv2, center));

  // float strength = (strength1 * strength2);

 // pattern 33
  // vec2 center = vec2(0.5);
  // float strength = step(0.25, distance(vUv, center));

 // pattern 34
  // vec2 center = vec2(0.5);
  // float strength = abs(distance(vUv, center) - 0.25);

 // pattern 35
  // vec2 center = vec2(0.5);
  // float strength = step(0.01, abs(distance(vUv, center) - 0.25));

 // pattern 36
  vec2 center = vec2(0.5);
  float strength = 1. - step(0.01, abs(distance(vUv, center) - 0.25));

  gl_FragColor = vec4(strength, strength, strength, 1.0);
}
