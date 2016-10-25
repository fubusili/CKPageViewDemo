//
//  ViewController.m
//  CKPageController
//
//  Created by hc_cyril on 2016/10/10.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "ViewController.h"
#import "CKPageMenu.h"
#import "UIView+Category.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;//禁止UITableView自动下移64像素
    self.title = @"CKPageMenu";
    
    //不允许有重复的标题
    self.titles = @[@"脸书",@"Google",@"苹果",@"iMac",@"谷歌",@"🍎",@"😍😘",@"三星",@"🎯",@"iPhone",@"iPad"];
    
    CKPageMenu *cursor = [[CKPageMenu alloc] init];
//    CKPageView *cursor = [[CKPageView alloc] initWithTitles:self.titles andPageViews:[self createPageViews]];
    cursor.frame = CGRectMake(0, 64, self.view.width, 44);
    cursor.titles = self.titles;
    cursor.pageViews = [self createPageViews];
    //设置根滚动视图的高度
    cursor.rootScrollViewHeight = self.view.frame.size.height - 108;
    //默认值是黑色
    cursor.titleNormalColor = [UIColor darkGrayColor];
    //默认值是白色
    cursor.titleSelectedColor = [UIColor redColor];
    //默认15，小于默认值按默认值
    cursor.minFontSize = 15;
    //默认18，小于默认值按默认值，大于默认值按设置的值
    cursor.maxFontSize = 20;
    // 标题字体渐变
    cursor.isGraduallyChangFont = YES;
    // 标题颜色渐变
    cursor.isGraduallyChangColor = YES;
    [self.view addSubview:cursor];
}

- (NSMutableArray *)createPageViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UITableView *textView = [[UITableView alloc]init];
        textView.delegate = self;
        textView.dataSource = self;
        textView.tag = i;
        [pageViews addObject:textView];
    }
    return pageViews;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor cyanColor];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"tableViw %ld, Cell %ld - %@",tableView.tag,indexPath.row,self.titles[tableView.tag]];
    return cell;
}


@end
