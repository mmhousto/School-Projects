//
//  Course+CoreDataProperties.swift
//  demo15
//
//  Created by MYLAVARAPU SESHA S on 10/17/19.
//  Copyright © 2019 MYLAVARAPU SESHA S. All rights reserved.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var courseNum: Int16
    @NSManaged public var deptAbbr: String?
    @NSManaged public var title: String?
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for students
extension Course {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Student)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Student)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
