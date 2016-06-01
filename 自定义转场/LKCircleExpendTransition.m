//
//  LKCircleExpendTransition.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKCircleExpendTransition.h"

@interface LKCircleExpendTransition()
@property (nonatomic,assign)LKAnimationTransitionType transitionType;
@property (nonatomic,assign)CGRect circleFrame;
@end

@implementation LKCircleExpendTransition
- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType circleFrame:(CGRect)circleFrame{
    if (self = [super init]) {
        self.transitionType = transitionType;
        self.circleFrame = circleFrame;
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
    [containerView addSubview:toVC.view];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:self.circleFrame];
    CGFloat width = MAX(self.circleFrame.origin.x, containerView.frame.size.width - self.circleFrame.origin.x);
     CGFloat height = MAX(self.circleFrame.origin.y, containerView.frame.size.height - self.circleFrame.origin.y);
    CGFloat radius = sqrtf(width * width + powf(height, 2));
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(endPath.CGPath);
    maskLayerAnimation.delegate = self;
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGFloat width = containerView.frame.size.width;
    CGFloat height = containerView.frame.size.height;
    CGFloat radius = sqrtf(width * width + height * height) / 2;
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:self.circleFrame];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(endPath.CGPath);
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    if ([transitionContext transitionWasCancelled]) {
        [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    }
}
@end
