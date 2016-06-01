//
//  LKInteractiveTransition.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKInteractiveTransition.h"

@interface LKInteractiveTransition()
@property (nonatomic,assign)LKInteractiveTransitionDirection transitionDirection;
@property (nonatomic,assign)LKAnimationTransitionType transitionType;
@property (nonatomic,weak)UIViewController<LKInteractiveTransitionDelegate> *VC;
@property (nonatomic,assign)CGPoint beganPoint;
@end


@implementation LKInteractiveTransition

- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType transitionDirection:(LKInteractiveTransitionDirection)transitionDirection{
    if (self = [super init]) {
        self.transitionType = transitionType;
        self.transitionDirection = transitionDirection;
    }
    return self;
}

- (void)addPanGestuerForViewController:(UIViewController<LKInteractiveTransitionDelegate> *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    self.VC = viewController;
    [viewController.view addGestureRecognizer:pan];
}
- (void)handleGesture:(UIPanGestureRecognizer *)pan{
    CGFloat percentage = 0;
    //下正上负  左负右正
    CGPoint currentPoint = [pan translationInView:pan.view];
    switch (self.transitionDirection) {
        case LKInteractiveTransitionDirectionTop:{
            CGFloat transitionY = -currentPoint.y;
            percentage = transitionY / pan.view.frame.size.height;
           break;
        }
        case LKInteractiveTransitionDirectionDown:{
            CGFloat transitionY = currentPoint.y;
            percentage = transitionY / pan.view.frame.size.width;
            break;
        }
        case LKInteractiveTransitionDirectionLeft:{
            CGFloat transitionX = -currentPoint.x;
            percentage = transitionX / pan.view.frame.size.width;
            break;
        }
        case LKInteractiveTransitionDirectionRight:{
            CGFloat transitionX = currentPoint.x;
            percentage = transitionX / pan.view.frame.size.width;
            break;
        }
        default:
            break;
    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            _isStartMove = YES;
            [self startPan];
           break;
        }
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:percentage];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            _isStartMove = NO;
            if (percentage > 0.4) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
- (void)startPan{
    [self.VC panGestureBeganMove];
}
@end
