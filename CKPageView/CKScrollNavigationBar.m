//
//  CKScrollNavigationBar.m
//  CKPageController
//
//  Created by Clark on 2016/10/19.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "CKScrollNavigationBar.h"
#import "UIView+Category.h"
#import "CKPageItemManager.h"
#import "UIColor+Category.h"

#define kItemWidth 75
#define kFontMinSize 10
#define kFontDefaultLeftSize 10
#define kFontDefaultSize 15
#define kStaticItemIndex 3
#define kScrollNavigationBarUpdate @"kScrollNavigationBarUpdate"
#define kMoveToSelectedItem @"kMoveToSelectedItem"
#define kMoveToTop @"kMoveToTop"

@interface CKScrollNavigationBar () <UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, strong) NSMutableDictionary *tmpPageViewDictionary;

@property (nonatomic, strong) NSMutableDictionary *itemDictionary;
@property (nonatomic, strong) NSMutableArray *tmpKeys;
@property (nonatomic, assign) BOOL isLayoutItems;
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat lastPointX;
@property (nonatomic, assign) CGFloat redOne;
@property (nonatomic, assign) CGFloat redTwo;
@property (nonatomic, assign) CGFloat greenOne;
@property (nonatomic, assign) CGFloat blueOne;
@property (nonatomic, assign) CGFloat alphaOne;
@property (nonatomic, assign) CGFloat greenTwo;
@property (nonatomic, assign) CGFloat blueTwo;
@property (nonatomic, assign) CGFloat alphaTwo;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation CKScrollNavigationBar
#pragma mark - lifecycle
- (instancetype)init {

    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews {

    [super layoutSubviews];
    [self layoutButtons];
}
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private methods

- (void)setup {
    self.isGraduallyChangeColor = YES;
    self.isGraduallyChangeFont = YES;
    self.userInteractionEnabled = YES;
    self.showsHorizontalScrollIndicator = YES;
    [self addObserver];
}

- (void)setupItems {
    NSInteger itemsCount = self.tmpKeys.count;
    for (int i = 0; i < itemsCount; i ++ ) {
        UIButton *button = [self createItemWithTitle:self.tmpKeys[i]];
        [self.itemDictionary setObject:button forKey:self.tmpKeys[i]];
        button.tag = i;
        if (i == 0) {
            button.selected = YES;
            if (self.maxFontSize) {
                button.titleLabel.font = [UIFont systemFontOfSize:self.maxFontSize];
            } else {
                button.titleLabel.font = [UIFont systemFontOfSize:kFontDefaultLeftSize + kFontMinSize];
            }
            _currentItem = button;
        }
    }
}

- (void)layoutButtons {
    self.contentSize = CGSizeMake(self.tmpKeys.count * kItemWidth, 0);
    CGFloat buttonWidth = kItemWidth;
    NSInteger itemsCont = self.tmpKeys.count;
    if (itemsCont * kItemWidth < self.width) {
        CGFloat width = self.width;
        buttonWidth = width / itemsCont;
    }
    CGFloat buttonHeight = self.height;
    CGFloat buttonY = 0;
    
    for (int i = 0; i < itemsCont; i ++ ) {
        if (i != itemsCont) {
            NSString *key = self.tmpKeys[i];
            UIButton *button = [self.itemDictionary objectForKey:key];
            button.tag = i;
            CGFloat buttonX = i * buttonWidth;
            button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
            self.itemWidth = buttonWidth;
        }
    }
    if (!self.isLayoutItems) {
        if (self.isGraduallyChangeFont) {
            [self addOffset];
        } else {
            NSInteger fontSize = self.maxFontSize > 0 ? self.maxFontSize : (kFontDefaultLeftSize + kFontDefaultSize);
            UIButton *button = [self.itemDictionary objectForKey:self.tmpKeys[0]];
            button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
        self.isLayoutItems = YES;
    }
    
}

- (void)addOffset {
    [self.rootScrollView setContentOffset:CGPointMake(1, 0)];
    [self.rootScrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitlesWithNotification:) name:kScrollNavigationBarUpdate object:nil];
}


- (void)updateTitlesWithNotification:(NSNotification *)notification {
    [self updatePageViewWithNotification:notification];
    [self layoutButtons];
}

- (UIButton *)createItemWithTitle:(NSString *)title {

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    NSInteger fontSize = self.minFontSize > 0 ? self.minFontSize : kFontMinSize;
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}
- (void)buttonDidClick:(UIButton *)btn {
    if (!self.isGraduallyChangeFont) {
        [self clickButtonWhenNotGraduallyChangeFontWithButton:btn];
    } else {
        _oldItem = _currentItem;
        _currentItem.selected = YES;
        btn.selected = YES;
        _currentItem = btn;
    }
    CGFloat offsetX = btn.tag * self.rootScrollView.width;
    [self.rootScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)selectedItemWhenNotGraduallyChangeFontWithButton:(UIButton *)button {
    _oldItem = _currentItem;
    if (self.minFontSize) {
        _oldItem.titleLabel.font = [UIFont systemFontOfSize:self.minFontSize];
    } else {
        _oldItem.titleLabel.font = [UIFont systemFontOfSize:kFontMinSize];
    }
    _currentItem.selected = NO;
    button.selected = YES;
    _currentItem = button;
    if (self.maxFontSize) {
        _currentItem.titleLabel.font = [UIFont systemFontOfSize:self.maxFontSize];
    } else {
        _currentItem.titleLabel.font = [UIFont systemFontOfSize:kFontDefaultSize + kFontDefaultLeftSize];
    }
}

- (void)clickButtonWhenNotGraduallyChangeFontWithButton:(UIButton *)button {
    _oldItem = _currentItem;
    if (self.minFontSize) {
        _oldItem.titleLabel.font = [UIFont systemFontOfSize:self.minFontSize];
    } else {
        _oldItem.titleLabel.font = [UIFont systemFontOfSize:kFontMinSize];
    }
    _currentItem.selected = NO;
    button.selected = YES;
    _currentItem = button;
    if (self.maxFontSize) {
        _currentItem.titleLabel.font = [UIFont systemFontOfSize:self.maxFontSize];
    } else {
        _currentItem.titleLabel.font = [UIFont systemFontOfSize:kFontDefaultSize + kFontDefaultLeftSize];
    }
    
}

- (NSInteger)getIndexWithKey:(NSString *)key {
    return [self.itemKeys indexOfObject:key];
}
- (UIButton *)getItemWithIndex:(NSInteger)index {
    return [self.itemDictionary objectForKey:self.tmpKeys[index]];
}
- (void)updatePageViewWithNotification:(NSNotification *)notification {
    if (notification.object) {
        UIView *deletePageView = [self.tmpPageViewDictionary objectForKey:notification.object];
        deletePageView.hidden = YES;
        [self.tmpPageViewDictionary removeObjectForKey:notification.object];
    }
    int i = 0;
    NSMutableArray *tmpArray = [NSMutableArray array];
    self.rootScrollView.contentSize = CGSizeMake(self.tmpKeys.count * self.rootScrollView.width, 0);
    for (NSString *key in self.tmpKeys) {
        UIView *pageView = [self.tmpPageViewDictionary objectForKey:key];
        [tmpArray addObject:pageView];
        i ++;
    }
    self.rootScrollView.pageViews = tmpArray;
    [self.rootScrollView reloadPageViews];
}
- (void)setSelectedItemWithIndex:(NSInteger)index {
    UIButton *button = [self.itemDictionary objectForKey:self.tmpKeys[index]];
    if (!self.isGraduallyChangeFont) {
        [self selectedItemWhenNotGraduallyChangeFontWithButton:button];
    } else {
        _oldItem = _currentItem;
        _currentItem.selected = NO;
        button.selected = YES;
        _currentItem = button;
    }
    [self buttonMoveAnimationWithIndex:index];
}
- (void)buttonMoveAnimationWithIndex:(NSInteger)index {
    UIButton *selecteButton = [self.itemDictionary objectForKey:self.tmpKeys[index]];
    if (self.tmpKeys.count * self.itemWidth > self.width) {
        if (index < kStaticItemIndex) {
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        } else if (index > self.tmpKeys.count - kStaticItemIndex - 1) {
            [self setContentOffset:CGPointMake(self.contentSize.width - self.width, 0) animated:YES];
        } else{
            [self setContentOffset:CGPointMake(selecteButton.center.x - self.center.x, 0) animated:YES];
        }

    }else{
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark  渐变 动画相关
- (void)setItemFontColorWithFrontItem:(UIButton *)frontItem AndBackItem:(UIButton *)backItem andPrecent:(CGFloat)p{
    if (self.isGraduallyChangeColor) {
        CGFloat redTemp1 = ((self.redTwo - self.redOne) * (1-p)) + self.redOne;
        CGFloat greenTemp1 = ((self.greenTwo - self.greenOne) * (1 - p)) + self.greenOne;
        CGFloat blueTemp1 = ((self.blueTwo - self.blueOne) * (1 - p)) + self.blueOne;
        
        CGFloat redTemp2 = ((self.redTwo - self.redOne) * p) + self.redOne;
        CGFloat greenTemp2 = ((self.greenTwo - self.greenOne) * p) + self.greenOne;
        CGFloat blueTemp2 = ((self.blueTwo - self.blueOne) * p) + self.blueOne;
        
        [frontItem setTitleColor:[UIColor colorWithRed:redTemp1 green:greenTemp1 blue:blueTemp1 alpha:1] forState:UIControlStateNormal];
        [backItem setTitleColor:[UIColor colorWithRed:redTemp2 green:greenTemp2 blue:blueTemp2 alpha:1] forState:UIControlStateNormal];
    }
}

- (void)setItemFontSizeWithFrontItem:(UIButton *)frontItem AndBackItem:(UIButton *)backItem andPrecent:(CGFloat)p{
    
    if (self.isGraduallyChangeFont) {
        CGFloat fontSize1;
        CGFloat fontSize2;
        if (self.maxFontSize) {
            if (self.minFontSize) {
                fontSize1 = (1- p) * (self.maxFontSize - self.minFontSize) + self.minFontSize;
                fontSize2 = p * (self.maxFontSize - self.minFontSize) + self.minFontSize;
            }else{
                fontSize1 = (1- p) * (self.maxFontSize - kFontMinSize) + kFontMinSize;
                fontSize2 = p * (self.maxFontSize - kFontMinSize) + kFontMinSize;
            }
        }else{
            if (self.minFontSize) {
                fontSize1 = (1- p) * kFontDefaultLeftSize + self.minFontSize;
                fontSize2 = p * kFontDefaultLeftSize + self.minFontSize;
                
            }else{
                fontSize1 = (1- p) * kFontDefaultLeftSize + kFontMinSize;
                fontSize2 = p * kFontDefaultLeftSize + kFontMinSize;
            }
        }
        frontItem.titleLabel.font = [UIFont systemFontOfSize:fontSize1];
        backItem.titleLabel.font = [UIFont systemFontOfSize:fontSize2];
    }
}

- (void)setupNormalFontSizeItem{
    if (self.minFontSize) {
        self.firstButton.titleLabel.font = [UIFont systemFontOfSize:self.minFontSize];
        self.secondButton.titleLabel.font = [UIFont systemFontOfSize:self.minFontSize];
    }else{
        self.firstButton.titleLabel.font = [UIFont systemFontOfSize:kFontDefaultSize];
        self.secondButton.titleLabel.font = [UIFont systemFontOfSize:kFontDefaultSize];
    }
    
    [self.firstButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
    [self.secondButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
}

- (void)changeButtonFontWithOffset:(CGFloat)offset andWidth:(CGFloat)width{
    
    [self setupNormalFontSizeItem];
    
    CGFloat p = fmod(offset, width) /width;
    NSInteger index = offset / width;
    self.currentIndex = index;
    
    self.firstButton = [self.itemDictionary objectForKey:self.tmpKeys[index]];
    self.secondButton   = (index + 1 < self.tmpKeys.count) ? [self.itemDictionary objectForKey:self.tmpKeys[index + 1]] : nil;
    
    [self setItemFontSizeWithFrontItem:self.firstButton AndBackItem:self.secondButton andPrecent:p];
    [self setItemFontColorWithFrontItem:self.firstButton AndBackItem:self.secondButton andPrecent:p];
}

- (void)showAllItems{
    for (int i = 0; i < self.tmpKeys.count; i++) {
        UIButton *button = [self getItemWithIndex:i];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                button.y = 0;
            } completion:nil];
        });
    }
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self changeButtonFontWithOffset:scrollView.contentOffset.x andWidth:self.rootScrollView.width];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger num = targetContentOffset->x / _rootScrollView.frame.size.width;
    [self setSelectedItemWithIndex:num];
}

#pragma mark - setter and getter methods

- (NSMutableArray *)tmpKeys {

    if (!_tmpKeys) {
        _tmpKeys  = [NSMutableArray array];
    }
    return _tmpKeys;
}

- (NSMutableDictionary *)itemDictionary {

    if (!_itemDictionary) {
        _itemDictionary = [NSMutableDictionary dictionary];
    }
    return _itemDictionary;
}
- (NSMutableDictionary *)tmpPageViewDictionary {

    if (!_tmpPageViewDictionary) {
        _tmpPageViewDictionary = [NSMutableDictionary dictionary];
    }
    return _tmpPageViewDictionary;
}

- (void)setItemKeys:(NSMutableArray *)itemKeys {

    _itemKeys = itemKeys;
    self.tmpKeys = itemKeys;
    if (self.itemDictionary.count == 0) {
        [self setupItems];
    }
}
- (void)setPageViews:(NSMutableArray *)pageViews {

    _pageViews = pageViews;
}

- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX = self.contentOffset.x;
}
- (void)setRootScrollView:(CKPageRootScrollView *)rootScrollView {
    _rootScrollView = rootScrollView;
    _rootScrollView.delegate = self;
    _rootScrollView.pageViews = self.pageViews;
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    [self.itemDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, UIButton *button, BOOL * _Nonnull stop) {
        [button setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }];
    RGBA rgba = RGBAFromUIColor(titleNormalColor);
    self.redOne = rgba.R;
    self.greenOne = rgba.G;
    self.blueOne = rgba.B;
    self.alphaOne = rgba.A;
}

- (void)setIsGraduallyChangeColor:(BOOL)isGraduallyChangeColor {

    _isGraduallyChangeColor = isGraduallyChangeColor;
    if (!isGraduallyChangeColor) {
        [self.itemDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, UIButton *button, BOOL * _Nonnull stop) {
            [button setTitleColor:self.titleSelecterColor forState:UIControlStateSelected];
            [button setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        }];
    }
}

- (void)setIsGraduallyChangeFont:(BOOL)isGraduallyChangeFont {

    _isGraduallyChangeFont = isGraduallyChangeFont;
    if (!_isGraduallyChangeFont) {
        
    }
}

- (void)setMinFontSize:(NSInteger)minFontSize {
    if (minFontSize > kFontMinSize && minFontSize < kFontDefaultSize + kFontDefaultLeftSize) {
        _minFontSize = minFontSize;
        [self setItemsFontWithFontSize:_minFontSize];
    }else {
        _minFontSize = kFontMinSize;
    }
    [self setItemsFontWithFontSize:_minFontSize];
}

- (void)setMaxFontSize:(NSInteger)maxFontSize {

    if (maxFontSize > kFontDefaultSize + kFontDefaultLeftSize) {
        _maxFontSize = maxFontSize;
    }else {
    
        _maxFontSize = kFontMinSize + kFontDefaultLeftSize;
    }
}

- (void)setItemsFontWithFontSize:(NSInteger)size {
    [self.itemDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, UIButton *obj, BOOL * _Nonnull stop) {
        obj.titleLabel.font = [UIFont systemFontOfSize:size];
    }];
    
}

@end
