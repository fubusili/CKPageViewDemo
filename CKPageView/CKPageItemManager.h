//
//  CKPageItemManager.h
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKScrollNavigationBar.h"

@interface CKPageItemManager : NSObject

@property (nonatomic,  weak) CKScrollNavigationBar *scrollNavigationBar;

+ (id)sharedItemManager;

- (void)setItemTitles:(NSMutableArray *)titles;
- (void)romoveTitle:(NSString *)title;
- (void)printTitles;

@end
