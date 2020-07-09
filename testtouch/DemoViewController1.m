//
//  DemoViewController1.m
//  testtouch
//
//  Created by 泽鹏邵 on 2020/7/2.
//  Copyright © 2020 泽鹏邵. All rights reserved.
//

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#import "DemoViewController1.h"

@interface DemoViewController1 ()

@end

@implementation DemoViewController1{
    UIView *centerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"存边框闪烁";
    
    centerView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    [centerView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:centerView];
    
    
    
    // 获取贝塞尔曲线的路径
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:centerView.bounds];
    CGSize radi = CGSizeMake(5, 5);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:centerView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:radi];
    //这是边框
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    //设置边框的路径
    borderLayer.path= maskPath.CGPath;
    //边框的宽度
    borderLayer.lineWidth = 2;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    //边框的颜色
    borderLayer.strokeColor= UIColorFromRGBA(0xeb7eab,1).CGColor;
    //这个需要注意的
    borderLayer.frame=centerView.bounds;
    [borderLayer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    [centerView.layer addSublayer:borderLayer];
    
    // 获取贝塞尔曲线的路径
//    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRect:CGRectMake(-10, -10, 220, 220)];
    
    CGSize radi2 = CGSizeMake(5, 5);
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-10, -10, 220, 220) byRoundingCorners:UIRectCornerAllCorners cornerRadii:radi2];

    //这是边框
    CAShapeLayer *borderLayer2 = [CAShapeLayer layer];
    //设置边框的路径
    borderLayer2.path= maskPath2.CGPath;
    //边框的宽度
    borderLayer2.lineWidth = 2;
    borderLayer2.fillColor = [UIColor clearColor].CGColor;
    //边框的颜色
    borderLayer2.strokeColor= UIColorFromRGBA(0xeb7eab,1).CGColor;
    //这个需要注意的
    borderLayer2.frame=centerView.bounds;
    [borderLayer2 addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    [centerView.layer addSublayer:borderLayer2];
    
    // 获取贝塞尔曲线的路径
//    UIBezierPath *maskPath3 = [UIBezierPath bezierPathWithRect:CGRectMake(-6, -6, 212, 212)];
    CGSize radi3 = CGSizeMake(5, 5);
    UIBezierPath *maskPath3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-6, -6, 212, 212) byRoundingCorners:UIRectCornerAllCorners cornerRadii:radi3];
    //这是边框
    CAShapeLayer *borderLayer3 = [CAShapeLayer layer];
    //设置边框的路径
    borderLayer3.path= maskPath3.CGPath;
    //边框的宽度
    borderLayer3.lineWidth = 2;
    borderLayer3.fillColor = [UIColor clearColor].CGColor;
    //边框的颜色
    borderLayer3.strokeColor= UIColorFromRGBA(0xeb7eab,1).CGColor;
    //这个需要注意的
    borderLayer3.frame=centerView.bounds;
    [borderLayer3 addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    [centerView.layer addSublayer:borderLayer3];

    // Do any additional setup after loading the view.
}

-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.1f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
