//
//  YHProgressView.m
//  QNote
//
//  Created by 林宁宁 on 16/6/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "YHProgressView.h"

@interface YHProgressView()

@property (nonatomic, strong) CAShapeLayer *ringAnimatedLayer;

@property (nonatomic, strong) CAShapeLayer *pointAnimatedLayer;

@property (nonatomic, strong) CAShapeLayer *bgLineAnimatedLayer;


@end

@implementation YHProgressView


- (void)willMoveToSuperview:(UIView*)newSuperview {
    if (newSuperview) {
        [self layoutAnimatedLayer];
    } else {
        [self cleanLayers];
    }
}

- (void)reBuildCircleLayer
{    
    [self cleanLayers];
    
    [self layoutAnimatedLayer];
}

- (void)cleanLayers
{
    [_ringAnimatedLayer removeFromSuperlayer];
    _ringAnimatedLayer = nil;
    
    [_pointAnimatedLayer removeFromSuperlayer];
    _pointAnimatedLayer = nil;
    
    [_bgLineAnimatedLayer removeFromSuperlayer];
    _bgLineAnimatedLayer = nil;
}

- (void)layoutAnimatedLayer {
    CALayer *layer = self.ringAnimatedLayer;
    [self.layer addSublayer:layer];

    CGFloat widthDiff = CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds);
    CGFloat heightDiff = CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds);
    layer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds) / 2 - widthDiff / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds) / 2 - heightDiff / 2);
    
    
    
    CALayer * pointLayer = self.pointAnimatedLayer;
    [self.layer addSublayer:pointLayer];
    
    widthDiff = CGRectGetWidth(self.bounds) - CGRectGetWidth(pointLayer.bounds);
    heightDiff = CGRectGetHeight(self.bounds) - CGRectGetHeight(pointLayer.bounds);
    pointLayer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(pointLayer.bounds) / 2 - widthDiff / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(pointLayer.bounds) / 2 - heightDiff / 2);
    
    
    [self addBgStrokeLineLayer];
    
    
    
    [self updateOffsetStart];
}

/**
 *  圆环旋转多少度角
 */
- (void)updateOffsetStart
{
    self.ringAnimatedLayer.transform = CATransform3DMakeRotation(self.strokeStartOffset, 0, 0, 1);
    self.pointAnimatedLayer.transform = CATransform3DMakeRotation(self.strokeStartOffset, 0, 0, 1);
}

- (CAShapeLayer*)ringAnimatedLayer
{
    if(!_ringAnimatedLayer) {
        
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:[self centerPoint] radius:self.radius startAngle:(CGFloat)-M_PI_2 endAngle:(CGFloat) (M_PI + M_PI_2) clockwise:YES];
        
        _ringAnimatedLayer = [CAShapeLayer layer];
        _ringAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _ringAnimatedLayer.frame = CGRectMake(0.0f, 0.0f, [self centerPoint].x*2, [self centerPoint].y*2);
        _ringAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
        _ringAnimatedLayer.strokeColor = self.strokeColor.CGColor;
        _ringAnimatedLayer.lineWidth = self.strokeThickness;
        _ringAnimatedLayer.lineCap = kCALineCapRound;
        _ringAnimatedLayer.lineJoin = kCALineJoinBevel;
        _ringAnimatedLayer.path = smoothedPath.CGPath;
    }
    return _ringAnimatedLayer;
}

- (CAShapeLayer*)pointAnimatedLayer
{
    if(!_pointAnimatedLayer) {
        CGPoint arcCenter = CGPointMake(self.radius+self.pointRadius/2+5, self.radius+self.pointRadius/2+5);
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:self.radius startAngle:(CGFloat)-M_PI_2 endAngle:(CGFloat) (M_PI + M_PI_2) clockwise:YES];
        
        _pointAnimatedLayer = [CAShapeLayer layer];
        _pointAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _pointAnimatedLayer.frame = CGRectMake(0.0f, 0.0f, arcCenter.x*2, arcCenter.y*2);
        _pointAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
        _pointAnimatedLayer.strokeColor = self.pointColor.CGColor;
        _pointAnimatedLayer.lineWidth = self.pointRadius;
        //圆角设置
        _pointAnimatedLayer.lineCap = kCALineCapRound;
        _pointAnimatedLayer.lineJoin = kCALineJoinBevel;
        _pointAnimatedLayer.path = smoothedPath.CGPath;
    }
    return _pointAnimatedLayer;
}



- (void)setFrame:(CGRect)frame {
    if(!CGRectEqualToRect(frame, super.frame)) {
        [super setFrame:frame];
        
        if(self.superview) {
            [self layoutAnimatedLayer];
        }
    }
    
}

- (void)setRadius:(CGFloat)radius {
    if(radius != _radius) {
        _radius = radius;
        
        [self cleanLayers];
        
        if(self.superview) {
            [self layoutAnimatedLayer];
        }
    }
}

-(void)setPointColor:(UIColor *)pointColor
{
    _pointColor = pointColor;
    
    _pointAnimatedLayer.strokeColor = pointColor.CGColor;
}

-(void)setPointRadius:(CGFloat)pointRadius
{
    _pointRadius = pointRadius;
    
    _pointAnimatedLayer.lineWidth = pointRadius;
}

- (void)setStrokeColor:(UIColor*)strokeColor {
    _strokeColor = strokeColor;
    _ringAnimatedLayer.strokeColor = strokeColor.CGColor;
}

- (void)setStrokeThickness:(CGFloat)strokeThickness {
    _strokeThickness = strokeThickness;
    _ringAnimatedLayer.lineWidth = _strokeThickness;
}

- (void)setStrokeEnd:(CGFloat)strokeEnd {
    
    _strokeEnd = strokeEnd;
    
    _ringAnimatedLayer.strokeEnd = _strokeEnd;
    
    //周长
//    float girth = 2*M_PI*self.radius;
    
    //计算这个point的start和end所占用这个角弧度值
    //余弦定理  cosc = (a*a + b*b - c*c)/(2*a*b);
    float radian = cosf((self.radius*self.radius+self.radius*self.radius - (self.pointRadius*2)*(self.pointRadius*2)))/(2*self.radius*self.radius);
    
    //头部点所占路劲的周长
    float offsetProgress = radian/(M_PI*2);
    
    
    _pointAnimatedLayer.strokeStart = _strokeEnd-offsetProgress;
    _pointAnimatedLayer.strokeEnd = MIN(_strokeEnd, 1);
}


-(void)setStrokeStartOffset:(CGFloat)strokeStartOffset
{
    _strokeStartOffset = strokeStartOffset;
    
    [self updateOffsetStart];
}


- (float)remainderNumOnewithValue:(float)value
{
    if(value > 1)
    {
        return value - 1;
    }
    return value;
}



- (void)setStrokeBackgroundColor:(UIColor *)strokeBackgroundColor
{
    _strokeBackgroundColor = strokeBackgroundColor;
    
    [self addBgStrokeLineLayer];
}


- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake((self.radius+self.strokeThickness/2+5)*2, (self.radius+self.strokeThickness/2+5)*2);
}


- (void)addBgStrokeLineLayer
{
    if(self.bgLineAnimatedLayer)
    {
        [self.bgLineAnimatedLayer removeFromSuperlayer];
        self.bgLineAnimatedLayer = nil;
    }
    
    
    
    UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:[self centerPoint] radius:self.radius startAngle:(CGFloat)-M_PI_2 endAngle:(CGFloat) (M_PI + M_PI_2) clockwise:YES];
    
    CAShapeLayer * bgLineLayer = [CAShapeLayer layer];
    self.bgLineAnimatedLayer = bgLineLayer;
    bgLineLayer.contentsScale = [[UIScreen mainScreen] scale];
    bgLineLayer.frame = CGRectMake(0.0f, 0.0f, [self centerPoint].x*2, [self centerPoint].y*2);
    bgLineLayer.fillColor = [UIColor clearColor].CGColor;
    bgLineLayer.strokeColor = self.strokeBackgroundColor.CGColor;
    bgLineLayer.lineWidth = self.strokeThickness;
    bgLineLayer.lineCap = kCALineCapRound;
    bgLineLayer.lineJoin = kCALineJoinBevel;
    bgLineLayer.path = smoothedPath.CGPath;
    
    
    [self.layer insertSublayer:self.bgLineAnimatedLayer below:self.ringAnimatedLayer];

    self.bgLineAnimatedLayer.position = self.ringAnimatedLayer.position;
}

- (CGPoint)centerPoint
{
    CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
    
    return arcCenter;
}


@end
