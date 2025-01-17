#define PI 3.1415926535897932384626433832795

varying vec2  vUv;
uniform float uTime;

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

vec4 permute(vec4 x)
{
    return mod(((x*34.0)+1.0)*x, 289.0);
}

//	Classic Perlin 2D Noise 
//	by Stefan Gustavson
//
vec2 fade(vec2 t)
{
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float cnoise(vec2 P)
{
    vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
    vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
    Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
    vec4 ix = Pi.xzxz;
    vec4 iy = Pi.yyww;
    vec4 fx = Pf.xzxz;
    vec4 fy = Pf.yyww;
    vec4 i = permute(permute(ix) + iy);
    vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
    vec4 gy = abs(gx) - 0.5;
    vec4 tx = floor(gx + 0.5);
    gx = gx - tx;
    vec2 g00 = vec2(gx.x,gy.x);
    vec2 g10 = vec2(gx.y,gy.y);
    vec2 g01 = vec2(gx.z,gy.z);
    vec2 g11 = vec2(gx.w,gy.w);
    vec4 norm = 1.79284291400159 - 0.85373472095314 * vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
    g00 *= norm.x;
    g01 *= norm.y;
    g10 *= norm.z;
    g11 *= norm.w;
    float n00 = dot(g00, vec2(fx.x, fy.x));
    float n10 = dot(g10, vec2(fx.y, fy.y));
    float n01 = dot(g01, vec2(fx.z, fy.z));
    float n11 = dot(g11, vec2(fx.w, fy.w));
    vec2 fade_xy = fade(Pf.xy);
    vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
    float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
    return 2.3 * n_xy;
}


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
  // vec2 center = vec2(0.5);
  // float strength = 1. - step(0.01, abs(distance(vUv, center) - 0.25));

 // pattern 37
  // vec2 center = vec2(0.5);
  // vec2 waveUv = vec2(vUv.x, vUv.y + sin(vUv.x * 30.) * 0.1);
  // float strength = 1. - step(0.01, abs(distance(waveUv, center) - 0.25));

 // pattern 38
  // vec2 center = vec2(0.5);
  // vec2 waveUv = vec2(
  //   vUv.x + sin(vUv.y * 30.) * 0.1, 
  //   vUv.y + sin(vUv.x * 30.) * 0.1
  // );

  // float strength = 1. - step(0.01, abs(distance(waveUv, center) - 0.25));

 // pattern 39
  // vec2 center = vec2(0.5);
  // vec2 waveUv = vec2(
  //   vUv.x + sin(vUv.y * 100.) * 0.1, 
  //   vUv.y + sin(vUv.x * 100.) * 0.1
  // );

  // float strength = 1. - step(0.01, abs(distance(waveUv, center) - 0.25));

  // pattern 40
  // float strength = atan(vUv.x / vUv.y);

  // pattern 41
  // float strength = atan(vUv.x - 0.5, vUv.y - 0.5);

  // pattern 42
  // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
  // angle /= PI * 2.;
  // angle += 0.5;

  // float strength = angle;
  
  // or
  // float strength = 1. - abs(atan(vUv.x - 0.5, vUv.y - 0.5) / PI / 2. - 0.5);

  // pattern 43
  // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
  // angle /= PI * 2.;
  // angle += 0.5;
  // angle *= 20.;

  // float strength = mod(angle, 1.0);

  // pattern 44
  // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
  // angle /= PI * 2.;
  // angle += 0.5;

  // float strength = sin(angle *  100.);

 // pattern 45
  // vec2 center = vec2(0.5);

  // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
  // angle /= PI * 2.;
  // angle += 0.5;
  // float sinus = sin(angle *  100.);

  // float radius = 0.25 + sinus * 0.02;
  // float strength = 1. - step(0.01, abs(distance(vUv, center) - radius));

  // pattern 46
  // float strength = cnoise(vUv * 10.);

  // pattern 47
  // float strength = step(0., cnoise(vUv * 10.));

  // pattern 48
  // float strength = 1. - abs(cnoise(vUv * 10.));

  // pattern 49
  // float strength = step(0.95, 1. - abs(cnoise(vUv * 10.)));
  // float strength = sin(cnoise(vUv * 10.) * 20. + uTime * 2.);

  // pattern 50
  // float strength = step(0.95, 1. - abs(cnoise(vUv * 10.)));
  float strength = step(0.9, sin(cnoise(vUv * 10.) * 20. + uTime * 2.));

  // clamp the strength
  strength = clamp(strength, 0.0, 1.0);

  // colored
  vec3 blackColor = vec3(0.0);
  vec3 uvColor = vec3(vUv, 1.0);
  vec3 mixedColor = mix(blackColor, uvColor, strength);
  gl_FragColor = vec4(mixedColor, 1.0);

  // black and white
  // gl_FragColor = vec4(strength, strength, strength, 1.0);
}
