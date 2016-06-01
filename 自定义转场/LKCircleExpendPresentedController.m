//
//  LKCircleExpendPresentedController.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKCircleExpendPresentedController.h"
#import "LKCircleExpendTransition.h"
@interface LKCircleExpendPresentedController()<UIViewControllerTransitioningDelegate,LKInteractiveTransitionDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)LKInteractiveTransition *dismissInteractiveTransion;
@end

@implementation LKCircleExpendPresentedController
- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:imageView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:btn];
    LKInteractiveTransition *dismissInteractiveTransion = [[LKInteractiveTransition alloc]initWithTransitionType:LKAnimationTransitionTypeDismiss transitionDirection:LKInteractiveTransitionDirectionDown];
    [dismissInteractiveTransion addPanGestuerForViewController:self];
    self.dismissInteractiveTransion = dismissInteractiveTransion;

}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)panGestureBeganMove{
    [self dismiss];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[LKCircleExpendTransition alloc]initWithTransitionType:LKAnimationTransitionTypePresent circleFrame:self.circleFrame];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
      return [[LKCircleExpendTransition alloc]initWithTransitionType:LKAnimationTransitionTypeDismiss circleFrame:self.circleFrame];
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.dismissInteractiveTransion.isStartMove?self.dismissInteractiveTransion:nil;
}
@end
