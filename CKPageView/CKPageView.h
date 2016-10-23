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
@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, assign) BOOL isGraduallyChangColor;
@property (nonatomic, assign) BOOL isGraduallyChangFont;
@property (nonatomic, assign) NSInteger minFontSize;
@property (nonatomic, assign) NSInteger maxFontSize;
@property (nonatomic, assign) NSInteger defaultFontSize;
@property (nonatomic, assign) CGFloat rootScrollViewHeight;

- (id)initWithTitles:(NSArray *)titles andPageViews:(NSMutableArray *)pageViews;

@end
