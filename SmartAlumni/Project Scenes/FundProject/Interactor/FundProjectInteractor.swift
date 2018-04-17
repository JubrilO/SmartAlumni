//
//  FundProjectInteractor.swift
//  SmartAlumni
//
//  Created by Jubril on 3/16/18.
//  Copyright (c) 2018 Kornet. All rights reserved.
//

import UIKit
import Paystack
import RealmSwift

protocol FundProjectInteractorInput: FundProjectViewControllerOutput {

}

protocol FundProjectInteractorOutput {

    func presentError(string: String?)
    func presentFundCompletionScene()
    func presentActiveState()
}

final class FundProjectInteractor: FundProjectViewControllerOutput {

    let output: FundProjectInteractorOutput
    let worker: FundProjectWorker
    var project = Project()
    var amountFunded: Int?


    // MARK: - Initializers

    init(output: FundProjectInteractorOutput, worker: FundProjectWorker = FundProjectWorker()) {

        self.output = output
        self.worker = worker
    }



// MARK: - FundProjectInteractorInput



    // MARK: - Business logic
    
    func chargeCard(amount: Double, cardParams: PSTCKCardParams, vc: UIViewController) {
        let realm = try! Realm()
        let user = realm.objects(User.self)[0]
        let transactionParams = PSTCKTransactionParams()
        transactionParams.email = user.email
        transactionParams.subaccount = project.paystackSubaccount
        transactionParams.transaction_charge = getPaystackCharge(amount: amount)
        transactionParams.amount = UInt(amount * 100)
        do {
            try transactionParams.setCustomFieldValue("Paid Via", displayedAs: "SmartAlumni App")
            try transactionParams.setCustomFieldValue("Project ID", displayedAs: project.id)
        }
        catch {
            print(error)
            self.output.presentError(string: error.localizedDescription)
        }
   
        PSTCKAPIClient.shared().chargeCard(cardParams, forTransaction: transactionParams, on: vc, didEndWithError: {
            (error, reference) in
            print(error.localizedDescription)
            //self.output.presentError(string: error.localizedDescription)
            if let errorDict = (error._userInfo as! NSDictionary?) {
                if let errorString = errorDict.value(forKeyPath: "com.paystack.lib:ErrorMessageKey") as! String? {
                    if let reference = reference {
                        self.output.presentError(string: error.localizedDescription)
                    } else {
                        self.output.presentError(string: error.localizedDescription)
                    }
                }
                else {
                    self.output.presentError(string: error.localizedDescription)
                }
            }
    
    
        }, didRequestValidation: {
            reference in
            print("\(reference) didRequestValidation")
            
        }, willPresentDialog: {
            // make sure dialog can show
            // if using a "processing" dialog, please hide it
        }, dismissedDialog: {
            self.output.presentActiveState()
            
        }, didTransactionSuccess: {
            reference in
            print("\(reference) didTransactionSuccess")
            self.verifyTransactionReference(amountInKobo: floor(amount * 100), ref: reference)
        })
    }
    
    func verifyTransactionReference(amountInKobo: Double, ref: String) {
        ProjectAPI.sharedManager.fundProject(amount: Int(amountInKobo), project: self.project, transactionRef: ref){
            successful, error in
            if successful {
                self.amountFunded = Int(amountInKobo) / 100
                self.output.presentFundCompletionScene()
            }
            else {
                self.output.presentError(string: error)
            }
        }
    }
    
    func getFixedCharge(amount: Double) -> Int {
       var fixedCharge = Int(1.5 / 100 * amount * 100)
        if amount >= 100 {
            fixedCharge += (100 * 100)
        }
        return fixedCharge + getPaystackCharge(amount: amount)
    }
    
    func getPaystackCharge(amount: Double) -> Int {
        var transactionCharge = Int(1.5 / 100 * amount * 100)
        
        if amount > 2500 {
            transactionCharge += 100 * 100
        }
        
        if transactionCharge > (2000 * 100) {
            return 2000 * 100
        }
        return transactionCharge
    }

}
