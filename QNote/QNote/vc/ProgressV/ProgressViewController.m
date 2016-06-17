//
//  ProgressViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/7.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "ProgressViewController.h"
#import "YHProgressCutDownView.h"

/**
 *  参考
 *  SVProgressHub
 */

@interface ProgressViewController ()


@property (retain, nonatomic) YHProgressView * ringView;

@property (retain, nonatomic) YHProgressCutDownView * curdownView;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ringView = [[YHProgressView alloc] initWithFrame:CGRectMake(60, 200, 50, 50)];
    
    
    /**
     *  线条颜色
     */
    self.ringView.strokeColor = [UIColor redColor];
    /**
     *  线条的粗细
     */
    self.ringView.strokeThickness = 4;
    /**
     *  圆环的半径
     */
    self.ringView.radius = 50;
    /**
     *  进度比例
     */
    self.ringView.strokeEnd = 0.5;
    
    /**
     *  点的颜色
     */
    self.ringView.pointColor = [UIColor greenColor];
    
    /**
     *  点的大小
     */
    self.ringView.pointRadius = 10;
    
    /**
     *  线条的背景色
     */
    self.ringView.strokeBackgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.ringView];
    
    
    
    
    
    
    self.curdownView = [[YHProgressCutDownView alloc] initWithFrame:CGRectMake(230, 200, 50, 50)];

    self.curdownView.strokeColor = [UIColor blueColor];
    self.curdownView.strokeThickness = 1;
    self.curdownView.radius = 50;
    self.curdownView.strokeEnd = 0.5;
    self.curdownView.pointColor = [UIColor blackColor];
    self.curdownView.pointRadius = 4;
    self.curdownView.strokeBackgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    
    self.curdownView.downTimeTotalInterval = 10;
    self.curdownView.needShowTimeLab = YES;
    
    [self.view addSubview:self.curdownView];
    
    
    
    
    UISlider * sliderV = [[UISlider alloc] initWithFrame:CGRectMake(50, 300, CGRectGetWidth(self.view.frame)-100, 20)];
    [sliderV addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventValueChanged];
    sliderV.maximumValue = 1;
    [self.view addSubview:sliderV];
    
    
    self.ringView.strokeEnd = 0.5;
    self.curdownView.strokeEnd = 0.3;
    
    [self.curdownView beginTimer];
    
    
    self.curdownView.strokeStartOffset = -M_PI_2;
    
    
    [self.curdownView setDownFinishBlock:^(YHProgressCutDownView * progressV) {
        
        //继续正计时
        [progressV beginTimer];
        
    }];
}

- (void)sliderEvent:(UISlider *)sender
{
    self.ringView.strokeEnd = sender.value;
    
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
