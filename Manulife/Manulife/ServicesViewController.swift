//
//  ServicesViewController.swift
//  Manulife
//
//  Created by Najla on 2017-12-19.
//  Copyright © 2017 Manulife. All rights reserved.
//

import UIKit


class ServicesViewController : BaseViewController {

    @IBOutlet weak var textViewServices: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentString = NSMutableString()
        contentString.append("\n Manulife Products & Services")
        contentString.append("\n\n INDIVIDUAL : ")
        contentString.append("\n .Insurance")
        contentString.append("\n .Investments")
        contentString.append("\n .Wealth Management")
        contentString.append("\n .Banking")
        contentString.append("\n .Group Benefits")
        contentString.append("\n .Group Retirement")
        contentString.append("\n .Wealth Management")
        contentString.append("\n\n BUSINESS : ")
        contentString.append("\n .Group Benefits")
        contentString.append("\n .Group Retirement")
        contentString.append("\n .Small Business")
        
        textViewServices.text = contentString as String!
        
    }
}
