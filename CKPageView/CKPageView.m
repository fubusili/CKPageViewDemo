//
//  CKPageView.m
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "CKPageView.h"
#import "CKScrollNavigationBar.h"
#import "CKPageRootScrollView.h"
#import "CKPageItemManager.h"
#import "UIView+Category.h"

#define kNavigationLineHeight 6
#define kStaticItemIndex 3
#define kDefaultBackgroundColor [UIColor blackColor]

@interface CKPageView () <UIScrollViewDelegate>

@property (nonatomic, strong) CKScrollNavigationBar *scrollNavigationBar;
@property (nonatomic, strong) CKPageRootScrollView *rootScrollView;

@property (nonatomic, assign) BOOL showNavigationBarLine;
@property (nonatomic, assign) BOOL isDrag;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isLayout;
@property (nonatomic, assign) CGFloat oldOffset;
@property (nonatomic, assign) CGFloat navigationBarHeight;
@property (nonatomic, assign) NSInteger oldButtonIndex;

@end

@implementation CKPageView

#pragma mark - lifecycle

- (instancetype)init {

    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (id)initWithTitles:(NSArray *)titles andPageViews:(NSMutableArray *)pageViews {

    if (self = [super init]) {
        self.titles = titles;
        self.pageViews = pageViews;
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    self.rootScrollView.frame = CGRectMake(0, self.navigationBarHeight, self.width, self.rootScrollViewHeight);
    if (!self.isLayout) {
        [self.rootScrollView reloadPageViews];
        self.isLayout = YES;
    }
}

#pragma mark - setup
- (void)setup {
    [self addSubview:self.rootScrollView];
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    if (!self.backgroundColor) {
        self.backgroundColor = kDefaultBackgroundColor;
    }
}

#pragma mark - private methods
//不允许有相同的标题
- (BOOL)checkIsHaveSameTitle:(NSArray *)titles {
    for (int i = 0; i < titles.count; i ++ ) {
        NSString *title1 = titles[i];
        for (int j = 0; j < titles.count ; j ++) {
            NSString *title2 = titles[j];
            if (j != i && [title1 isEqualToString:title2]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - setter and getter methods
- (CKPageRootScrollView *)rootScrollView {

    if (!_rootScrollView) {
        _rootScrollView = [[CKPageRootScrollView alloc] init];
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _rootScrollView;
}

- (CKScrollNavigationBar *)scrollNavigationBar {

    if (!_scrollNavigationBar) {
        _scrollNavigationBar = [[CKScrollNavigationBar alloc] init];
        _scrollNavigationBar.backgroundColor = [UIColor redColor];
    }
    return _scrollNavigationBar;
}

- (void)setPageViews:(NSMutableArray *)pageViews {
    
    _pageViews = pageViews;
    self.scrollNavigationBar.pageViews = pageViews;
    _scrollNavigationBar.rootScrollView = self.rootScrollView;
}


- (void)setRootScrollViewHeight:(CGFloat)rootScrollViewHeight {

    _rootScrollViewHeight = rootScrollViewHeight;
    CGRect rect = self.frame;
    if (self.navigationBarHeight == 0) {
        self.navigationBarHeight = rect.size.height;
        rect.size.height += self.rootScrollViewHeight;
    }
    [self setFrame:rect];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {

    [super setBackgroundColor:[UIColor clearColor]];
    self.scrollNavigationBar.backgroundColor = backgroundColor;
}

- (void)setTitles:(NSArray *)titles {

    BOOL isHaveSameTitle = [self checkIsHaveSameTitle:titles];
    NSAssert(!isHaveSameTitle, @"警告！！！不可包含相同的标题");
    _titles = titles;
    [[CKPageItemManager sharedItemManager] setScrollNavigationBar:self.scrollNavigationBar];
    [[CKPageItemManager sharedItemManager] setItemTitles:[titles mutableCopy]];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {

    _titleNormalColor = titleNormalColor;
    self.scrollNavigationBar.titleNormalColor = titleNormalColor;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    self.scrollNavigationBar.titleSelecterColor = titleSelectedColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.scrollNavigationBar.backgroundImage = backgroundImage;
}

- (void)setIsGraduallyChangColor:(BOOL)isGraduallyChangColor {

    _isGraduallyChangColor = isGraduallyChangColor;
    self.scrollNavigationBar.isGraduallyChangeColor = isGraduallyChangColor;
}
- (void)setIsGraduallyChangFont:(BOOL)isGraduallyChangFont {
    _isGraduallyChangFont = isGraduallyChangFont;
    self.scrollNavigationBar.isGraduallyChangeFont = isGraduallyChangFont;
}

- (void)setMinFontSize:(NSInteger)minFontSize {

    _minFontSize = minFontSize;
    self.scrollNavigationBar.minFontSize = minFontSize;
}
- (void)setMaxFontSize:(NSInteger)maxFontSize {

    _maxFontSize = maxFontSize;
    self.scrollNavigationBar.maxFontSize = maxFontSize;
}
@end
