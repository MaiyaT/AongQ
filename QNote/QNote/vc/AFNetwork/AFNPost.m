//
//  AFNPost.m
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AFNPost.h"
#import "AFAppDotNetAPIClient.h"

@implementation AFNPost

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.postID = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
    self.text = [attributes valueForKeyPath:@"text"];
    
    self.user = [[AFNUser alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];
    
    return self;
}


+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    return [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            AFNPost *post = [[AFNPost alloc] initWithAttributes:attributes];
            [mutablePosts addObject:post];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}



@end




@implementation AFNPost (NSCoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:(NSInteger)self.postID forKey:@"AF.postID"];
    [aCoder encodeObject:self.text forKey:@"AF.text"];
    [aCoder encodeObject:self.user forKey:@"AF.user"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.postID = (NSUInteger)[aDecoder decodeIntegerForKey:@"AF.postID"];
    self.text = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.text"];
    self.user = [aDecoder decodeObjectOfClass:[AFNUser class] forKey:@"AF.user"];
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
