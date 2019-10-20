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

extension Car {
    convenience init(manufacturer: String?,
                     yearOfRelease: String?,
                     model: String?,
                     bodyType: String?) {
        
        self.init()
        self.manufacturer = manufacturer
        self.yearOfRelease = yearOfRelease
        self.model = model
        self.bodyType = bodyType
    }
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

    static func createExampleCars() {
        let car1 = Car(manufacturer: "Volvo",
                       yearOfRelease: "1997",
                       model: "XC90",
                       bodyType: "Sedan")

        let car2 = Car(manufacturer: "BMW",
                       yearOfRelease: "2000",
                       model: "M5",
                       bodyType: "Sedan")

        let car3 = Car(manufacturer: "LADA",
                       yearOfRelease: "2001",
                       model: "2109",
                       bodyType: "Hatchback")

        Car.add(car1)
        Car.add(car2)
        Car.add(car3)
    }
}


