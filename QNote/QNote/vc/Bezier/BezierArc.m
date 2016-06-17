//
//  BezierArc.m
//  QNote
//
//  Created by 林宁宁 on 16/6/16.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierArc.h"

@implementation BezierArc

-(void)drawRect:(CGRect)rect
{
    [[UIColor lightTextColor] setStroke];
    UIRectFill(rect);
    
    /**
     *  startAngle 开始点  右边的未开始点
     *  endAngle   结束点
     */
    
    //四分之三圆弧 clockwise 是否顺时针
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:M_PI*0.5 endAngle:M_PI*1.5 clockwise:YES];
    
    path1.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [path1 stroke];
    
    
    //逆时针
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(250, 100) radius:40 startAngle:0 endAngle:M_PI*0.5 clockwise:NO];
    
    path2.lineWidth = 5;
    [[UIColor blueColor] setStroke];
    [path2 stroke];
    
    
    //圆
    UIBezierPath * path3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(120, 120, 100, 100)];
    
    [[UIColor greenColor] set];
    [path3 fill];
    
    [[UIColor blueColor] set];
    
    [path3 stroke];
    
    
    //椭圆 根据这个rect绘制园
    UIBezierPath * path4 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(240, 120, 120, 100)];
    
    [[UIColor greenColor] set];
    [path4 fill];
    
    [[UIColor blueColor] set];
    [path4 stroke];
}

@end
