//
//  Transaction.swift
//  Manulife
//
//  Created by Najla on 2017-12-29.
//  Copyright © 2017 Manulife. All rights reserved.
//

import UIKit

class Transaction: NSObject {
   
    var date: String?
    var activity:Activity?
}

class Activity: NSObject {
    
    var id: String?
    var date: String?
    var transaction_description: String?
    var amount: String?  //deposit_amount   withdrawal_amount
    var balance: String?
    var transaction_uid: String?
    
}
