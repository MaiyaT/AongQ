//
//  YHProgressCutDownView.m
//  QNote
//
//  Created by 林宁宁 on 16/6/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "YHProgressCutDownView.h"

@interface YHProgressCutDownView()

/**
 *  已倒计时多少
 */
@property (assign, nonatomic, readwrite) double downTimeAlready;


/**
 *  时间标签
 */
@property (retain, nonatomic, readwrite) UILabel * timerLab;

/**
 *  定时器
 */
@property (retain, nonatomic, readwrite) NSTimer * timer;

@end

@implementation YHProgressCutDownView

-(void)beginTimer
{
//    [self reBuildCircleLayer];
    
    [self endTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    [self.timer fire];
}

- (void)endTimer
{
    if(self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.downTimeAlready = 0;
}


- (void)timerEvent
{
    
    self.downTimeAlready = fmin(self.downTimeAlready + 0.1, self.downTimeTotalInterval);
    
    if(self.downTimeAlready == self.downTimeTotalInterval)
    {
        [self endTimer];
        
        if(self.downFinishBlock)
        {
            self.downFinishBlock(self);
        }
    }
}

-(void)setDownTimeAlready:(double)downTimeAlready
{
    _downTimeAlready = downTimeAlready;
    
    float progress = self.downTimeAlready/self.downTimeTotalInterval;
    
    self.strokeEnd = progress;

    
    if(self.timerLab)
    {
        self.timerLab.text = [NSString stringWithFormat:@"%.1f",self.downTimeAlready];
    }
}


- (void)setNeedShowTimeLab:(BOOL)needShowTimeLab
{
    _needShowTimeLab = needShowTimeLab;
    
    if(needShowTimeLab)
    {
        if(!self.timerLab)
        {
            self.timerLab = [[UILabel alloc] initWithFrame:CGRectMake(-10, -10, self.bounds.size.width+20, self.bounds.size.height+20)];
            self.timerLab.backgroundColor = [UIColor clearColor];
            self.timerLab.textColor = [UIColor blackColor];
            self.timerLab.textAlignment = NSTextAlignmentCenter;
            self.timerLab.font = [UIFont systemFontOfSize:30];
            [self addSubview:self.timerLab];
            
//            self.timerLab.center = self.center;
        }
    }
    else
    {
        if(self.timerLab)
        {
            [self.timerLab removeFromSuperview];
            self.timerLab = nil;
        }
    }
}



@end
