#version 320 es

#include <flutter/runtime_effect.glsl>

precision highp float;

uniform sampler2D uTexture;
uniform vec2 uResolution;
uniform vec4 uRegion; // xy origin (uv), zw size (uv)
uniform float uTime;
uniform float uRefraction;
uniform float uMagnification;

out vec4 fragColor;

vec2 clampUV(vec2 uv) {
  return clamp(uv, vec2(0.0), vec2(1.0));
}

void main() {
  vec2 pixel = FlutterFragCoord().xy;
  vec2 uv = pixel / uResolution;

  // Normalize within lens
  vec2 center = vec2(0.5);
  vec2 delta = uv - center;
  float dist = length(delta);

  // Refraction intensity falls off towards the edge
  float rim = smoothstep(0.0, 1.0, 1.0 - dist);
  float refraction = uRefraction * rim;

  // Animated ripple distortion
  float wave = sin(dist * 22.0 - uTime * 2.5) * 0.006;
  vec2 direction = normalize(delta + 1e-6);
  vec2 displaced = uv + direction * (refraction + wave);

  // Magnification around center
  displaced = (displaced - center) * uMagnification + center;

  // Clamp displacement back into lens
  displaced = clamp(displaced, vec2(0.0), vec2(1.0));

  // Map lens UV into captured background region
  vec2 sampleUV = uRegion.xy + displaced * uRegion.zw;
  sampleUV = clampUV(sampleUV);

  vec4 baseColor = texture(uTexture, sampleUV);

  // Specular highlight that sweeps across the surface
  vec2 highlightDir = normalize(vec2(0.6, -0.8));
  float highlight = dot(normalize(delta + 1e-6), highlightDir);
  highlight = pow(max(0.0, highlight), 6.0) * rim;
  highlight *= 0.4 + 0.6 * sin(uTime * 1.2 + dot(delta, vec2(18.0, 22.0)));
  highlight = clamp(highlight, 0.0, 0.4);

  vec3 finalColor = baseColor.rgb + vec3(highlight);
  fragColor = vec4(finalColor, baseColor.a);
}
