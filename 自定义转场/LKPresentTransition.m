//
//  LKPresentTransition.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKPresentTransition.h"

@interface LKPresentTransition()
@property (nonatomic,assign)LKAnimationTransitionType transitionType;
@end

@implementation LKPresentTransition
- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType{
    if (self = [super init]) {
        self.transitionType = transitionType;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.transitionType == LKAnimationTransitionTypePresent) {
        [self presentTransition:transitionContext];
    }else{
        [self dismissTransition:transitionContext];
    }
}
- (void)presentTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    toVC.view.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = toVC.view.frame;
        frame.origin.y = 0;
        toVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = fromVC.view.frame;
        frame.origin.y = -containerView.frame.size.height;
        fromVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
