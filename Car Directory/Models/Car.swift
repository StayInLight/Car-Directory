//
//  Car.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 08/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Car: Object {
    
    dynamic var manufacturer: String?
    dynamic var yearOfRelease: String?
    dynamic var model: String?
    dynamic var bodyType: String?
    
}

//MARK: - CRUD
extension Car {
    static func all(in realm: Realm = try! Realm()) -> Results<Car> {
        return realm.objects(Car.self)
    }

    @discardableResult
    static func add(_ car: Car, in realm: Realm = try! Realm())
        -> Car {
            try! realm.write {
                realm.add(car)
            }
            return car
    }

    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}
