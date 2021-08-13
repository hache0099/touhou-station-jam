shader_type canvas_item;

uniform float width;
uniform vec4 outline_color : hint_color;
 
void fragment()
{
	vec2 size = (vec2(width) * TEXTURE_PIXEL_SIZE);
   
	vec4 sprite_color = texture(TEXTURE, UV);
   
	float alpha = sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
	alpha += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	alpha += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
	alpha += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	alpha += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
   
	vec3 final_color = mix(outline_color.rgb, sprite_color.rgb, sprite_color.a);
	COLOR = vec4(final_color, clamp(alpha, 0.0, 1.0));
}