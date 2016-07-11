//
//  CoreDataManaged.h
//  QNote
//
//  Created by 林宁宁 on 16/7/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManaged : NSObject

+ (instancetype)shareManager;

@property (strong, nonatomic) NSManagedObjectModel * managedObjectModel;

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@property (strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;



- (NSURL *)applicationDocumentsDirectory;

- (void)saveContext;

@end
