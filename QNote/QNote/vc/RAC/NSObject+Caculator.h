//
//  NSObject+Caculator.h
//  QNote
//
//  Created by 林宁宁 on 16/7/6.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculatorMaker;

@interface NSObject (Caculator)

+ (int)makeCaculator:(void(^)(CaculatorMaker * make))coculatorMaker;

@end




@interface CaculatorMaker : NSObject

@property (assign, nonatomic) int result;

@property (assign, nonatomic) BOOL isEqual;

//链式

//@property (copy, nonatomic) CaculatorMaker *(^add)(int value);

- (CaculatorMaker *(^)(int))add;

- (CaculatorMaker *(^)(int))sub;

- (CaculatorMaker *(^)(int))muilt;

- (CaculatorMaker *(^)(int))divide;


//函数式

- (CaculatorMaker *)caculatorAdd:(int(^)(int result))cacultorBlock;


- (CaculatorMaker *)equle:(BOOL(^)(int result))operation;


@end