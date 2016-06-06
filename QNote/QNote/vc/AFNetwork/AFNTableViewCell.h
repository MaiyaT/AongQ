//
//  AFNTableViewCell.h
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNPost.h"

@interface AFNTableViewCell : UITableViewCell

@property (nonatomic, strong) AFNPost *post;

+ (CGFloat)heightForCellWithPost:(AFNPost *)post;

+ (NSString *)cellIdentify;

@end
