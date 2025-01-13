varying vec2  vUv;

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
  float strength = floor(vUv.x * 10.) / 10.;
  strength *= floor(vUv.y * 10.) / 10.;
 

  gl_FragColor = vec4(strength, strength, strength, 1.0);
}
