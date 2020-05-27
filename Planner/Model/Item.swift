//
//  Item.swift
//  Planner
//
//  Created by Duale on 5/8/20.
//  Copyright © 2020 Duale. All rights reserved.
//

import Foundation

class Item : Encodable , Decodable {
    var title : String = ""
    var done : Bool = false
}
