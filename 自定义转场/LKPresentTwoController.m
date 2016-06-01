//
//  LKPersonTwoController.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKPresentTwoController.h"
#import "LKPresentTransition.h"
#import "LKInteractiveTransition.h"
@interface LKPresentTwoController()<UIViewControllerTransitioningDelegate,LKInteractiveTransitionDelegate>
@property (nonatomic,strong)LKInteractiveTransition *dismissInteractiveTransion;
@end

@implementation LKPresentTwoController
- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor redColor];
    [self setupView];
    LKInteractiveTransition *dismissInteractiveTransion = [[LKInteractiveTransition alloc]initWithTransitionType:LKAnimationTransitionTypeDismiss transitionDirection:LKInteractiveTransitionDirectionTop];
    [dismissInteractiveTransion addPanGestuerForViewController:self];
    self.dismissInteractiveTransion = dismissInteractiveTransion;
}
- (void)setupView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 70, 70);
    [self.view addSubview:btn];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//返回遵循转场动画协议的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[LKPresentTransition alloc]initWithTransitionType:LKAnimationTransitionTypePresent];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[LKPresentTransition alloc]initWithTransitionType:LKAnimationTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.presentInteractiveTransion.isStartMove ? self.presentInteractiveTransion:nil;
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.dismissInteractiveTransion.isStartMove ? self.dismissInteractiveTransion:nil;
}
- (void)panGestureBeganMove{
    [self dismiss];
}
@end
