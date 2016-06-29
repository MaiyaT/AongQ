//
//  RTObj1.m
//  QNote
//
//  Created by 林宁宁 on 16/6/27.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "RTObj1.h"
#import <objc/runtime.h>


@implementation RTObj1

- (void)doThisMethod
{
    NSLog(@"拦截方法 doThisMethod");
}


/**
 *  通过字典 拼接出其中所有的 属性类型字符串
 */
+ (void)logAllPropertyAtDataDic:(NSDictionary *)dataDic
{
    NSMutableString * strM = [NSMutableString new];
    
    [dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        NSString * type;
        if([obj isKindOfClass:NSClassFromString(@"__NSCFString")])
        {
            type = @"NSString";
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
        {
            type = @"BOOL";
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSArrayI")])
        {
            type = @"NSArray";
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")])
        {
            type = @"int";
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSDictionaryI")])
        {
            type = @"NSDictionary";
        }
        
        NSString * str;
        if([type isEqualToString:@"NSString"])
        {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) %@ *%@;",type,key];
        }
        else if([type hasPrefix:@"NS"])
        {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        }
        else
        {
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }
        
         [strM appendFormat:@"\n%@\n",str];
    }];
    
    NSLog(@"%@",strM);
    
    //打印出来黏贴到类声明文件中
}


+ (instancetype)modelWithDataDic:(NSDictionary *)dataDic
{
    id objc = [[self alloc] init];
    
    unsigned int count;
    Ivar * ivarList = class_copyIvarList(self, &count);
    
    for(unsigned int i; i<count; i++)
    {
        Ivar ivar = ivarList[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        id value = dataDic[key];
        
        if (value)
        {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

@end
