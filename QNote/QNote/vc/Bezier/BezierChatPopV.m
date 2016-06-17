//
//  BezierChatPopV.m
//  QNote
//
//  Created by 林宁宁 on 16/6/16.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierChatPopV.h"

/**
 *  参考
 *  http://www.jianshu.com/p/c3af3e37c95f
 */

@implementation BezierChatPopV

-(void)drawRect:(CGRect)rect
{
    CGFloat w = CGRectGetWidth(rect) - 10;
    CGFloat h = CGRectGetHeight(rect) - 10;
    
    CGFloat radius = 8;
    CGFloat angleWidth = 6;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 1;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    [bezierPath moveToPoint:CGPointMake(w-angleWidth,h-radius)];
    [bezierPath addArcWithCenter:CGPointMake(w-radius-angleWidth, h-radius) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
    [bezierPath addArcWithCenter:CGPointMake(radius, h-radius) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
    [bezierPath addArcWithCenter:CGPointMake(radius,radius) radius:radius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
    [bezierPath addArcWithCenter:CGPointMake(w-radius-angleWidth, radius) radius:radius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(w-angleWidth,40/2-angleWidth)];
    [bezierPath addLineToPoint:CGPointMake(w, 40/2)];
    [bezierPath addLineToPoint:CGPointMake(w-angleWidth, 40/2+angleWidth)];
    
 
    
//    [bezierPath moveToPoint:CGPointMake(w,h-radius)];
//    [bezierPath addArcWithCenter:CGPointMake(w-radius, h-radius) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
//    [bezierPath addArcWithCenter:CGPointMake(radius+angleWidth, h-radius) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
//    [bezierPath addLineToPoint:CGPointMake(angleWidth, 40/2+angleWidth)];
//    [bezierPath addLineToPoint:CGPointMake(0, 40/2)];
//    [bezierPath addLineToPoint:CGPointMake(angleWidth,40/2-angleWidth)];
//    [bezierPath addArcWithCenter:CGPointMake(radius+angleWidth,radius) radius:radius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
//    [bezierPath addArcWithCenter:CGPointMake(w-radius, radius) radius:radius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
    
    
    [bezierPath closePath];
    
    [[UIColor redColor] set];
    [bezierPath stroke];
    
    [[UIColor orangeColor] set];
    [bezierPath fill];
    
//    CAShapeLayer *shapLayer = [CAShapeLayer layer];
//    shapLayer.path = bezierPath.CGPath;
//    
//    boarderLayer.path = bezierPath.CGPath;
//    boarderLayer.frame=_photoImageView.bounds;
//    
//    _photoImageView.layer.mask = shapLayer;
}

@end
