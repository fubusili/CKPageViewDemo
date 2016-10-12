//
//  CKPageView.h
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKPageView : UIView
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *navLineColor;
@property (nonatomic, strong) UIColor *backgroudImage;

@property (nonatomic, assign) BOOL isGraduallyChangColor;
@property (nonatomic, assign) BOOL isGradullyChangColor;
@property (nonatomic, assign) NSInteger minFontSize;
@property (nonatomic, assign) NSUInteger maxFontSize;
@property (nonatomic, assign) NSUInteger defaultFontSize;

@end
