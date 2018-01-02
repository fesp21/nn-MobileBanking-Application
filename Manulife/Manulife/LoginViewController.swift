//
//  LoginViewController.swift
//  Manulife
//
//  Created by Najla on 2017-12-19.
//  Copyright © 2017 Manulife. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = UserDefaults.standard
        
        if (preferences.object(forKey: "session") != nil ){
            
            showApplication()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
     
    }
    
    
    @IBAction func openClicked(_ sender: Any) {
        
        let preferences = UserDefaults.standard
        preferences.set("manulife", forKey: "session")
        
        DispatchQueue.main.async(
            execute:self.showApplication
        )
    }
    
    
    //MARK: private methods
    
    func showApplication() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")
        //self.present(controller, animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = controller
    }
    
    
    
    
    
    
    
    
    
}
