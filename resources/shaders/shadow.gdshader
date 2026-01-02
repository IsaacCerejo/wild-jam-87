shader_type canvas_item;

render_mode blend_mix;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
const vec4 tint_color = vec4(0.263, 0.42, 0.447, 1.0);  // The color to recolor the sprite
const vec4 key_color = vec4(0.298, 0.498, 0.471, 1.0);   // Background color to render over
const float key_threshold = 0.02;                                 // Allowed difference for key match

void fragment() {
    // Load sprite pixel
    vec4 tex_color = texture(TEXTURE, UV);

    // Get screen background color behind this pixel
    vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Compare background with key color
    float diff = distance(bg.rgb, key_color.rgb);

    // If background doesn't match the key color, discard the pixel
    if (diff > key_threshold) {
        discard;
    }

    // Apply tint color to the sprite
    vec4 final_color = vec4(tint_color.rgb, tex_color.a * tint_color.a);

    COLOR = final_color;
}