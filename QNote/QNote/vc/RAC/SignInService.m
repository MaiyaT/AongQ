//
//  SignInService.m
//  QNote
//
//  Created by 林宁宁 on 16/7/6.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "SignInService.h"

@implementation SignInService


+(void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(ResponseBlock)completeBlock
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(completeBlock)
        {
            completeBlock(YES);
        }
    });
}

@end
