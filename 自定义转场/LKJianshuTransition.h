//
//  LKJianshuTransition.h
//  自定义转场
//
//  Created by ios on 16/6/1.
//  Copyright © 2016年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LKInteractiveTransition.h"
@interface LKJianshuTransition : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithTransitionType:(LKAnimationTransitionType)transitionType;
@end
