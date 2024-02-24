//
//  Shaders.metal
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// WORKING

[[ stitchable ]] half4 checkerboard(float2 position, half4 color, half4 replacement, float size) {
    // Calculate which square of the checkerboard we're in,
    uint2 posInChecks = uint2(position.x / size, position.y / size);
    // XOR our X and Y position, then check if the result
    bool isColor = (posInChecks.x ^ posInChecks.y) & 1;
    // If it's odd send back the replacement color,
    // otherwise send back the original
    return isColor ? replacement * color.a : color;
}

[[ stitchable ]] half4 emboss(float2 position, SwiftUI::Layer layer, float strength) {
    // Read the current pixel color.
    half4 currentColor = layer.sample(position);

    // Take a copy of that, so we can modify it safely.
    half4 newColor = currentColor;

    // Add an offset pixel, adding more of it based on strength
    newColor += layer.sample(position + 1.0) * strength;

    // Do the opposite in the other direction.
    newColor -= layer.sample(position - 1.0) * strength;

    // Send back the resulting color, factoring in the
    // original alpha to get smooth edges.
    return half4(newColor) * currentColor.a;
}

[[ stitchable ]] half4 infrared(float2 position, half4 color) {
    // If it's not transparent…
    if (color.a > 0) {
        // Create three colors: blue (cold), yellow (medium), and hot (red).
        half3 cold = half3(0.0h, 0.0h, 1.0h);
        half3 medium = half3(1.0h, 1.0h, 0.0h);
        half3 hot = half3(1.0h, 0.0h, 0.0h);

        // These values correspond to how important each
        // color is to the overall brightness. The total
        // is 1.
        half3 grayValues = half3(0.2125h, 0.7154h, 0.0721h);

        // The dot() function multiplies all the colors
        // in our source color with all the values in
        // our grayValues conversion then sums them.
        // This means that `luma` will be a number
        // between 0 and 1, based on the input RGB
        // values and their relative brightnesses.
        half luma = dot(color.rgb, grayValues);

        // Declare the color we're going to use.
        half3 newColor;

        // If we have brightness of lower than 0.5…
        if (luma < 0.5h) {
            // Create a mix of blue and yellow; luma / 0.5 means this will be a range from 0 to 1.
            newColor = mix(cold, medium, luma / 0.5h);
        } else {
            // Create a mix of yellow and red; (luma - 0.5) / 0.5 means this will be a range of 0 to 1.
            newColor = mix(medium, hot, (luma - 0.5h) / 0.5h);
        }

        // Create the final color, multiplying by this
        // pixel's alpha (to avoid a hard edge).
        return half4(newColor, 1.0h) * color.a;
    } else {
        // Use the current (transparent) color.
        return color;
    }
}


[[ stitchable ]] half4 interlace(float2 position, half4 color, float width, half4 replacement, float strength) {
    // If the current color is not transparent…
    if (color.a > 0.0h) {
        // If we are an alternating horizontal line…
        if (fmod(position.y, width * 2.0) <= width) {
            // Render the original color
            return color;
        } else {
            // Otherwise blend the original color with the provided color
            // at whatever strength was requested, multiplying by this pixel's
            // alpha to avoid a hard edge.
            return half4(mix(color, replacement, strength)) * color.a;
        }
    } else {
        // Use the current (transparent) color
        return color;
    }
}





