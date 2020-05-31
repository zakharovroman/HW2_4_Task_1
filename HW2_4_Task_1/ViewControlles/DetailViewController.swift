//
//  DetailViewController.swift
//  HW2_4_Task_1
//
//  Created by Роман Захаров on 31.05.2020.
//  Copyright © 2020 Роман Захаров. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = "Welcome, " + userName
    }

}
