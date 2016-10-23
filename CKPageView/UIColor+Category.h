//
//  UIColor+Category.h
//  CKPageController
//
//  Created by Clark on 2016/10/22.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat R;
    CGFloat G;
    CGFloat B;
    CGFloat A;

}RGBA;

@interface UIColor (Category)
RGBA RGBAFromUIColor(UIColor *color);
@end
