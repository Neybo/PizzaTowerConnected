#define Transparent vec4(.0,.0,.0,.0)
#define Tolerance 0.004 
//If you feel like your colors should be matching but aren't, increase this number a bit.

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_palTexture;
uniform vec4 u_Uvs;
uniform float u_paletteId;
uniform vec2 u_pixelSize;

// New uniforms for the alternative mode
uniform bool u_altMode; // A boolean flag to switch between modes
uniform vec4 u_targetColor; // The color to be replaced by the texture
uniform sampler2D u_altTexture; // The texture to replace the color with
uniform vec2 u_altScale; // The scaling factor for the texture

vec4 findAltColor(vec4 inCol, vec2 corner)
{
    if(inCol.a == 0.) return Transparent;
    
    float dist;
    vec2 testPos;
    vec4 leftCol;
    for(float i = corner.y; i < u_Uvs.w; i+=u_pixelSize.y )
    {
			testPos = vec2(corner.x,i);
      leftCol = texture2D( u_palTexture, testPos);
        
			dist = distance(leftCol,inCol);

			if(dist < Tolerance)
      {
				testPos = vec2(corner.x + u_pixelSize.x * floor(u_paletteId + 1.0), i);
        return mix(texture2D(u_palTexture, vec2(testPos.x - u_pixelSize.x, testPos.y)), texture2D(u_palTexture, testPos), fract(u_paletteId));
      }
    }
    return inCol;
}

// New function to replace a color by a texture
vec4 replaceByTexture(vec4 inCol)
{
    // Check if the input color is close enough to the target color
    if (distance(inCol, u_targetColor) < Tolerance)
    {
        // Get the scaled texture coordinate
        vec2 texCoord = v_vTexcoord * u_altScale;
        // Sample the texture color at that coordinate
        vec4 texCol = texture2D(u_altTexture, texCoord);
        // Return the texture color with the input alpha
        return vec4(texCol.rgb, inCol.a);
    }
    else
    {
        // Return the input color unchanged
        return inCol;
    }
}

void main()
{
	vec4 col = texture2D( gm_BaseTexture, v_vTexcoord);
	DoAlphaTest( col );
    
    // Check if the alternative mode is enabled
    if (u_altMode)
    {
        // Replace the color by the texture
        col = replaceByTexture(col);
    }
    else
    {
        // Change the color based on the palette texture and the palette ID
	    col = findAltColor(col, u_Uvs.xy);
    }
    
	gl_FragColor = v_vColour * col;
}
