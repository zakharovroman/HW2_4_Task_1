//
//  ViewController.swift
//  HW2_4_Task_1
//
//  Created by Роман Захаров on 31.05.2020.
//  Copyright © 2020 Роман Захаров. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        setActiveField(as: userNameTextField)
    }
    
    // MARK: Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            setActiveField(as: passwordTextField)
        } else if textField == passwordTextField {
            logIn()
        }
        return false
    }
    
    func setActiveField(as field: UITextField) {
        field.becomeFirstResponder()
    }
    
    // MARK: Log in
    func checkCredential() -> Bool {
       guard let inputTextName = userNameTextField.text, !inputTextName.isEmpty else {
        showAlert(with: "User name is empty", and: "Please enter", active: userNameTextField, set: "")
            return false
        }
        if let _ = Double(inputTextName) {
            showAlert(with: "Wrong format user name", and: "Please enter correctly", active: userNameTextField, set: "")
            return false
        }
        
        guard inputTextName == user.userName else {
            showAlert(with: "Invalid user name", and: "Please enter correctly", active: userNameTextField, set: "")
            return false
        }
        
        guard let inputTextPassword = passwordTextField.text, !inputTextPassword.isEmpty else {
            showAlert(with: "Password is empty", and: "Please enter", active: passwordTextField, set: "")
            return false
        }
        guard inputTextPassword == user.password else {
            showAlert(with: "Invalid password", and: "Please enter correctly", active: passwordTextField, set: "")
            return false
        }
        return true
    }
    
    func logIn() {
        if checkCredential() {
            let userName = userNameTextField.text
            performSegue(withIdentifier: "showDetails", sender: userName)
        }
    }
    
    @IBAction func logInActionButton(_ sender: UIButton) {
        logIn()
    }
    
    // MARK: Forgot
    @IBAction func forgotUserNameActionButton(_ sender: UIButton) {
        showAlert(with: "User name", and: "Please enter \"User\"", active: userNameTextField, set: user.userName)
    }
    
    @IBAction func forgotPasswordActionButton(_ sender: UIButton) {
        showAlert(with: "Password", and: "Please enter \"Password\"", active: passwordTextField, set: user.password)
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
            setActiveField(as: userNameTextField)
        }
    }
    
}

// MARK: UIAlertController
extension MainViewController {
    private func showAlert(with title: String, and message: String, active textField: UITextField, set value: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = value
            self.setActiveField(as: textField)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


