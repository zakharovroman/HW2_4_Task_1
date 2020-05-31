//
//  ViewController.swift
//  HW2_4_Task_1
//
//  Created by Роман Захаров on 31.05.2020.
//  Copyright © 2020 Роман Захаров. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let tabBarController = segue.destination as! UITabBarController
            let detailViewController = tabBarController.viewControllers?.first as! DetailViewController
            detailViewController.userName = sender as? String
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event) }
    
    @IBAction func logInActionButton(_ sender: UIButton) {
        let userName = userNameTextField.text
        performSegue(withIdentifier: "showDetails", sender: userName)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if let _ = segue.source as? DetailViewController {
            userNameTextField.text = ""
            passwordTextField.text = ""
        }
        
    }
}

