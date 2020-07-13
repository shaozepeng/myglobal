//
//  DemoViewController3.m
//  testtouch
//
//  Created by 泽鹏邵 on 2020/7/13.
//  Copyright © 2020 泽鹏邵. All rights reserved.
//

#import "DemoViewController3.h"
#import "Qiu.h"

#define LJ_ColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface DemoViewController3 ()

@end

@implementation DemoViewController3{
    UIView *centerView;
    UIView *outerView;
    UIColor *targrtcolor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"多个闪烁小球";
    
    centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 185, SCREENWIDTH, SCREENWIDTH)];
//    [centerView setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:centerView];
    
    [self createCustomBorder:centerView radii:10 coordinate:0.5 range:-1 borderW:1 color:LJ_ColorFromHex(0xF1a020) time:1.8 type:2 beginTime:0.0];
    [self createCustomBorder:centerView radii:6 coordinate:4.5 range:-9 borderW:7 color:LJ_ColorFromHex(0xF76C14) time:1.8 type:2 beginTime:0.0];
    [self createCustomBorder:centerView radii:5 coordinate:7.5 range:-15 borderW:1 color:LJ_ColorFromHex(0xF1a020) time:1.8 type:2 beginTime:0.0];

    
    [self createSphere:ceil(centerView.frame.size.height/SCREENWIDTH*16) secondnumber:ceil(centerView.frame.size.width/SCREENWIDTH*16) thirdnumber:ceil(centerView.frame.size.height/SCREENWIDTH*16) forthnumber:ceil(centerView.frame.size.width/SCREENWIDTH*16) view:centerView radii:6 width:centerView.frame.size.width height:centerView.frame.size.height radius:3.5];
    
}

-(void)createSphere:(int)fristnumber secondnumber:(int)secondnumber thirdnumber:(int)thirdnumber forthnumber:(int)forthnumber view:(UIView *)targetView radii:(CGFloat)radii width:(CGFloat)width height:(CGFloat)height radius:(CGFloat)radius{
    int total = fristnumber + secondnumber + thirdnumber + forthnumber;
    NSMutableArray *colorarray = [[NSMutableArray alloc]initWithObjects:[UIColor greenColor], [UIColor blueColor],[UIColor yellowColor],[UIColor redColor],nil];
    NSMutableArray *qiurarray = [NSMutableArray array];
    for (int i = 1; i <= total; i++) {
        [qiurarray addObject:[Qiu new]];
    }
    for (int i = 1; i <= total; i+=colorarray.count) {
        for (int j = 1; j <= colorarray.count; j++) {
            if(i+j > total+1){
                break;
            }
            Qiu *sqiu = [qiurarray objectAtIndex:i+j-2];
            sqiu.color = [colorarray objectAtIndex:j-1];
        }
    }
    for (int i = 1; i <= total; i++) {
        Qiu *sqiu = [qiurarray objectAtIndex:i-1];
        UIView *sphereView = [UIView new];
        
//        [sphereView setBackgroundColor:sqiu.color];
        sphereView.layer.cornerRadius = 3.5;
        CGRect rest = CGRectZero;
        
        if(i <= fristnumber){
            CGFloat mainterval = (height - radius*2*fristnumber)/fristnumber;
            CGFloat interval = (height - mainterval - radius*2*fristnumber)/(fristnumber-1);
            rest = CGRectMake(0.5,mainterval/3*2+(i-1)*radius*2+(i-1)*interval, radius*2, radius*2);
        }
        if(i > fristnumber && i <= fristnumber+secondnumber){
            CGFloat mainterval = (width - radius*2*secondnumber)/secondnumber;
             CGFloat interval = (width  - mainterval - radius*2*secondnumber)/(secondnumber-1);
            rest = CGRectMake(mainterval/3*2+(i-fristnumber-1)*radius*2+(i-fristnumber-1)*interval,height-radius*2-1, radius*2, radius*2);
            
        }
        if(i > fristnumber+secondnumber && i <= fristnumber+secondnumber+thirdnumber){
            CGFloat mainterval = (height - radius*2*thirdnumber)/thirdnumber;
            CGFloat interval = (height - mainterval - radius*2*thirdnumber)/(thirdnumber-1);
            rest = CGRectMake(width-radius*2-1,height - (mainterval/3*2+7+(i-fristnumber-secondnumber-1)*radius*2+(i-fristnumber-secondnumber-1)*interval), radius*2, radius*2);
        }
        if(i > fristnumber+secondnumber+thirdnumber && i <= fristnumber+secondnumber+thirdnumber+forthnumber){
            CGFloat mainterval = (width - radius*2*forthnumber)/forthnumber;
            CGFloat interval = (width - mainterval - radius*2*forthnumber)/(forthnumber-1);
            rest = CGRectMake(width-(mainterval/3*2+7+(i-fristnumber-secondnumber-thirdnumber-1)*radius*2+(i-fristnumber-secondnumber-thirdnumber-1)*interval),0.5, radius*2, radius*2);
        }
        sphereView.frame = rest;
       [targetView addSubview:sphereView];
        UIColor *fcolor = sqiu.color;
        if(i > 1){
            fcolor = [self getAdjacentColor:targrtcolor array:colorarray];
        }
       targrtcolor = fcolor;
       UIColor *scolor = [self getAdjacentColor2:fcolor array:colorarray];
       UIColor *tcolor = [self getAdjacentColor2:scolor array:colorarray];
       UIColor *hcolor = [self getAdjacentColor2:tcolor array:colorarray];
       
        [sphereView.layer addAnimation:[self addAnimation:fcolor secondColor:scolor thirdColor:tcolor foreColor:hcolor duration:0.3] forKey:@"backgroundColor"];

    }
}

- (UIColor*) getAdjacentColor:(UIColor*)colorA array:(NSMutableArray *)colorarray
{
    for (int j = 0; j < colorarray.count; j++) {
        UIColor *jcolor = [colorarray objectAtIndex:j];
        if (CGColorEqualToColor(colorA.CGColor, jcolor.CGColor)) {
            if(j == 0){
                return [colorarray objectAtIndex:colorarray.count-1];
            }else{
                return [colorarray objectAtIndex:j-1];
            }
        }
    }
    return colorA;
}

- (UIColor*) getAdjacentColor2:(UIColor*)colorA array:(NSMutableArray *)colorarray
{
    for (int j = 0; j < colorarray.count; j++) {
        UIColor *jcolor = [colorarray objectAtIndex:j];
        if (CGColorEqualToColor(colorA.CGColor, jcolor.CGColor)) {
            if(j == colorarray.count-1){
                return [colorarray objectAtIndex:0];
            }else{
                return [colorarray objectAtIndex:j+1];
            }
        }
    }
    return colorA;
}

//绘制小球
-(void)createSphere:(int)number view:(UIView *)targetView radii:(CGFloat)radii width:(CGFloat)width height:(CGFloat)height radius:(CGFloat)radius firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor state:(TDrawState)state{
    
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
            case TDrawLeft:
                {
                    CGFloat mainterval = (height - radius*2*number)/number;
                    CGFloat interval = (height - mainterval - radius*2*number)/(number-1);
                    rest = CGRectMake(0.5,mainterval/3*2+(i-1)*radius*2+(i-1)*interval, radius*2, radius*2);
                    
                }
                break;
            case TDrawTop:
                {
                    CGFloat mainterval = (width - radius*2*number)/number;
                    CGFloat interval = (width - mainterval - radius*2*number)/(number-1);
                    rest = CGRectMake(mainterval/3+(i-1)*radius*2+(i-1)*interval,0.5, radius*2, radius*2);
                }
                break;
            case TDrawRight:
                {
                    CGFloat mainterval = (height - radius*2*number)/number;
                    CGFloat interval = (height - mainterval - radius*2*number)/(number-1);
                    rest = CGRectMake(width-radius*2-1,mainterval/3+(i-1)*radius*2+(i-1)*interval, radius*2, radius*2);
                }
                break;
            case TDrawBottom:
                {
                    CGFloat mainterval = (width - radius*2*number)/number;
                    CGFloat interval = (width  - mainterval - radius*2*number)/(number-1);
                   rest = CGRectMake(mainterval/3*2+(i-1)*radius*2+(i-1)*interval,height-radius*2-1, radius*2, radius*2);
                }
        }
        sphereView.frame = rest;
        [targetView addSubview:sphereView];
        [sphereView.layer addAnimation:[self addAnimation:[UIColor greenColor] secondColor:[UIColor blueColor] thirdColor:[UIColor yellowColor] foreColor:[UIColor redColor] duration:0.5] forKey:@"backgroundColor"];
       
    }
}

-(CAAnimationGroup *)addAnimation:(UIColor*)firstColor secondColor:(UIColor*)secondColor thirdColor:(UIColor*)thirdColor foreColor:(UIColor*)foreColor duration:(float)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)firstColor.CGColor;
    animation.toValue = (id)secondColor.CGColor;
    animation.duration = duration;
    animation.beginTime = 0.0f;
    animation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation2.fromValue = (id)secondColor.CGColor;
    animation2.toValue = (id)thirdColor.CGColor;
    animation2.duration = duration;
    animation2.beginTime = duration;
    animation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation3.fromValue = (id)thirdColor.CGColor;
    animation3.toValue = (id)foreColor.CGColor;
    animation3.duration = duration;
    animation3.beginTime = duration*2;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation4.fromValue = (id)foreColor.CGColor;
    animation4.toValue = (id)firstColor.CGColor;
    animation4.duration = duration;
    animation4.beginTime = duration*3;
    
    CAAnimationGroup * theGroup = [CAAnimationGroup animation];
    theGroup.duration = duration*4;
    theGroup.repeatCount = MAXFLOAT;
    theGroup.animations = @[animation,animation2,animation3,animation4];
    theGroup.removedOnCompletion = NO;
    theGroup.fillMode = kCAFillModeForwards;
    
    return theGroup;
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
