//
//  LKInteractiveTransition.h
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LKInteractiveTransitionDirection){
    LKInteractiveTransitionDirectionTop = 0,
    LKInteractiveTransitionDirectionLeft,
    LKInteractiveTransitionDirectionDown,
    LKInteractiveTransitionDirectionRight
};
typedef NS_ENUM(NSUInteger,LKAnimationTransitionType){
    LKAnimationTransitionTypePresent = 0,
    LKAnimationTransitionTypeDismiss,
    LKAnimationTransitionTypePush,
    LKAnimationTransitionTypePop
};

@protocol LKInteractiveTransitionDelegate <NSObject>
/**
 * 需要在此方法里执行present|dismiss|push|pop操作
 */
- (void)panGestureBeganMove;
@end

@interface LKInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,assign,readonly)BOOL isStartMove;
- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType transitionDirection:(LKInteractiveTransitionDirection)transitionDirection;

- (void)addPanGestuerForViewController:(UIViewController<LKInteractiveTransitionDelegate> *)viewController;
@end
