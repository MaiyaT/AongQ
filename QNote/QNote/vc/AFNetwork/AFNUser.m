//
//  AFNUser.m
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AFNUser.h"

NSString * const kUserProfileImageDidLoadNotification = @"kUserProfileImageDidLoadNotification";


@interface AFNUser()

@property (readwrite, nonatomic, assign) NSUInteger userID;
@property (readwrite, nonatomic, copy) NSString *userName;
@property (readwrite, nonatomic, copy) NSString *avatarImageURLString;

@end

@implementation AFNUser

-(instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if(self)
    {
        self.userID = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
        self.userName = [attributes valueForKeyPath:@"username"];
        self.avatarImageURLString = [attributes valueForKeyPath:@"avatar_image.url"];
        
    }
    return self;
}

-(NSURL *)avatarImageURL
{
    return [NSURL URLWithString:self.avatarImageURLString];
}


@end


@implementation AFNUser(NSCoding)

+(BOOL)supportsSecureCoding
{
    return YES;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:@"AF.username"];
    [aCoder encodeInteger:(NSInteger)self.userID forKey:@"AF.userID"];
    [aCoder encodeObject:self.avatarImageURLString forKey:@"AF.avatarImageURLString"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.userName = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.username"];
        self.userID = (NSUInteger)[aDecoder decodeIntegerForKey:@"AF.userID"];
        self.avatarImageURLString = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.avatarImageURLString"];
    }
    return self;
}


@end

