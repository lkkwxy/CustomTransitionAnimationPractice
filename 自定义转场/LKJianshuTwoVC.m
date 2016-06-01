//
//  LKJianshuTwoVC.m
//  自定义转场
//
//  Created by ios on 16/6/1.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKJianshuTwoVC.h"
#import "LKJianshuTransition.h"
@interface LKJianshuTwoVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation LKJianshuTwoVC
- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupView];
}
- (void)setupView{
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 20, 30, 70);
    [self.view addSubview:btn];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[LKJianshuTransition alloc]initWithTransitionType:LKAnimationTransitionTypePresent];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[LKJianshuTransition alloc]initWithTransitionType:LKAnimationTransitionTypeDismiss];
}
@end
