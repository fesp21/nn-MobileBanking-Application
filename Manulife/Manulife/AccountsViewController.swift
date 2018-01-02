//
//  AccountsViewController.swift
//  Manulife
//
//  Created by Najla on 2017-12-19.
//  Copyright © 2017 Manulife. All rights reserved.
//

import UIKit


class AccountsViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var accounts : [Account]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        let preferences = UserDefaults.standard
        if (preferences.object(forKey: "session") != nil ){
            fetchAccounts()
        } else
        {
            loginIn()
        }
    }
    
    @IBAction func QuitClicked(_ sender: Any) {
        
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "session")
        loginIn()
    }
    
    
    //MARK: private methods
    
    func  loginIn()  {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        //self.present(controller, animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = controller
    }
    
    func fetchAccounts() {
        
        let urlString : String = "https://raw.githubusercontent.com/seyDoggy/ml-app-challenge/master/data/listOfAccounts.json"
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
                    
                    self.accounts = [Account]() //struct
                    for dictionary in json as [[String:AnyObject]] {
                        let account = Account() //class
                        account.id = dictionary["id"] as? NSInteger
                        account.name = dictionary["display_name"] as? String
                        account.number = dictionary["account_number"] as? String
                        account.balance = String(format:
                              "%.2f",dictionary["balance"] as! Float)
                        self.accounts?.append(account)
                        
                    }
                    DispatchQueue.main.async() {                        
                        self.tableView.reloadData()
                    }
                }
                else {                    
                    print("Failed to read data")
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
        //        if let count = self.accounts?.count {
        //            return count
        //        }
        return accounts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! AccountCell
        cell.nameLabel.text = self.accounts?[indexPath.item].name
        cell.numberLabel.text = self.accounts?[indexPath.item].number
        cell.balanceLabel.text = self.accounts?[indexPath.item].balance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let transactionVC = storyboard?.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
      
        transactionVC.accountId =  (self.accounts?[indexPath.item].id)!
        navigationController?.pushViewController(transactionVC, animated: true)
    }
    
}



