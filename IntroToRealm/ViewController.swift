//
//  ViewController.swift
//  IntroToRealm
//
//  Created by Josh R on 5/2/20.
//  Copyright © 2020 Josh R. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(realm.configuration.fileURL ?? "Realm URL not found.")
        
        //MARK: Create test data
        //Uncomment if you delete the app from the simulator and need to recreate test data
        //Comment methods out if objects already exist in the realm
//        createCustomersAndBranchManager()
//        createBank()
        
        //MARK: Retrieve all customers, branch manager, and bank
        let allCustomers = realm.objects(Customer.self)
        let branchManager = realm.objects(BranchManager.self).first!
        let usBank = realm.objects(Bank.self).first!
        
        
        //MARK: Change an objects value
        try! realm.write {
            branchManager.lastName = "Miller"
        }
        
        print("Lauren's new last name is \(branchManager.lastName)")
        
        //MARK: Add relationships
        //Uncomment if you delete the app from the simulator and need to reestablish the relationships
//        try! realm.write {
//            usBank.branchManager = branchManager
//
//            for customer in allCustomers {
//                usBank.customers.append(customer)
//            }
//        }
        
        let jonCustomer = allCustomers.filter({ $0.firstName == "Jon" })
        print(jonCustomer.first!.fullName)
    }
    
    private func createCustomersAndBranchManager() {
        try! realm.write {
            let customer1 = Customer()
            customer1.firstName = "Jon"
            customer1.lastName = "Smith"
            customer1.currentBalance = 1234.12
            
            let customer2 = Customer()
            customer2.firstName = "Susan"
            customer2.lastName = "Alexander"
            customer2.currentBalance = 54321.10
            
            let branchManager = BranchManager()
            branchManager.firstName = "Lauren"
            branchManager.lastName = "Scott"
            
            realm.add([customer1, customer2, branchManager])
        }
    }
    
    private func createBank() {
        try! realm.write {
            let usBank = Bank()
            usBank.name = "US Bank"
            usBank.latitude = 44.9778
            usBank.longitude = 93.2650
            usBank.type = Bank.BankType.retailBank.rawValue
            
            realm.add(usBank)
        }
    }
    
}

