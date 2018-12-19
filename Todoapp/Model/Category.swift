//
//  Category.swift
//  Todoapp
//
//  Created by alex oviedo on 19/12/2018.
//  Copyright © 2018 alex oviedo. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
