shader_type canvas_item;
uniform int iter;
uniform vec2 var; 
uniform vec2 where;
uniform float zoom;
uniform bool which;
uniform sampler2D tex;
uniform float power;
uniform float bound;
const float TAU = 6.283185307179586;


vec3 mod289_3(vec3 x) {return x - floor(x * (1.0 / 289.0)) * 289.0;}

vec2 mod289_2(vec2 x) {return x - floor(x * (1.0 / 289.0)) * 289.0;}

vec3 permute(vec3 x) {return mod289_3(((x*34.0)+1.0)*x);}

float snoise(vec2 v) {
    vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                  0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                 -0.577350269189626,  // -1.0 + 2.0 * C.x
                  0.024390243902439); // 1.0 / 41.0
    // First corner
    vec2 i  = floor(v + dot(v, C.yy) );
    vec2 x0 = v -   i + dot(i, C.xx);
    
    // Other corners
    vec2 i1;
    //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
    //i1.y = 1.0 - i1.x;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    // x0 = x0 - 0.0 + 0.0 * C.xx ;
    // x1 = x0 - i1 + 1.0 * C.xx ;
    // x2 = x0 - 1.0 + 2.0 * C.xx ;
    vec4 x12 = vec4(x0.xy, x0.xy) + C.xxzz;
    x12.xy -= i1;
    
    // Permutations
    i = mod289_2(i); // Avoid truncation effects in permutation
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
    	+ i.x + vec3(0.0, i1.x, 1.0 ));
    
    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), vec3(0.0));
    m = m*m ;
    m = m*m ;
    
    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)
    
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    
    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
    
    // Compute final noise value at P
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

int julia( vec2 z, vec2 c ) {
    int i;
    for(i=0; i < min(iter, 1000); i++) {
		
		float x, y;
		// squared
		x = (z.x * z.x - z.y * z.y) + c.x;
		y = (z.y * z.x + z.x * z.y) + c.y;
//		y = (( z.y * z.y * z.y ) - ( 3.0 * z.y * z.x * z.x )) - c.y;
//		x = (( 3.0 * z.y * z.y * z.x ) - ( z.x * z.x * z.x )) - c.x;
//        float x = (z.x * z.x - z.y * z.y) + c.x;
//        float y = (z.y * z.x + z.x * z.y) + c.y;

        if((x * x + y * y) > 4.0) break;
        z.x = x;
        z.y = y;
    }

    return i;
}

int brot( vec2 c, vec2 z ) {
	int i;
	
	for(i=0; i < min(iter, 1000); i++) {
		
		float x, y;
		// squared
//		if ( power == 2.0 ) {
			x = (z.x * z.x - z.y * z.y) + c.x;
			y = (z.y * z.x + z.x * z.y) + c.y;
//		} else if ( power == 3.0 ) {
//			y = (( z.y * z.y * z.y ) - ( 3.0 * z.y * z.x * z.x )) - c.y;
//			x = (( 3.0 * z.y * z.y * z.x ) - ( z.x * z.x * z.x )) - c.x;
//		} else {
//			float t = power * atan(z.y / z.x);
//			float r = ( z.x * z.x ) + ( z.y * z.y );
//			y = pow( r, power / 2.0 ) * cos( t );
//			x = pow( r, power / 2.0 ) * sin( t );
//		}
		
		
		if((x * x + y * y) > bound) break;
		z.x = x;
		z.y = y;
	}
	
	return i;
}

void vertex() {}

void fragment() {
// Output:0
	vec2 z, c;
	
	int i, j, k, l;
	if (which) {
		i = julia( UV * exp2(zoom) + where /*vec2( snoise(UV  * exp2( zoom )), snoise(UV  * exp2( zoom ) + 10.0) )*/ + where, UV * var );
	} else {
		i = brot( UV * exp2(zoom) + where /*vec2( snoise(UV  * exp2( zoom )), snoise(UV  * exp2( zoom ) + 10.0) )*/ + where, UV * var );
	}
	
	COLOR.rgba = texture(tex, abs(sin( vec2( TAU * float(i) / 100.0))));
//	vec3( (is_set) ? 0.0 : 1.0 );
}

void light() {
// Output:0

}
