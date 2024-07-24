shader_type canvas_item;

// Uniforms for grain effect
uniform sampler2D screen_texture : hint_screen_texture;
uniform float grain_amount : hint_range(0.0, 1.0) = 0.05; // Adjust the amount of grain
uniform float grain_size : hint_range(0.1, 10.0) = 1.0; // Adjust the size of the grain

// Uniforms for vignette effect
uniform float inner_radius = 0.1;
uniform float outer_radius = 1.0;
uniform float vignette_strength = 1.0;
uniform float dither_strength = 0.03;
uniform vec4 vignette_color : source_color;

void fragment() {
    // Sample the original screen texture
    vec4 original_color = texture(screen_texture, SCREEN_UV);

    // Generate random noise for grain effect
    float noise = (fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 2.0;

    // Add noise to the original color
    original_color.rgb += noise * grain_amount * grain_size;

    // Vignette effect calculation
    float dist = distance(UV, vec2(0.5));
    float vignette = smoothstep(inner_radius, outer_radius, dist) * vignette_strength;
    float dither = fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453123) * dither_strength;
    float final_vignette = vignette + dither;

    // Apply the vignette effect to the original color
    vec4 vignette_effect = vec4(vignette_color.rgb, final_vignette);
    original_color.rgb = mix(original_color.rgb, vignette_color.rgb, final_vignette);

    // Clamp the final color to make sure it stays in the valid range
    COLOR = clamp(original_color, 0.0, 1.0);
}
