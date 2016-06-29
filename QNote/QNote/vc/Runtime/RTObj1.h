//
//  RTObj1.h
//  QNote
//
//  Created by 林宁宁 on 16/6/27.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTObj1 : NSObject

@property (nonatomic, assign) int status;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSArray *cities;

@property (nonatomic, strong) NSDictionary *config;

- (void)doThisMethod;

/**
 *  通过字典 拼接出其中所有的 属性类型字符串
 */
+ (void)logAllPropertyAtDataDic:(NSDictionary *)dataDic;

+ (instancetype)modelWithDataDic:(NSDictionary *)dataDic;

@end
