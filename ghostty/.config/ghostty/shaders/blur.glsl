#version 330 core

out vec4 FragColor;

in vec2 TexCoords;

uniform sampler2D screenTexture;
uniform float blurRadius; // Control the blur intensity
uniform vec2 resolution;  // Screen resolution

void main()
{
    vec2 texelSize = 1.0 / resolution; // Size of one texel
    vec3 result = vec3(0.0);
    
    // Gaussian weights
    float weights[5] = float[](0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

    // Horizontal blur
    for(int i = -4; i <= 4; i++)
    {
        result += texture(screenTexture, TexCoords + vec2(texelSize.x * i, 0.0)).rgb * weights[abs(i)];
    }
    
    // Vertical blur
    for(int i = -4; i <= 4; i++)
    {
        result += texture(screenTexture, TexCoords + vec2(0.0, texelSize.y * i)).rgb * weights[abs(i)];
    }
    
    FragColor = vec4(result, 1.0);
}
