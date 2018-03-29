//
//  Category.swift
//  Todoooo
//
//  Created by Hyder on 3/25/18.
//  Copyright © 2018 Ema Hyder. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
