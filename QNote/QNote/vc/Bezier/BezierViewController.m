//
//  BezierViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/9.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierViewController.h"
#import <Masonry.h>

@interface BezierViewController ()

@end

/**
 *  参考
 *  http://www.jianshu.com/p/999ad5ae6edf
 *  http://www.jianshu.com/p/281373b6d1a8
 
 *  
 *  drawrect之后背景色是黑色的 不能修改 
 *  http://blog.csdn.net/xyzdm123/article/details/46891001
 */

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     
     [[UIColor blackColor] setStroke];　　　　// 设置边框颜色
     [[UIColor blueColor] setFill];　　　　　　// 设置背景填充色
     [[UIColor greenColor] set];　　　　　　　　// 设置字符颜色
     
     */
    
    
    
    
    
    
    
    __block UIScrollView * scrollV = [[UIScrollView alloc] init];
    [self.view addSubview:scrollV];
    
    
    NSArray * list = @[
  @{@"title":@"一阶曲线",@"class":@"BezierLineV"},
  @{@"title":@"二三阶曲线",@"class":@"BezierCurveV"},
  @{@"title":@"矩形",@"class":@"BezierRect"},
  @{@"title":@"圆弧",@"class":@"BezierArc"},
  @{@"title":@"三角",@"class":@"BezierTriangle"},
  @{@"title":@"聊天泡泡",@"class":@"BezierChatPopV"},
  @{@"title":@"CAKeyFrameAnimation",@"class":@"BeizerFrameAnimationV"},
  @{@"title":@"与Shapelayer应用",@"method":@"createShapeLayer:"},
  @{@"title":@"阴影Shadow",@"method":@"createShadowLayer:"},
  @{@"title":@"波浪线",@"method":@"createWaveLayer:"}
  
  ];
   
    NSMutableArray * bezierViews = [[NSMutableArray alloc] init];
    
    for(NSDictionary * dataDic in [list reverseObjectEnumerator])
//    for(NSDictionary * dataDic in list)
    {
        UIView * subV = [self bezierElementViewWithDic:dataDic];
        [scrollV addSubview:subV];
        subV.backgroundColor = [UIColor grayColor];
        [bezierViews addObject:subV];
    }
    
    __weak typeof(&*self)weakSelf = self;
    
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [bezierViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    
    [bezierViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(300);
    }];
    
}


- (UIView *)bezierElementViewWithDic:(NSDictionary *)dataDic
{
    __block UIView * contentV = [UIView new];
    contentV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05];
    
    NSString * title = dataDic[@"title"];
    NSString * classStr = dataDic[@"class"];
    NSString * method = dataDic[@"method"];
    
    __block UILabel * lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor lightGrayColor];
    lab.text = title;
    [contentV addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentV);
        make.height.mas_equalTo(20);
    }];
    
    if(classStr)
    {
        UIView * bezierV = [NSClassFromString(classStr) new];
        [contentV addSubview:bezierV];
        
        [bezierV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lab.mas_bottom);
            make.left.right.bottom.equalTo(contentV);
        }];
    }
    else if (method)
    {
        SEL methodSEL = NSSelectorFromString(method);
        if([self respondsToSelector:methodSEL])
        {
            //http://www.th7.cn/Program/IOS/201406/219744.shtml
//            IMP imp = [self methodForSelector:methodSEL];
//            void(*func)(id, SEL) = (void *)imp;
//            func(self,methodSEL);
            
//            [self performSelector:methodSEL withObject:contentV];
            
            [self performSelectorOnMainThread:methodSEL withObject:contentV waitUntilDone:YES];
        }
    }
    
    return contentV;
}


#pragma mark - Layer -

- (void)createWaveLayer:(UIView *)superV
{
    CGFloat offY = 30;
    CGFloat offX = 10;
    
    CGFloat waveWidth = 5;
    CGFloat waveHeight = 5;
    
    CGFloat width = CGRectGetWidth(self.view.frame)-2*offX;
    
    CAShapeLayer * layer1 = [[CAShapeLayer alloc] init];
    layer1.lineWidth = 1;
    layer1.fillColor = [UIColor clearColor].CGColor;
    layer1.strokeColor = [UIColor blueColor].CGColor;
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(offX, offY)];
    path1.lineJoinStyle = kCGLineJoinRound;
    
    for(int i=0; i < width/waveWidth; i++)
    {
        [path1 addLineToPoint:CGPointMake(offX+(i+0.5)*waveWidth, offY)];
        [path1 addLineToPoint:CGPointMake(offX+(i+1)*waveWidth, offY+waveHeight)];
    }
    layer1.path = path1.CGPath;
    
    [superV.layer addSublayer:layer1];
    
    
    
    
    waveWidth = 10;
    waveHeight = 10;
    offY = offY + 30;
    
    CAShapeLayer * layer2 = [[CAShapeLayer alloc] init];
    layer2.lineWidth = 1;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.strokeColor = [UIColor blueColor].CGColor;
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(offX, offY)];
    path2.lineJoinStyle = kCGLineJoinRound;
    
    for(int i=0; i < width/waveWidth; i++)
    {
        [path2 addArcWithCenter:CGPointMake(offX+(i+0.25)*waveWidth, offY) radius:waveWidth*0.25 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
        [path2 addArcWithCenter:CGPointMake(offX+(i+0.75)*waveWidth, offY) radius:waveWidth*0.25 startAngle:M_PI endAngle:M_PI*2 clockwise:NO];
    }
    layer2.path = path2.CGPath;
    
    [superV.layer addSublayer:layer2];
    
    
    
    waveWidth = 20;
    waveHeight = 20;
    offY = offY + 60;
    
    CAShapeLayer * layer3 = [[CAShapeLayer alloc] init];
    layer3.lineWidth = 1;
    layer3.fillColor = [UIColor clearColor].CGColor;
    layer3.strokeColor = [UIColor blueColor].CGColor;
    
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(offX, offY)];
    path3.lineJoinStyle = kCGLineJoinRound;
    
    for(int i=0; i < width/waveWidth; i++)
    {
        [path3 addArcWithCenter:CGPointMake(offX+(i+0.5)*waveWidth, offY) radius:waveWidth*0.5 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
    }
    layer3.path = path3.CGPath;
    
    [superV.layer addSublayer:layer3];
    
    
    
    
    offY = offY + 90;
    
    CAShapeLayer * layer4 = [[CAShapeLayer alloc] init];
    layer4.lineWidth = 1;
    layer4.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor;
    layer4.strokeColor = [UIColor blueColor].CGColor;
    
    UIBezierPath * path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(offX, offY)];
    path4.lineJoinStyle = kCGLineJoinRound;
    
    for(int i=0; i < width/waveWidth; i++)
    {
        [path4 addArcWithCenter:CGPointMake(offX+(i+0.5)*waveWidth, offY) radius:waveWidth*0.5 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
    }
    [path4 addLineToPoint:CGPointMake(offX+width, offY+80)];
    [path4 addLineToPoint:CGPointMake(offX, offY+80)];
    [path4 closePath];
    
    layer4.path = path4.CGPath;
    
    [superV.layer addSublayer:layer4];
    
    
}

- (void)createShadowLayer:(UIView *)superV
{
    //如果有很多视图都用设置了阴影 指定阴影的路径会解决阴影的卡顿问题
    
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30,  CGRectGetWidth(self.view.frame)-20, 260)];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [UIImage imageNamed:@"katong.jpg"];
    [superV addSubview:imageV];
    
    imageV.layer.shadowPath = [UIBezierPath bezierPathWithRect:imageV.bounds].CGPath;
    imageV.layer.shadowColor = [UIColor redColor].CGColor;
    imageV.layer.shadowOpacity = 0.5;
    imageV.layer.shadowRadius = 7;
    imageV.layer.masksToBounds = NO;

}

- (void)createShapeLayer:(UIView *)superV
{
    CGFloat width = CGRectGetWidth(self.view.frame)-20;
    CGFloat height = 260;
    
    CAShapeLayer * layer1 = [[CAShapeLayer alloc] init];
    layer1.fillColor = [[UIColor orangeColor] colorWithAlphaComponent:0.1].CGColor;
    layer1.strokeColor = [UIColor orangeColor].CGColor;
    layer1.path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 30, width*0.25, height * 0.25)].CGPath;
    layer1.lineWidth = 1;
    
    [superV.layer addSublayer:layer1];
    
    
    CAShapeLayer * layer2 = [[CAShapeLayer alloc] init];
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.strokeColor = [UIColor greenColor].CGColor;
    layer2.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width*0.5, height * 0.25) radius:40 startAngle:0 endAngle:M_PI*1.5 clockwise:YES].CGPath;
    
    [superV.layer addSublayer:layer2];

    
    height = height + 30;

    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(30, height*0.65)];
    [path3 addLineToPoint:CGPointMake(30, height)];
    [path3 addLineToPoint:CGPointMake(width, height)];
    [path3 addLineToPoint:CGPointMake(width, height*0.65)];
    [path3 addQuadCurveToPoint:CGPointMake(30, height*0.65) controlPoint:CGPointMake((width-30)*0.5+30, height*0.65-100)];
    
    [path3 closePath];
    
    
    CAShapeLayer * layer3 = [[CAShapeLayer alloc] init];
    layer3.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor;
    layer3.strokeColor = [UIColor yellowColor].CGColor;
    
    layer3.path = path3.CGPath;
    
    [superV.layer addSublayer:layer3];
}



- (UIColor *)colorRandom
{
    CGFloat red = random()/RAND_MAX;
    CGFloat green = random()/RAND_MAX;
    CGFloat blue = random()/RAND_MAX;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
