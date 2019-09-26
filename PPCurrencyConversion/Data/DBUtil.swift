//
//  DBUtil.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import UIKit
import CoreData

/// DB-related tasks
/// - TODO: update DB data once per hour
class DBUtil: NSObject {
    
    static let shared = DBUtil()
    
    private override init() {}
    
    func createCurrencies(keys nameDicSortedKeys: [String], namesDic: [String: String], ratesDic: [String: Double]) -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let currencyEntity = NSEntityDescription.entity(forEntityName: "Currencies", in: context)!
        var currencies = [NSManagedObject]()
        for key in nameDicSortedKeys {
            let currency = NSManagedObject(entity: currencyEntity, insertInto: context)
            currency.setValue(key, forKey: "abbr")
            currency.setValue(namesDic[key], forKey: "name")
            currency.setValue(ratesDic[key], forKey: "rate")
            currencies.append(currency)
        }
        do {
            try context.save()
            NSLog("create complete")
            return currencies
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func readCurrencies() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currencies")
        do {
            let currencies = try context.fetch(fetchRequest)
            for currency in currencies {
                print("abbr: \(currency.value(forKey: "abbr") ?? "nil"), name: \(currency.value(forKey: "name") ?? "nil"), rate: \(currency.value(forKey: "rate") ?? 0.0)")
            }
            NSLog("read complete")
            return currencies
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // leave for debugging
    func deleteAllCurrencies() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Currencies")
        do {
            let allCurrencies = try context.fetch(fetchRequest)
            for currency in allCurrencies {
                context.delete(currency)
            }
            do {
                try context.save()
                NSLog("delete complete")
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
