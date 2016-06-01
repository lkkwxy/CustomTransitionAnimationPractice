//
//  LKCircleExpendController.m
//  自定义转场
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "LKCircleExpendController.h"
#import "LKCircleExpendPresentedController.h"

@interface LKCircleExpendController()
@property (nonatomic,weak)UIButton *circlrBtn;
@end

@implementation LKCircleExpendController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupView];
    
}
- (void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circlrBtn = btn;
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 50, 50);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 25;
    [btn addTarget:self action:@selector(presentVC) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [btn addGestureRecognizer:pan];
    [self.view addSubview:btn];
}
- (void)presentVC{
    LKCircleExpendPresentedController *presentingVC = [[LKCircleExpendPresentedController alloc]init];
    presentingVC.circleFrame = self.circlrBtn.frame;
    [self presentViewController:presentingVC animated:YES completion:nil];
}
- (void)handleGesture:(UIPanGestureRecognizer *)pan{
    UIView *panView = pan.view;
    CGPoint point = [pan locationInView:self.view];
    panView.center = point;
}
@end
