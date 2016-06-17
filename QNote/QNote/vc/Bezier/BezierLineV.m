//
//  BezierLineV.m
//  QNote
//
//  Created by 林宁宁 on 16/6/9.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierLineV.h"

@implementation BezierLineV

-(void)drawRect:(CGRect)rect
{
    [[UIColor lightGrayColor] setFill];
    UIRectFill(rect);

    //圆角直线 在线的两端添加一个 圆 半径linewide的一半
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 10;
    path1.lineCapStyle = kCGLineCapRound;
    
    [path1 moveToPoint:CGPointMake(10, 10)];
    [path1 addLineToPoint:CGPointMake(100, 100)];
    
    [[UIColor redColor] setStroke];
    
    [path1 stroke];
    
    
    //直角直线 在线的两端添加一个 正方形 边长linewide一样
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    path2.lineWidth = 20;
    path2.lineCapStyle = kCGLineCapSquare;
    
    [path2 moveToPoint:CGPointMake(50, 10)];
    [path2 addLineToPoint:CGPointMake(150, 100)];
    
    [[UIColor blueColor] setStroke];
    [path2 stroke];
    
    
    //直角 默认
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    path3.lineWidth = 20;
    path3.lineCapStyle = kCGLineCapButt;
    
    [path3 moveToPoint:CGPointMake(100, 10)];
    [path3 addLineToPoint:CGPointMake(200, 100)];
    
    [[UIColor yellowColor] setStroke];
    [path3 stroke];
    
    
    //两条线接头形式  圆角
    UIBezierPath * path4 = [UIBezierPath bezierPath];
    path4.lineWidth = 10;
    path4.lineCapStyle = kCGLineCapRound;
    path4.lineJoinStyle = kCGLineJoinRound;
    
    [path4 moveToPoint:CGPointMake(150, 10)];
    [path4 addLineToPoint:CGPointMake(250, 100)];
    [path4 addLineToPoint:CGPointMake(150, 200)];
    
    [[UIColor redColor] setStroke];
    
    [path4 stroke];
    
    
    //两条线接头形式  直角
    UIBezierPath * path5 = [UIBezierPath bezierPath];
    path5.lineWidth = 10;
    path5.lineCapStyle = kCGLineCapRound;
    path5.lineJoinStyle = kCGLineJoinMiter;
    
    [path5 moveToPoint:CGPointMake(200, 10)];
    [path5 addLineToPoint:CGPointMake(300, 100)];
    [path5 addLineToPoint:CGPointMake(200, 200)];
    
    [[UIColor blueColor] setStroke];
    
    [path5 stroke];
    
    
    
    //两条线接头形式  切面
    UIBezierPath * path6 = [UIBezierPath bezierPath];
    path6.lineWidth = 10;
    path6.lineCapStyle = kCGLineCapRound;
    path6.lineJoinStyle = kCGLineJoinBevel;
    
    [path6 moveToPoint:CGPointMake(250, 10)];
    [path6 addLineToPoint:CGPointMake(350, 100)];
    [path6 addLineToPoint:CGPointMake(250, 200)];
    
    [[UIColor blueColor] setStroke];
    
    [path6 stroke];
    
}


@end
