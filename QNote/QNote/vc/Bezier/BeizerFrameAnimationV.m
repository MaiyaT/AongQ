//
//  BeizerFrameAnimationV.m
//  QNote
//
//  Created by 林宁宁 on 16/6/16.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BeizerFrameAnimationV.h"

/**
 *  参考 http://www.jianshu.com/p/4824fc4ce4b0
 */
@implementation BeizerFrameAnimationV

-(void)drawRect:(CGRect)rect
{
    //绘制小球
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = (CGRect){CGPointMake(30, 100), CGSizeMake(30, 30)};
    shapeLayer.backgroundColor = [UIColor purpleColor].CGColor;
    shapeLayer.cornerRadius = 15;
    shapeLayer.masksToBounds = YES;
    [self.layer addSublayer:shapeLayer];
    
    //定义小球轨迹路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    //起始点
    [bezierPath moveToPoint:CGPointMake(30, 150)];
    //终点，控制点1，控制点2
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(100, -50) controlPoint2:CGPointMake(200,350)];
    bezierPath.lineWidth = 2;
    
    //路径的展示层
    CAShapeLayer * trackLayer = [CAShapeLayer layer];
    trackLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    trackLayer.strokeColor = [UIColor grayColor].CGColor;
    trackLayer.path = bezierPath.CGPath;
    trackLayer.fillColor = nil;
    [self.layer addSublayer:trackLayer];
    
    //创建小球轨迹动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.fillMode=kCAFillModeRemoved;
    anim.removedOnCompletion = NO;
    anim.path = bezierPath.CGPath;
    anim.duration = 3;
    anim.repeatCount = 20;
    anim.autoreverses = YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [shapeLayer addAnimation:anim forKey:nil];
}

@end
