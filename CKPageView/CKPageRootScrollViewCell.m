//
//  CKPageRootScrollViewCell.m
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "CKPageRootScrollViewCell.h"
#import "CKPageRootScrollView.h"

@implementation CKPageRootScrollViewCell
#pragma mark - lifecycle
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *pageView = self.subviews[0];
    pageView.frame = self.bounds;
}
#pragma mark - public methods
+ (id)cellWithRootScrollView:(CKPageRootScrollView *)rootScrollView {
    static NSString *cellID = @"CKPageRootScrollViewCell";
    CKPageRootScrollViewCell *cell = [rootScrollView dequeueReusableCellWithIndentifier:cellID];
    if (!cell) {
        cell = [[CKPageRootScrollViewCell alloc] init];
        cell.identifier = cellID;
    }
    return cell;
}
- (void)setPageViewInCell:(UIView *)pageView {

    if (self.subviews.count) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self addSubview:pageView];
    [self layoutIfNeeded];
}
@end
