//
//  CKPageRootScrollView.h
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKPageRootScrollViewCell.h"
typedef NS_ENUM(NSInteger, CKPageRootScrollViewMarginType) {
    CKPageRootScrollViewMarginTypeTop,
    CKPageRootScrollViewMarginTypeBottom,
    CKPageRootScrollViewMarginTypeLeft,
    CKPageRootScrollViewMarginTypeRight
};

@protocol CKPageRootScrollViewDataSource;
@protocol CKPageRootScrollViewDelegate;

@interface CKPageRootScrollView : UIScrollView

@property (nonatomic, weak) id <CKPageRootScrollViewDataSource> rootScrollViewDataSource;
@property (nonatomic, weak) id <CKPageRootScrollViewDelegate>rootScrollViewDelegate;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat rootScrollWidth;
@property (nonatomic, assign) CGFloat rootScrollHeight;

- (void)reloadPageViews;
- (id)dequeueReusableCellWithIndentifier:(NSString *)identifier;
@end

@protocol CKPageRootScrollViewDataSource <NSObject>

@required
- (NSUInteger)numberOfCellInRootScrollView:(CKPageRootScrollView *)rootScrollView;
- (CKPageRootScrollViewCell *)rootScrollView:(CKPageRootScrollView *)rootSrollView atIndex:(NSUInteger)index;
@end

@protocol CKPageRootScrollViewDelegate <NSObject>

@optional
- (void)rootScrollView:(CKPageRootScrollView *)rootSrollView didSelectAtIndex:(NSUInteger)index;
- (CGFloat)rootScrollView:(CKPageRootScrollView *)rootSrollView marginType:(CKPageRootScrollViewMarginType)marginType;

@end
