//
//  LKCircleExpendTransition.h
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LKInteractiveTransition.h"
@interface LKCircleExpendTransition : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType circleFrame:(CGRect)circleFrame;
@end
