//
//  File+CoreDataProperties.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 11.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension File {

    @NSManaged var contents: NSData?
    @NSManaged var encrypted: Bool
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var folder: Folder

}
