//
//  CDObj.h
//  QNote
//
//  Created by 林宁宁 on 16/7/7.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface CDObj : NSManagedObject

@property (copy, nonatomic) NSString * userName;

@property (copy, nonatomic) NSString * userIcon;

@property (copy, nonatomic) NSString * userID;

@end
