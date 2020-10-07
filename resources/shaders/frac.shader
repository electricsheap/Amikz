shader_type canvas_item;
uniform int iter;
uniform vec2 var; 
uniform vec2 where;
uniform float zoom;
uniform bool which;
uniform sampler2D tex;


int julia( vec2 z ) {
    int i;
	vec2 c = var;
    for(i=0; i<iter; i++) {
        float x = (z.x * z.x - z.y * z.y) + c.x;
        float y = (z.y * z.x + z.x * z.y) + c.y;

        if((x * x + y * y) > 4.0) break;
        z.x = x;
        z.y = y;
    }

    return i;
}

int brot( vec2 c ) {
	int i;
	
	vec2 z = var;
	
	for(i=0; i<iter; i++) {
		float x = (z.x * z.x - z.y * z.y) + c.x;
		float y = (z.y * z.x + z.x * z.y) + c.y;

		if((x * x + y * y) > 4.0) break;
		z.x = x;
		z.y = y;
	}
	
	return i;
}

void vertex() {
// Output:0
}

void fragment() {
// Output:0
	vec2 z, c;
	
	int i;
	if (which) {
		i = julia( UV * zoom + where );
	} else {
		i = brot( UV * zoom + where );
	}
	
	COLOR.rgba = texture(tex, abs(sin(vec2(6.283185307179586 * (i == iter ? 0.0 : float(i)) / 200.0))), 0.0);
//	vec3( (is_set) ? 0.0 : 1.0 );
}

void light() {
// Output:0

}
