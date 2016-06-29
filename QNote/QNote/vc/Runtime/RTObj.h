//
//  RTObj.h
//  QNote
//
//  Created by 林宁宁 on 16/6/23.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RTDelegate;
@protocol RTDataSource;


@interface RTObj : NSObject<NSSecureCoding>
{
    NSInteger _itemIndexPage;
    NSInteger _itemAllCount;
    NSInteger _itemTag;
    NSString * _itemPath;
    NSArray * _itemDataList;
    NSDictionary * _itemParmeter;
}


@property (copy, nonatomic ) NSString * itemID;

@property (copy, nonatomic ) NSString * itemName;

@property (copy, nonatomic ) NSString * itemIconURL;

@property (copy, nonatomic ) NSString * itemTitle;

@property (copy, nonatomic ) NSString * itemSubTitle;

@property (copy, nonatomic , readonly) NSString * itemContent;

@property (weak, nonatomic) id<RTDelegate> itemRTDelegate;

@property (weak, nonatomic) id<RTDataSource> itemRTDataSource;

- (void)readDataFromLocal;

- (void)saveDataToLocal;


/**
 *  获取方法列表
 */
- (void)getListMethod;

/**
 *  获取属性列表
 */
- (void)getListProperty;

/**
 *  获取成员变量列表
 */
- (void)getListIvar;

/**
 *  获取协议列表
 */
- (void)getListProtocol;

- (void)test:(NSString *)str;


- (NSArray *)getDataList;

+ (double)getCellheight;



- (void)methodExchange1;
- (void)methodExchange2;
- (void)methodExchange3;
- (void)methodExchange4;


/**
 *  将要被替代的方法
 */
- (void)willBeInterceptMethod;



@end



@protocol RTDelegate <NSObject>

- (void)rtReload;

@end

@protocol RTDataSource <NSObject>

- (NSArray *)rtDataList;

@end
