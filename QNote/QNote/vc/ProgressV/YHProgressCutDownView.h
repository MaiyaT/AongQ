//
//  YHProgressCutDownView.h
//  QNote
//
//  Created by 林宁宁 on 16/6/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "YHProgressView.h"

@interface YHProgressCutDownView : YHProgressView

/**
 *  倒计时的总时间
 */
@property (assign, nonatomic) float downTimeTotalInterval;

/**
 *  已倒计时多少
 */
@property (assign, nonatomic, readonly) double downTimeAlready;

/**
 *  定时器
 */
@property (retain, nonatomic, readonly) NSTimer * timer;

/**
 *  需要显示中间的时间标签
 */
@property (assign, nonatomic) BOOL needShowTimeLab;

/**
 *  时间标签
 */
@property (retain, nonatomic, readonly) UILabel * timerLab;

/**
 *  倒计时结束了
 */
@property (copy, nonatomic) void(^downFinishBlock)(YHProgressCutDownView * progressV);

- (void)beginTimer;
- (void)endTimer;

@end
