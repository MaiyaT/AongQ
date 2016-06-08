//
//  YHProgressView.h
//  QNote
//
//  Created by 林宁宁 on 16/6/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHProgressView : UIView


@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat strokeThickness;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeEnd;
//@property (nonatomic, assign) CGFloat strokeStart;


@property (nonatomic, strong) UIColor * pointColor;

@property (nonatomic, assign) CGSize pointSize;

@property (nonatomic, strong) UIColor * strokeBackgroundColor;


@property (nonatomic, strong, readonly) CAShapeLayer *ringAnimatedLayer;


/**
 *  起始进度的位置  M_PI
 */
@property (nonatomic, assign) CGFloat strokeStartOffset;

- (void)reBuildCircleLayer;

@end
