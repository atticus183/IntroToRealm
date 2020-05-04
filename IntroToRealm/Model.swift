//
//  Model.swift
//  IntroToRealm
//
//  Created by Josh R on 5/2/20.
//  Copyright © 2020 Josh R. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation


class Bank: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var branchManager: BranchManager?  //one-to-many
    let customers = List<Customer>()  //one-to-many
    @objc dynamic var type: BankType.RawValue = ""  //realm recognizes this as a string
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    //Primary key method provided by Realm
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Computed properties are not persisted and ignored by realm
    var bankLocation: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    //Enums are not persisted and ignored by realm
    enum BankType: String {
        case creditUnion = "Credit Union"
        case centralBank = "Central Bank"
        case retailBank = "Retail Bank"
    }
}


class BranchManager: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Inverse to Bank.
    let bank = LinkingObjects(fromType: Bank.self, property: "branchManager")
}


class Customer: Object {
    @objc dynamic var accountNumber = UUID().uuidString
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var startingBalance: Double = 0.0
    @objc dynamic var currentBalance: Double = 0.0
    @objc dynamic var dateJoined = Date()
    
    //Computed properties are not persisted and ignored by realm
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    //Inverse to Bank.
    let bank = LinkingObjects(fromType: Bank.self, property: "customers")

    override static func primaryKey() -> String? {
        return "accountNumber"
    }
}
