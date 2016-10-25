//
//  CKPageView.h
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKPageMenu : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *navLineColor;
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 标题颜色渐变，默认YES
 */
@property (nonatomic, assign) BOOL isGraduallyChangColor;
/**
  标题尺寸渐变，默认YES
 */
@property (nonatomic, assign) BOOL isGraduallyChangFont;

@property (nonatomic, assign) NSInteger minFontSize;
@property (nonatomic, assign) NSInteger maxFontSize;
@property (nonatomic, assign) CGFloat rootScrollViewHeight;

- (id)initWithTitles:(NSArray *)titles andPageViews:(NSMutableArray *)pageViews;

@end
