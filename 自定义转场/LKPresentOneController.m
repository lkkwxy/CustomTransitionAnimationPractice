//
//  LKPresentOneController.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKPresentOneController.h"
#import "LKPresentTwoController.h"
#import "LKInteractiveTransition.h"
@interface LKPresentOneController()<LKInteractiveTransitionDelegate>
@property (nonatomic,strong)LKInteractiveTransition *interactiveTransion;
@end

@implementation LKPresentOneController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Present";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    LKInteractiveTransition *interactiveTransion = [[LKInteractiveTransition alloc]initWithTransitionType:LKAnimationTransitionTypePresent transitionDirection:LKInteractiveTransitionDirectionDown];
    [interactiveTransion addPanGestuerForViewController:self];
    self.interactiveTransion = interactiveTransion;
}
- (void)setupView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Present" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 70, 70);
    [self.view addSubview:btn];
}
#pragma mark LKInteractiveTransitionDelegate
- (void)panGestureBeganMove{
    [self presentVC];
}
- (void)presentVC{
    LKPresentTwoController *presentingVC = [[LKPresentTwoController alloc]init];
    presentingVC.presentInteractiveTransion = self.interactiveTransion;
    [self presentViewController:presentingVC animated:YES completion:nil];
}
@end
