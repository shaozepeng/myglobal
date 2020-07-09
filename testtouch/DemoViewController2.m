//
//  DemoViewController2.m
//  testtouch
//
//  Created by 泽鹏邵 on 2020/7/2.
//  Copyright © 2020 泽鹏邵. All rights reserved.
//

#define LJ_ColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#import "DemoViewController2.h"

@interface DemoViewController2 ()

@end

@implementation DemoViewController2{
    UIView *centerView;
    UIView *outerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"半截边框闪烁";
    
    centerView = [[UIView alloc]initWithFrame:CGRectMake(85, 185, 230, 230)];
    [centerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:centerView];
    
    [self createCustomBorder:centerView radii:6 coordinate:0.5 range:-1 borderW:1 color:LJ_ColorFromHex(0xF1a020) time:1.8 type:2 beginTime:0.0];
    [self createCustomBorder:centerView radii:6 coordinate:7.5 range:-15 borderW:1 color:LJ_ColorFromHex(0xF1a020) time:1.8 type:2 beginTime:0.0];

    
    [self createSphere:ceil(centerView.frame.size.height/SCREENWIDTH*12) view:centerView radii:6 width:centerView.frame.size.width height:centerView.frame.size.height radius:3.5 firstColor:LJ_ColorFromHex(0xFFD700) secondColor:LJ_ColorFromHex(0xFF0000) state:DrawLeft];
    [self createSphere:ceil(centerView.frame.size.width/SCREENWIDTH*12) view:centerView radii:6 width:centerView.frame.size.width height:centerView.frame.size.height radius:3.5 firstColor:LJ_ColorFromHex(0xFF0000) secondColor:LJ_ColorFromHex(0xFFD700) state:DrawTop];
    [self createSphere:ceil(centerView.frame.size.height/SCREENWIDTH*12) view:centerView radii:6 width:centerView.frame.size.width height:centerView.frame.size.height radius:3.5 firstColor:LJ_ColorFromHex(0xFF0000) secondColor:LJ_ColorFromHex(0xFFD700) state:DrawRight];
    [self createSphere:ceil(centerView.frame.size.width/SCREENWIDTH*12) view:centerView radii:6 width:centerView.frame.size.width height:centerView.frame.size.height radius:3.5 firstColor:LJ_ColorFromHex(0xFFD700) secondColor:LJ_ColorFromHex(0xFF0000) state:DrawBottom];
    
    
//    outerView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 200, 200)];
//    [outerView setBackgroundColor:[UIColor clearColor]];
//    [centerView addSubview:outerView];
//
//     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
}

//绘制小球
-(void)createSphere:(int)number view:(UIView *)targetView radii:(CGFloat)radii width:(CGFloat)width height:(CGFloat)height radius:(CGFloat)radius firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor state:(DrawState)state{
    for (int i = 1; i < number+1; i++) {
        UIView *sphereView = [UIView new];
        UIColor *commColor = firstColor;
        if(i%2 == 0 ){
            commColor = secondColor;
        }
        [sphereView setBackgroundColor:commColor];
        sphereView.layer.cornerRadius = 3.5;
        CGRect rest = CGRectZero;
        
        switch (state) {
            case DrawLeft:
                {
                    CGFloat mainterval = (height - radius*2*number)/number;
                    CGFloat interval = (height - mainterval - radius*2*number)/(number-1);
                    
                    rest = CGRectMake(0.5,mainterval/3*2+(i-1)*radius*2+(i-1)*interval, radius*2, radius*2);
                }
                break;
            case DrawTop:
                {
                    CGFloat mainterval = (width - radius*2*number)/number;
                    CGFloat interval = (width - mainterval - radius*2*number)/(number-1);
                    rest = CGRectMake(mainterval/3+(i-1)*radius*2+(i-1)*interval,0.5, radius*2, radius*2);
                }
                break;
            case DrawRight:
                {
                    CGFloat mainterval = (height - radius*2*number)/number;
                    CGFloat interval = (height - mainterval - radius*2*number)/(number-1);
                    rest = CGRectMake(width-radius*2-1,mainterval/3+(i-1)*radius*2+(i-1)*interval, radius*2, radius*2);
                }
                break;
            case DrawBottom:
                {
                    CGFloat mainterval = (width - radius*2*number)/number;
                    CGFloat interval = (width  - mainterval - radius*2*number)/(number-1);
                   rest = CGRectMake(mainterval/3*2+(i-1)*radius*2+(i-1)*interval,height-radius*2-1, radius*2, radius*2);
                }
        }
        sphereView.frame = rest;
        [targetView addSubview:sphereView];
        [sphereView.layer addAnimation:[self addAnimation:commColor secondColor:[self isEqualToColor:commColor anotherColor:firstColor] ? secondColor : firstColor duration:0.5] forKey:nil];
       
    }
}

-(CABasicAnimation *)addAnimation:(UIColor*)firstColor secondColor:(UIColor*)secondColor duration:(float)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)firstColor.CGColor;
    animation.toValue = (id)secondColor.CGColor;
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.beginTime = 0.0f;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

//绘制边框
-(void)createCustomBorder:(UIView *)targetView radii:(int)radii coordinate:(CGFloat)coordinate range:(CGFloat)range borderW:(CGFloat)borderW color:(UIColor*)color time:(float)time type:(int)type beginTime:(float)beginTime{
    CGSize radi = CGSizeMake(radii, radii);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(coordinate, coordinate, targetView.bounds.size.width+range, targetView.bounds.size.height+range) byRoundingCorners:UIRectCornerAllCorners cornerRadii:radi];

    //这是边框
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    //设置边框的路径
    borderLayer.path= maskPath.CGPath;
    //边框的宽度
    borderLayer.lineWidth = borderW;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    //边框的颜色
    borderLayer.strokeColor= color.CGColor;
    //这个需要注意的
    borderLayer.frame=targetView.bounds;
    
    [targetView.layer addSublayer:borderLayer];
    
}

- (BOOL) isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB
{
    if (CGColorEqualToColor(colorA.CGColor, colorB.CGColor)) {
        return YES;
   }else {
           return NO;
   }
}

-(void)timer{
    [centerView setNeedsDisplay];
    //[view autorelease];
}

- (void)drawRect:(CGRect)rect{
//    //获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    //或者绘图路径对象（可以了理解为画笔）
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    //绘图
//    [bezierPath moveToPoint:CGPointMake(50, 50)];
//    //通过控制点（ControlPoint来改变直线的弧度)
//    [bezierPath addQuadCurveToPoint:CGPointMake(250, 250) controlPoint:CGPointMake(50, 250)];
//    [bezierPath addLineToPoint:CGPointMake(250, 20)];
///**********设置上下文的状态***********/
//    CGContextSetLineWidth(ctx, 10);
//    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    //改变路径颜色
//    [[UIColor redColor] setStroke];
///***********************************/
//    //把路径添加到上下文
//    CGContextAddPath(ctx, bezierPath.CGPath);
//    //渲染上下文(layer)
//    CGContextStrokePath(ctx);
}

- (void)applyRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius rect:(CGRect)rect view:(UIView *)view
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    CAShapeLayer *temp = [CAShapeLayer layer];
    temp.lineWidth = 10.f;
    temp.fillColor = [UIColor clearColor].CGColor;
    temp.strokeColor = [UIColor redColor].CGColor;
    temp.frame = rect;
    temp.path = path.CGPath;
    [view.layer addSublayer:temp];
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
