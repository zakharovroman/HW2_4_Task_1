//
//  ViewController.swift
//  HW2_4_Task_1
//
//  Created by Роман Захаров on 31.05.2020.
//  Copyright © 2020 Роман Захаров. All rights reserved.
//

import UIKit

enum NameFields {
    case userName
    case password
    case none
    
}

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userNameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            logInActionButton(logInButton)
        }
        return false
    }
    
    // MARK: Log in
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func logInActionButton(_ sender: UIButton) {
        
        guard let inputTextName = userNameTextField.text, !inputTextName.isEmpty else {
            showAlert(with: "User name is empty", and: "Please enter your name", clear: .none)
            return
        }
        if let _ = Double(inputTextName) {
            showAlert(with: "Wrong format in user name", and: "Please enter your name correctly", clear: .userName)
            return
        }
        
        guard inputTextName == user.userName else {
            showAlert(with: "Invalid user name", and: "Please enter user name correctly", clear: .userName)
            return
        }
        
        guard let inputTextPassword = passwordTextField.text, !inputTextPassword.isEmpty else {
            showAlert(with: "Password is empty", and: "Please enter password", clear: .none)
            return
        }
        guard inputTextPassword == user.password else {
            showAlert(with: "Invalid password", and: "Please enter password correctly", clear: .password)
            return
        }
        
        let userName = userNameTextField.text
        performSegue(withIdentifier: "showDetails", sender: userName)
    }
    
    @IBAction func forgotUserNameActionButton(_ sender: UIButton) {
        showAlert(with: "User name", and: "Please enter \"User\"", clear: .none)
        userNameTextField.text = user.userName
        userNameTextField.becomeFirstResponder()
    }
    
    @IBAction func forgotPasswordActionButton(_ sender: UIButton) {
        showAlert(with: "Password", and: "Please enter \"Password\"", clear: .none)
        passwordTextField.text = user.password
        passwordTextField.becomeFirstResponder()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let tabBarController = segue.destination as! UITabBarController
            let detailViewController = tabBarController.viewControllers?.first as! DetailViewController
            detailViewController.userName = sender as? String
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if let _ = segue.source as? DetailViewController {
            userNameTextField.text = ""
            passwordTextField.text = ""
            userNameTextField.becomeFirstResponder()
        }
    }
    
}

// MARK: UIAlertController
extension MainViewController {
    private func showAlert(with title: String, and message: String, clear clearTextField: NameFields) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if clearTextField == .userName {
                self.userNameTextField.text = ""
                self.userNameTextField.becomeFirstResponder()
            } else if clearTextField == .password {
                self.passwordTextField.text = ""
                self.passwordTextField.becomeFirstResponder()
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


