//
//  CKPageItemManager.m
//  CKPageController
//
//  Created by hc_cyril on 2016/10/12.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "CKPageItemManager.h"
@interface CKPageItemManager ()
@property (nonatomic, strong) NSMutableArray *titles;
@end
@implementation CKPageItemManager

#pragma mark - public methods 
+ (id)sharedItemManager {

    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];

    });
    return manager;
}

- (void)setItemTitles:(NSMutableArray *)titles {

    _titles = titles;
    self.scrollNavigationBar.itemKeys = titles;
}

- (void)romoveTitle:(NSString *)title {

    [self.titles removeObject:title];
}

- (void)printTitles {

    NSLog(@"******************************");
    for (NSString *title in self.titles) {
        NSLog(@"CKPageItemManager ---> %@",title);
    }
}

#pragma mark - setter and getter methods
- (NSMutableArray *)titles {

    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

@end
