//
//  Item.swift
//  Todoooo
//
//  Created by Hyder on 3/25/18.
//  Copyright © 2018 Ema Hyder. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var done : Bool = false
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
