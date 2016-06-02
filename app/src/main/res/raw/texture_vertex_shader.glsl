uniform mat4 u_Matrix;

uniform float u_Slope;
uniform float u_Intercept;
uniform float u_Normal;

attribute float a_S0;
attribute float a_S1;

varying vec2 v_TextureCoordinates;

const float ONE_OVER_32  = 0.03125;
const float ONE_OVER_512 = 0.001953125;
const float ONE_OVER_256 = 0.00390625;

void main()                    
{

    // data comes in packed to save memory
    float row  = floor(a_S0 * ONE_OVER_32);
    float col  = floor(a_S1 * ONE_OVER_32);
    float pxr  = row * -32.0 + a_S0;
    float pxc  = col * -32.0 + a_S1;
    float px   = pxr * 32.0 + pxc;
    float ht   = u_Normal * (px * u_Slope + u_Intercept);

    //-1,1    1,1
    //-1,-1   1,-1
    vec4 ap = vec4(col * ONE_OVER_256 - 1.0, row * -ONE_OVER_256 + 1.0, ht, 1.0);
    vec2 at = vec2(col * ONE_OVER_512, row * ONE_OVER_512);
    v_TextureCoordinates = at;
    gl_Position = u_Matrix * ap;
}
