shader_type fog;

uniform float density : hint_range(-8.0, 8.0, 0.0001) = 1.0;
uniform float noise_scale: hint_range(0.0, 1.0, 0.001);
uniform float edge_fade : hint_range(0.0, 1.0, 0.0001);
uniform float height_falloff = 0.0;
uniform float flatness;
uniform vec3 noise_flow;
uniform bool emission_as_albedo;
uniform bool gradient_as_albedo;
uniform vec4 albedo : source_color = vec4(1.0);
uniform vec4 emission : source_color = vec4(0, 0, 0, 1);
uniform float emission_energy;
uniform sampler2D grad_tex;
uniform sampler3D density_texture:repeat_enable, hint_default_white;

void fog() {
	vec3 move_uv = noise_flow * TIME;
	float detail_noise = texture(density_texture, WORLD_POSITION.xyz*noise_scale + move_uv*0.5).r;
	detail_noise *= 0.2;
	float noise = texture(density_texture, WORLD_POSITION.xyz*noise_scale + move_uv + detail_noise).r;
	
	DENSITY = mix(1.0, noise, UVW.y*flatness);
	DENSITY *= clamp(exp2(-height_falloff * (WORLD_POSITION.y - OBJECT_POSITION.y)), 0.0, 1.0);
	//temp_uv.x = sin(vec3(0.5 * UVW.x * TIME, 0.0, 0.0)).g;
	DENSITY *= pow(clamp(-2.0 * SDF / min(min(SIZE.x, SIZE.y), SIZE.z), 0.0, 1.0), edge_fade);
	DENSITY *= density;
	
	vec3 col = texture(grad_tex, vec2(DENSITY, 0.5)).rgb;
	
	if (emission_as_albedo) {
		if (gradient_as_albedo)
		{
			EMISSION = col;
		} else
		{
				EMISSION = emission.rgb;
		}
		EMISSION = EMISSION * emission_energy;
		ALBEDO = EMISSION;
	}
	else
	{
		if (gradient_as_albedo) {
			ALBEDO = col;
		} else {
			ALBEDO = albedo.rgb;
		}
		EMISSION = emission.rgb * emission_energy;
	}
}
