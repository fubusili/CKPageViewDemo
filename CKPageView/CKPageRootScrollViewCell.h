//
//  CKPageRootScrollViewCell.h
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKPageRootScrollView;
@interface CKPageRootScrollViewCell : UIView
@property (nonatomic, copy) NSString *identifier;

+ (instancetype)cellWithRootScrollView:(CKPageRootScrollView *)rootScrollView;
- (void)setPageViewInCell:(UIView *)pageView;

@end
