//
//  TransactionsViewController.swift
//  Manulife
//
//  Created by Najla on 2017-12-28.
//  Copyright © 2017 Manulife. All rights reserved.
//

import UIKit


class TransactionsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var transactions:[Transaction]?
    var accountId:NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        navigationItem.title = "Transactions"
        
        fetchTransactions()
    }
    
    
    //MARK: private methods
    
    func fetchTransactions() {
    
        let urlString : String = "https://raw.githubusercontent.com/seyDoggy/ml-app-challenge/master/data/accountTransactions.json"
        guard let url = URL(string : urlString) else {
            print("Failed to call service accounts")
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url:url)) {(data, response, error) in
            
            // check service
            guard error == nil else {
                print("Failed to get accounts")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]] {
                    
                    self.transactions = [Transaction]()
                    
                    for dictionary in json as [[String:AnyObject]] {
                        if let currentTransactions = dictionary[String(self.accountId)] {                            if let array = currentTransactions as? NSArray {
                                for obj1 in array {
                                    if let dict = obj1 as? NSDictionary {
                                        
                                        let dateDict = dict.value(forKey: "date") as? String
                                        let activityDict = dict.value(forKey: "activity") as? NSArray
                                        
                                        for obj2 in activityDict! {
                                            
                                            let transaction = Transaction()
                                            let activity = Activity()
                                            
                                            transaction.date = dateDict
                                            
                                            if let dict2 = obj2 as? NSDictionary {
                                                activity.transaction_description = dict2["description"] as? String
                                                if let amount = dict2["deposit_amount"]{
                                                    activity.amount = "+ "+String(format:"%.2f",(amount as? Float)!)
                                                }
                                                if let amount = dict2["withdrawal_amount"]{
                                                    activity.amount = "- "+String(format:"%.2f",(amount as? Float)!)
                                                }
                                                
                                            }
                                            transaction.activity = activity
                                            self.transactions?.append(transaction)
                                        }
                                        
                                    }
                            }
                            }
                        }
                    }
                    DispatchQueue.main.async() {
                        
                        self.tableView.reloadData()
                    }
                }
                else {
                    print("Failed to read main data")
                }
            }
            catch {
                print("Failed did not deserialize JSON: \(error)")
            }
            
            }.resume()
    }

    
    //MARK: tableView methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
            as! TransactionCell
        cell.dateLabel.text = self.transactions?[indexPath.item].date
        cell.transactionDescriptionLabel.text = self.transactions?[indexPath.item].activity?.transaction_description
        cell.amountLabel.text = transactions?[indexPath.item].activity?.amount
        
        return cell
    }
    
  
}
