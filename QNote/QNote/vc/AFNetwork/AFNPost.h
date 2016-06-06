//
//  AFNPost.h
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNUser.h"

@interface AFNPost : NSObject


@property (nonatomic, assign) NSUInteger postID;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) AFNUser *user;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end


@interface AFNPost (NSCoding)<NSSecureCoding>

@end