//
//  SignInService.h
//  QNote
//
//  Created by 林宁宁 on 16/7/6.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ResponseBlock)(BOOL isSuccess);

@interface SignInService : NSObject

+ (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                  complete:(ResponseBlock)completeBlock;

@end
