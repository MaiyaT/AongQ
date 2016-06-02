//
//  SecureObj.h
//  QNote
//
//  Created by 林宁宁 on 16/6/2.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecureObj : NSObject<NSSecureCoding>

@property (retain, nonatomic) NSMutableArray * dataList;

@property (retain, nonatomic) SecureObj * superObj;

@property (copy, nonatomic) NSString * secureTitle;

@property (assign, nonatomic) NSInteger secureIndex;

/** 获取属性的名字*/
- (NSArray *)getPropertyNames;

@end
