//
//  GraphicsSimple.m
//  QNote
//
//  Created by 林宁宁 on 16/7/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "GraphicsSimple.h"

@implementation GraphicsSimple

-(void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable(); //create path
    
    CGPathMoveToPoint(path, nil, 20, 50);//setting start postion
    
    CGPathAddLineToPoint(path, nil, 20, 100);//draw line
    
    CGContextAddPath(context, path);
    
}

@end
