shader_type canvas_item;
uniform int iter;
uniform vec2 var; 
uniform vec2 where;
uniform float zoom;
uniform bool which;
uniform sampler2D tex;
uniform float power;
const float TAU = 6.283185307179586;

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
		// squared
		float x = (z.x * z.x - z.y * z.y) + c.x;
		float y = (z.y * z.x + z.x * z.y) + c.y;
		
		// cubed
//		float y = (( z.y * z.y * z.y ) - ( 3.0 * z.y * z.x * z.x )) - c.y;
//		float x = (( 3.0 * z.y * z.y * z.x ) - ( z.x * z.x * z.x )) - c.x;
		
		// nth power
		
//		float t = (z.x <= 0.0) ? ( 2.0 * atan(z.y/z.x)) : ( TAU/2.0 );
//		float r = sqrt(( z.x * z.x ) + ( z.y * z.y ));
//		float y = pow(r, 2.0) * cos( t );
//		float x = pow(r, 2.0) * sin( t );
		
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
		i = julia( UV / zoom + where );
	} else {
		i = brot( UV / zoom + where );
	}
	
	COLOR.rgba = texture(tex, sin( vec2( TAU * float(i) / 200.0 )));
//	vec3( (is_set) ? 0.0 : 1.0 );
}

void light() {
// Output:0

}
