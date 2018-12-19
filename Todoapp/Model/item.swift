//
//  Item.swift
//  Todoapp
//
//  Created by alex oviedo on 19/12/2018.
//  Copyright © 2018 alex oviedo. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
