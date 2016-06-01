//
//  LKJianshuTransition.m
//  自定义转场
//
//  Created by ios on 16/6/1.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKJianshuTransition.h"

@interface LKJianshuTransition()
@property (nonatomic,assign)LKAnimationTransitionType transitionType;
@end

@implementation LKJianshuTransition

- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType{
    if (self = [super init]) {
        self.transitionType = transitionType;
    }
    return self;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.transitionType == LKAnimationTransitionTypePresent) {
        [self presentTransition:transitionContext];
    }else{
        [self dismissTransition:transitionContext];
    }
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
}
- (void)presentTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *temp = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    temp.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    UIView *bgView = [[UIView alloc]initWithFrame:temp.bounds];
    [bgView addSubview:temp];
    UIView *containerView = [transitionContext containerView];
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height * 0.6);
    [containerView addSubview:bgView];
    [containerView addSubview:toVC.view];
    
    CATransform3D byValue = CATransform3DIdentity;
    byValue.m34 = 1.0/-900;
    byValue = CATransform3DScale(byValue,0.95, 0.95, 1);
    byValue = CATransform3DRotate(byValue, M_PI / 180.0 * 15, 1, 0, 0);
    
    CATransform3D toValue = CATransform3DIdentity ;
    toValue.m34 = byValue.m34;
    toValue = CATransform3DTranslate(toValue,0, temp.frame.size.height * (-0.08), 0);
    toValue = CATransform3DScale(toValue, 0.8, 0.8, 1);
    CGRect frame = toVC.view.frame;
    frame.origin.y = containerView.frame.size.height * 0.4;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] / 2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [temp.layer setTransform:byValue];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] / 2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [temp.layer setTransform:toValue];
        } completion:^(BOOL finished) {
        }];
    }];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -containerView.frame.size.height * 0.6);;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
    UIView *containerView = [transitionContext containerView];
    NSArray *subviewsArray = containerView.subviews;
    UIView *tempView = subviewsArray[subviewsArray.count - 2];
    tempView = tempView.subviews.lastObject;
    CATransform3D byValue = CATransform3DIdentity;
    byValue.m34 = 1.0/-900;
    byValue = CATransform3DScale(byValue,0.95, 0.95, 1);
    byValue = CATransform3DRotate(byValue, M_PI / 180.0 * 15, 1, 0, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] / 2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [tempView.layer setTransform:byValue];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] / 2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [tempView.layer setTransform:CATransform3DIdentity];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = fromVC.view.frame;
        frame.origin.y = containerView.frame.size.height;
        fromVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) {
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}
@end
