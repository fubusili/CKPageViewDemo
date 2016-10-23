//
//  CKPageRootScrollViewManager.h
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKPageRootScrollView.h"

@interface CKPageRootScrollViewManager : NSObject <CKPageRootScrollViewDelegate, CKPageRootScrollViewDataSource>
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, weak) CKPageRootScrollView *rootScrollView;
@property (nonatomic, assign) CGFloat margin;

- (id)initWithRootScrollView:(CKPageRootScrollView *)rootScrollView;
@end
