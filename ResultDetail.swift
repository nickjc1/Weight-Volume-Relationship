//
//  RelationShipModel.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/18/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import Foundation
import RealmSwift

class ResultDetail: Object {
    
    @objc dynamic var w: Double = 0
    @objc dynamic var r: Double = 0
    @objc dynamic var Gs: Double = 0
    @objc dynamic var rw: Double = 0
    @objc dynamic var e: Double = 0
    @objc dynamic var n: Double = 0
    @objc dynamic var S: Double = 0
    @objc dynamic var rd: Double = 0
    @objc dynamic var rsat: Double = 0
    
    @objc dynamic var createdTime: Date?
    
}
