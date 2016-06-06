//
//  AFNUser.h
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserProfileImageDidLoadNotification;

@interface AFNUser : NSObject

@property (readonly, nonatomic, assign) NSUInteger userID;

@property (readonly, nonatomic, copy) NSString * userName;

@property (readonly, nonatomic, unsafe_unretained) NSURL * avatarImageURL;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end



@interface AFNUser (NSCoding)<NSSecureCoding>

@end
