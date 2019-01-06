//
//  Item.swift
//  ToDoey
//
//  Created by Zack Chng on 5/1/19.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
    
}
