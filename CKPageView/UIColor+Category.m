//
//  UIColor+Category.m
//  CKPageController
//
//  Created by Clark on 2016/10/22.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)
RGBA RGBAFromUIColor(UIColor *color) {

    return RGBAFromeCGColor(color.CGColor);
}
RGBA RGBAFromeCGColor(CGColorRef color) {

    RGBA rgba;
    CGColorSpaceRef color_space = CGColorGetColorSpace(color);
    CGColorSpaceModel color_space_model = CGColorSpaceGetModel(color_space);
    const CGFloat *color_components = CGColorGetComponents(color);
    size_t color_component_count = CGColorGetNumberOfComponents(color);
    switch (color_space_model) {
        case kCGColorSpaceModelMonochrome:{
            assert(color_component_count == 2);
            rgba = (RGBA) {
            
                .R = color_components[0],
                .G = color_components[0],
                .B = color_components[0],
                .A = color_components[1]
            };
            break;
        }
        case kCGColorSpaceModelRGB: {
            assert(color_component_count == 4);
            rgba = (RGBA) {
                .R = color_components[0],
                .G = color_components[1],
                .B = color_components[2],
                .A = color_components[3]
            };
            break;
        }
            
        default: {
            rgba = (RGBA) {0,0,0,0};
            break;
        }
    }
    return rgba;
}
@end
