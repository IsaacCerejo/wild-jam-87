shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform bool disable_rotating = false;
uniform float area_scale = 1.5;
const vec2 shadow_offset = vec2(6.0, -10.0);

uniform vec4 shadow_color : source_color = vec4(0.263, 0.42, 0.447, 1.0);
uniform vec4 key_color : source_color = vec4(0.298, 0.498, 0.471, 1.0);
uniform float key_threshold = 0.02;

varying flat float sprite_rotation;

void vertex() {
	// Expand quad
	VERTEX.xy *= area_scale;

	// Store sprite rotation
	sprite_rotation = atan(MODEL_MATRIX[0][1], MODEL_MATRIX[0][0]);
}

vec2 rotate_point(vec2 p, float a) {
	float s = sin(a);
	float c = cos(a);
	return vec2(p.x * c - p.y * s, p.x * s + p.y * c);
}

void fragment() {
	// Recenter UVs after scaling
	vec2 centered_uv = (UV - 0.5) * area_scale + 0.5;

	// Shadow offset in screen space
	vec2 offset = disable_rotating
		? shadow_offset
		: rotate_point(shadow_offset, -sprite_rotation);

	vec2 uv = centered_uv + offset * TEXTURE_PIXEL_SIZE;

	// Sample shadow shape
	vec4 tex = texture(TEXTURE, uv);
	if (tex.a <= 0.0) {
		discard;
	}

	// Sample background
	vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);
	float diff = distance(bg.rgb, key_color.rgb);
	if (diff > key_threshold) {
		discard;
	}

	// Final shadow color
	COLOR = vec4(shadow_color.rgb, tex.a * shadow_color.a);
}
