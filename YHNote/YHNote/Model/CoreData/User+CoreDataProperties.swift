//
//  User+CoreDataProperties.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/13.
//  Copyright © 2016年 林宁宁. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var id: NSNumber?
    @NSManaged var password: String?
    @NSManaged var username: String?

}
