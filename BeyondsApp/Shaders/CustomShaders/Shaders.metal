//
//  Shaders.metal
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 checkerboard(float2 position, half4 color, half4 replacement, float size) {
    uint2 posInChecks = uint2(position.x / size, position.y / size);
    bool isColor = (posInChecks.x ^ posInChecks.y) & 1;
    return isColor ? replacement * color.a : color;
}

[[ stitchable ]] half4 emboss(float2 position, SwiftUI::Layer layer, float strength) {
    half4 currentColor = layer.sample(position);
    half4 newColor = currentColor;
    newColor += layer.sample(position + 1.0) * strength;
    newColor -= layer.sample(position - 1.0) * strength;
    return half4(newColor) * currentColor.a;
}

[[ stitchable ]] half4 infrared(float2 position, half4 color) {
    if (color.a > 0) {
        half3 cold = half3(0.0h, 0.0h, 1.0h);
        half3 medium = half3(1.0h, 1.0h, 0.0h);
        half3 hot = half3(1.0h, 0.0h, 0.0h);
        half3 grayValues = half3(0.2125h, 0.7154h, 0.0721h);
        half luma = dot(color.rgb, grayValues);
        half3 newColor;
        if (luma < 0.5h) {
            newColor = mix(cold, medium, luma / 0.5h);
        } else {
            newColor = mix(medium, hot, (luma - 0.5h) / 0.5h);
        }
        return half4(newColor, 1.0h) * color.a;
    } else {
        return color;
    }
}

[[ stitchable ]] half4 interlace(float2 position, half4 color, float width, half4 replacement, float strength) {
    if (color.a > 0.0h) {
        if (fmod(position.y, width * 2.0) <= width) {
            return color;
        } else {
            return half4(mix(color, replacement, strength)) * color.a;
        }
    } else {
        return color;
    }
}





