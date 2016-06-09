//
//  YHProgressView.h
//  QNote
//
//  Created by 林宁宁 on 16/6/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHProgressView : UIView

/**
 *  圆环半径
 */
@property (nonatomic, assign) CGFloat radius;

/**
 *  进度路劲粗细
 */
@property (nonatomic, assign) CGFloat strokeThickness;

/**
 *  路劲颜色
 */
@property (nonatomic, strong) UIColor * strokeColor;

/**
 *  路劲的终点位置 设置这个可以直接更新视图 自动动画
 */
@property (nonatomic, assign) CGFloat strokeEnd;

/**
 *  路劲头部点的颜色
 */
@property (nonatomic, strong) UIColor * pointColor;

/**
 *  头部点的大小
 */
@property (nonatomic, assign) CGFloat pointRadius;

/**
 *  路径线条的背景色
 */
@property (nonatomic, strong) UIColor * strokeBackgroundColor;



/**
 *  初始路劲起点的位置  M_PI 弧度值
 */
@property (nonatomic, assign) CGFloat strokeStartOffset;

/**
 *  重绘 路劲线条 移除再添加
 */
- (void)reBuildCircleLayer;

@end
