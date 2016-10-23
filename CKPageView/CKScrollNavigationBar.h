//
//  CKScrollNavigationBar.h
//  CKPageController
//
//  Created by Clark on 2016/10/19.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKPageRootScrollView.h"

@interface CKScrollNavigationBar : UIScrollView

@property (nonatomic, copy) NSString *currentTitle;

@property (nonatomic, weak) CKPageRootScrollView *rootScrollView;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelecterColor;
@property (nonatomic, weak) UIButton *currentItem;
@property (nonatomic, weak) UIButton *oldItem;
@property (nonatomic, strong) NSMutableArray *itemKeys;
@property (nonatomic, strong) NSMutableArray *pageViews;

@property (nonatomic, assign) BOOL isGraduallyChangeColor;
@property (nonatomic, assign) BOOL isGraduallyChangeFont;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) NSInteger minFontSize;
@property (nonatomic, assign) NSInteger maxFontSize;

- (void)showAllItems;

@end
