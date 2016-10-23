//
//  CKPageRootScrollViewManager.m
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "CKPageRootScrollViewManager.h"

@implementation CKPageRootScrollViewManager
#pragma mark - public methods
- (id)initWithRootScrollView:(CKPageRootScrollView *)rootScrollView {
    if (self = [super init]) {
        self.rootScrollView = rootScrollView;
    }
    return self;
}
#pragma mark - CKPageRootScrollViewDataSource and delegate
- (NSUInteger)numberOfCellInRootScrollView:(CKPageRootScrollView *)rootScrollView {
    return self.pageViews.count;
}
- (CKPageRootScrollViewCell *)rootScrollView:(CKPageRootScrollView *)rootSrollView atIndex:(NSUInteger)index {
    CKPageRootScrollViewCell *cell = [CKPageRootScrollViewCell cellWithRootScrollView:rootSrollView];
    UIView *pageView = self.pageViews[index];
    [cell setPageViewInCell:pageView];
    return cell;
}
- (CGFloat)rootScrollView:(CKPageRootScrollView *)rootSrollView marginType:(CKPageRootScrollViewMarginType)marginType {
    return self.margin;
}
#pragma mark - setter and getter methods
- (void)setPageViews:(NSMutableArray *)pageViews {
    _pageViews = pageViews;
    [self.rootScrollView reloadPageViews];
}

@end
