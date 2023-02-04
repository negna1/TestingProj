//
//  LocalTransactionService.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 04.02.23.
//

import Foundation
import CoreData
import UIKit

final class LocalTransactionCoreData: NSManagedObject {
    private var transactions: [NSManagedObject] = []
    private var wrappedTransactions: [TransactionsResponseItem] = []
    private let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TransactionModelEntity")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension LocalTransactionCoreData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTransactionCoreData> {
        return NSFetchRequest<LocalTransactionCoreData>(entityName: "TransactionEntity")
    }
    @NSManaged public var id: String?
    @NSManaged public var amount: NSNumber?
    @NSManaged public var bookingDate: String?
    @NSManaged public var category: NSNumber?
    @NSManaged public var currency: String?
    
    @NSManaged public var partnerDisplayName: String?
    @NSManaged public var transactionDetailsDescription: String?
    
    public func saveTransactions(transactions: TransactionsResponse) {
        self.fetchAndRemoveAllObjects()
        transactions.items?.forEach({saveTransaction(object: $0)})
    }
    
    public func fetchRequest() async -> [TransactionsResponseItem]{
        guard let managedContext = managedContext else { return [] }
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "TransactoinEntity")
        
        do {
            transactions = try managedContext.fetch(fetchRequest)
            return transactionValues
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    private func saveTransaction(object: TransactionsResponseItem) {
        //        guard !wrappedTransactions.contains(where: {$0.alias?.reference == object.alias?.reference}) else { return } -> this is the case when we want to not to have same transaction but because we are removing everything we don't need it.
        guard let managedContext = managedContext else { return }
        let entity =
        NSEntityDescription.entity(forEntityName: "TransactoinEntity",
                                   in: managedContext)!
        
        let transaction = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        transaction.setValue(object.transactionDetail?.value?.amount, forKeyPath: "amount")
        transaction.setValue(object.transactionDetail?.bookingDate, forKeyPath: "bookingDate")
        transaction.setValue(object.category, forKeyPath: "category")
        transaction.setValue(object.transactionDetail?.value?.currency, forKeyPath: "currency")
        transaction.setValue(object.partnerDisplayName, forKeyPath: "partnerDisplayName")
        transaction.setValue(object.transactionDetail?.description, forKeyPath: "transactionDetailsDescription")
        transaction.setValue(object.alias?.reference, forKeyPath: "id")
        do {
            try managedContext.save()
            transactions.append(transaction)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - this is because we want to update if there is not error, so if response is success we should remove everything
    private func fetchAndRemoveAllObjects() {
        guard let managedContext = managedContext else { return }
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "TransactoinEntity")
        
        do {
            transactions = try managedContext.fetch(fetchRequest)
            transactions.forEach({managedContext.delete($0)})
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private var transactionValues: [TransactionsResponseItem] {
        transactions.map { obj in
            TransactionsResponseItem.init(
                partnerDisplayName: obj.value(forKey: "partnerDisplayName") as? String,
                alias: .init(reference: obj.value(forKey: "id") as? String),
                category: obj.value(forKey: "category") as? Int,
                transactionDetail: .init(
                    description: obj.value(forKey: "transactionDetailsDescription") as? String,
                    bookingDate: obj.value(forKey: "bookingDate") as? String,
                    value: .init(
                        amount: obj.value(forKey: "amount") as? Double,
                        currency: obj.value(forKey: "currency") as? String)))
        }
    }
}
