//
//  DataModel.swift
//  Todoapp
//
//  Created by alex oviedo on 13/12/2018.
//  Copyright © 2018 alex oviedo. All rights reserved.
//

import Foundation


class Item: Codable {
    var title : String = ""
    var done : Bool = false
}
