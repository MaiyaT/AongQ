//
//  SecureObj.m
//  QNote
//
//  Created by 林宁宁 on 16/6/2.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "SecureObj.h"

#import <objc/runtime.h>
#import <objC/NSObject.h>


@implementation SecureObj

+(BOOL)supportsSecureCoding
{
    return YES;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.dataList = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"dataList"];
        self.secureTitle = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"secureTitle"];
        self.secureIndex = [[aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"secureIndex"] integerValue];
        self.superObj = [aDecoder decodeObjectOfClass:[SecureObj class] forKey:@"superObj"];
        
//        [[self getPropertyClassesByName] enumerateKeysAndObjectsUsingBlock:(void (^)(NSString *key, Class propertyClass, BOOL *stop)) {
//            
//            [aDecoder decodeObjectOfClass:propertyClass forKey:key];
////            NSObject * object = [aDecoder decodeObjectOfClass:propertyClass forKey:key];
////            
////            if (object)
////            {
////                [self setValue:object forKey:key];
////            }
//            
//        }];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dataList forKey:@"dataList"];
    [aCoder encodeObject:self.secureTitle forKey:@"secureTitle"];
    [aCoder encodeObject:self.superObj forKey:@"superObj"];
    [aCoder encodeObject:@(self.secureIndex) forKey:@"secureIndex"];
//    for (NSString *key in [self getPropertyClassesByName])
//    {
//        id object = [self valueForKey:key];
//        
//        if (object)
//        {
//            [aCoder encodeObject:object forKey:key];
//        }
//    }
}



/** 获取属性的名字列表
 *  http://www.cocoachina.com/industry/20140516/8445.html
 */
- (NSArray *)getPropertyNames
{
    /*
     *  使用KVC（键-值编码），我们能够利用名称设置和获取一个对象的所有属性，并且在一个NSCoder对象中对这些属性进行编码/解码。
     
     为了要实现NSSecureCoding，我们要遵循同样的原则，但是不仅仅是获取属性名，还需要获取它们的类型。幸运地是，Objective C运行时存储了类的属性类型的详细信息，所以可以很容易和名字一起取到这些数据。
     */
    unsigned int propertyCount;
    
    objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableArray * list = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = properties[i];
        
        const char * propertyName = property_getName(property);
        
        NSString * key = @(propertyName);
        
        [list addObject:key];
    }
    
    free(properties);
    
    return list;
}


/** 通过属性的名字获取该属性的类型*/
- (NSDictionary *)getPropertyClassesByName
{
    NSMutableDictionary * dictionary = objc_getAssociatedObject([self class], _cmd);
    
    if(dictionary)
    {
        return dictionary;
    }
    
    dictionary = [NSMutableDictionary dictionary];
    
    Class subClass = [self class];
    while (subClass != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
        
        for(int i = 0; i < propertyCount; i++)
        {
            objc_property_t property = properties[i];
            const char * propertyName = property_getName(property);
            
            NSString * key = @(propertyName);
            
            char * ivar = property_copyAttributeValue(property, "V");
            if(ivar)
            {
                NSString *ivarName = @(ivar);
                
                if ([ivarName isEqualToString:key] ||
                    
                    [ivarName isEqualToString:[@"_" stringByAppendingString:key]])
                    
                {
                    Class propertyClass = nil;
                    
                    char *typeEncoding = property_copyAttributeValue(property, "T");
                    
                    switch (typeEncoding[0])
                    
                    {
                            
                        case 'c': // Numeric types
                            
                        case 'i':
                            
                        case 's':
                            
                        case 'l':
                            
                        case 'q':
                            
                        case 'C':
                            
                        case 'I':
                            
                        case 'S':
                            
                        case 'L':
                            
                        case 'Q':
                            
                        case 'f':
                            
                        case 'd':
                            
                        case 'B':
                            
                        {
                            
                            propertyClass = [NSNumber class];
                            
                            break;
                            
                        }
                            
                        case '*': // C-String
                            
                        {
                            
                            propertyClass = [NSString class]; 
                            
                            break; 
                            
                        } 
                            
                        case '@': // Object 
                            
                        { 
                            
                            //TODO: get class name 
                            
                            break; 
                            
                        } 
                            
                        case '{': // Struct 
                            
                        { 
                            
                            propertyClass = [NSValue class]; 
                            
                            break; 
                            
                        } 
                            
                        case '[': // C-Array 
                            
                        case '(': // Enum 
                            
                        case '#': // Class 
                            
                        case ':': // Selector 
                            
                        case '^': // Pointer 
                            
                        case 'b': // Bitfield 
                            
                        case '?': // Unknown type 
                            
                        default: 
                            
                        { 
                            
                            propertyClass = nil; // Not supported by KVC 
                            
                            break; 
                            
                        } 
                            
                    } 
                    
                    free(typeEncoding); 
                    
                    // If known type, add to dictionary 
                    
                    if (propertyClass)
                    {
                        dictionary[key] = propertyClass;
                    }
                }
            }
            
            free(ivar);

            subClass = [subClass superclass];
        }
        
        objc_setAssociatedObject([self class], _cmd, dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dictionary;
        
}



@end
