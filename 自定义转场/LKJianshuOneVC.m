//
//  LKJianshuOneVC.m
//  自定义转场
//
//  Created by ios on 16/6/1.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKJianshuOneVC.h"
#import "LKJianshuTwoVC.h"
@implementation LKJianshuOneVC
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupView];
}
- (void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Present" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 70, 70);
    [self.view addSubview:btn];
}
- (void)presentVC{
    LKJianshuTwoVC *presentVC = [[LKJianshuTwoVC alloc]init];
    [self presentViewController:presentVC animated:YES completion:nil];
}
@end
