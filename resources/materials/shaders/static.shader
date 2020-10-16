shader_type canvas_item;
uniform float amount;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment()
{
	vec3 r = vec3(rand(UV + TIME + 0.1), rand(UV + TIME + 0.2), rand(UV + TIME));
	COLOR.rgb = COLOR.rgb * ( vec3(1.0) - (r * amount)  );
}