//
//  NSObject+Caculator.m
//  QNote
//
//  Created by 林宁宁 on 16/7/6.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)

+(int)makeCaculator:(void (^)(CaculatorMaker *))coculatorMaker
{
    CaculatorMaker * mgr = [CaculatorMaker new];
    
    coculatorMaker(mgr);
    
    return mgr.result;
}

@end



@implementation CaculatorMaker

-(CaculatorMaker *(^)(int))add
{
    return ^CaculatorMaker *(int value){
    
        self.result += value;
        
        return self;
    };
}

-(CaculatorMaker *(^)(int))sub
{
    return ^CaculatorMaker * (int value){
    
        self.result -= value;
        
        return self;
    };
}

-(CaculatorMaker *(^)(int))muilt
{
    return ^CaculatorMaker *(int value){
        
        self.result = self.result * value;
        return self;
    };
}

-(CaculatorMaker *(^)(int))divide
{
    return ^CaculatorMaker * (int value){
    
        if(value != 0)
        {
            self.result = self.result/value;
        }
        return self;
    };
}



-(CaculatorMaker *)caculatorAdd:(int (^)(int))cacultorBlock
{
    self.result = cacultorBlock(self.result);
    
    return self;
}


-(CaculatorMaker *)equle:(BOOL (^)(int))operation
{
    self.isEqual = operation(self.result);
    
    return self;
}

@end
