//
//  CKPageRootScrollView.m
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "CKPageRootScrollView.h"
#import "CKPageRootScrollViewManager.h"
#import "UIView+Category.h"

#define CKPageRootScrollViewMarginTypeDefault 0

@interface CKPageRootScrollView ()
@property (nonatomic, strong) NSMutableArray *pageViewFrames;
@property (nonatomic, strong) NSMutableDictionary *displayingPageViews;
@property (nonatomic, strong) NSMutableSet *reusePageViews;
@property (nonatomic, strong) CKPageRootScrollViewManager *manager;
@end

@implementation CKPageRootScrollView

#pragma mark - lifecycle
- (instancetype)init {

    if (self = [super init]) {
        self.manager = [[CKPageRootScrollViewManager alloc] initWithRootScrollView:self];
        self.rootScrollViewDataSource = _manager;
        self.rootScrollViewDelegate = _manager;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {

    [self reloadPageViews];
}
- (void)layoutSubviews {

    [super layoutSubviews];
    NSUInteger numberOfCells = self.pageViewFrames.count;
    for (int i = 0; i < numberOfCells; i ++) {
        CGRect cellFrame = [self.pageViewFrames[i] CGRectValue];
        CKPageRootScrollViewCell *cell = self.displayingPageViews[@(i)];
        if ([self isInScreen:cellFrame]) {
            if (!cell) {
                cell = [self.rootScrollViewDataSource rootScrollView:self atIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                self.displayingPageViews[@(i)] = cell;
            }
        } else {
            if (cell) {
                [cell removeFromSuperview];
                [self.displayingPageViews removeObjectForKey:@(i)];
                [self.reusePageViews addObject:cell];
            }
        }
    }
}

#pragma mark - public methods
- (void)reloadPageViews {

    [self cleanData];
    NSUInteger numberOfCells = [self.rootScrollViewDataSource numberOfCellInRootScrollView:self];
    if (numberOfCells == 0 || self.width == 0 || self.height == 0) {
        return;
    }
    CGFloat topMargin = [self marginType:CKPageRootScrollViewMarginTypeTop];
    CGFloat bottomMargin = [self marginType:CKPageRootScrollViewMarginTypeBottom];
    CGFloat leftMargin = [self marginType:CKPageRootScrollViewMarginTypeLeft];
    CGFloat rightMargin = [self marginType:CKPageRootScrollViewMarginTypeRight];
    
    CGFloat cellWidth = self.width - leftMargin - rightMargin;
    CGFloat cellHeight = self.height - topMargin - bottomMargin;
    CGFloat cellY = bottomMargin;
    
    for (int i = 0; i < numberOfCells; i ++) {
        CGFloat cellX = i * (self.width) + leftMargin;
        CGRect cellFrame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        NSValue  *cellFrameValue = [NSValue valueWithCGRect:cellFrame];
        [self.pageViewFrames addObject:cellFrameValue];
    }
    self.contentSize = CGSizeMake(self.width * numberOfCells, 0);
    NSLog(@"pageViewFrames ------> count %ld", self.pageViews.count);
    
}

- (id)dequeueReusableCellWithIndentifier:(NSString *)identifier {

    __block CKPageRootScrollViewCell *reusableCell = nil;
    [self.reusePageViews enumerateObjectsUsingBlock:^(CKPageRootScrollViewCell *cell, BOOL * _Nonnull stop) {
        reusableCell = cell;
        *stop = YES;
    }];
    if (reusableCell) {
        [self.reusePageViews removeObject:reusableCell];
    }
    return reusableCell;
}

#pragma mark - private methods
- (void)cleanData {

    [self.displayingPageViews.allValues  makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingPageViews removeAllObjects];
    [self.pageViewFrames removeAllObjects];
    [self.pageViewFrames removeAllObjects];
}

- (CGFloat)marginType:(CKPageRootScrollViewMarginType)marginType {
    if ([self.rootScrollViewDelegate respondsToSelector:@selector(rootScrollView:marginType:)]) {
        [self.rootScrollViewDelegate rootScrollView:self marginType:marginType];
    }
    return CKPageRootScrollViewMarginTypeDefault;
}

- (BOOL)isInScreen:(CGRect)frame {
    return (CGRectGetMaxX(frame) > self.contentOffset.x) && (CGRectGetMinX(frame) < self.contentOffset.x + self.bounds.size.width);
}

#pragma mark - setter and getter methods

- (NSMutableArray *)pageViewFrames {

    if (!_pageViewFrames) {
        _pageViewFrames = [NSMutableArray array];
    }
    return _pageViewFrames;
}
- (NSMutableDictionary *)displayingPageViews {
    if (!_displayingPageViews) {
        _displayingPageViews = [NSMutableDictionary dictionary];
    }
    return _displayingPageViews;
}
- (NSMutableSet *)reusePageViews {
    if (!_reusePageViews) {
        _reusePageViews = [NSMutableSet set];
    }
    return _reusePageViews;
}
- (void)setPageViews:(NSMutableArray *)pageViews {

    _pageViews = pageViews;
    self.manager.pageViews = pageViews;
}

- (void)setMargin:(CGFloat)margin {
    _margin = margin;
    self.manager.margin = margin;
}

@end
