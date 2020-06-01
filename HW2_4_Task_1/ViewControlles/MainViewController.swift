//
//  ViewController.swift
//  HW2_4_Task_1
//
//  Created by Роман Захаров on 31.05.2020.
//  Copyright © 2020 Роман Захаров. All rights reserved.
//

import UIKit
// Шаблон структуры класса
// убрать / в ссылке
/* "https:\//medium.com/@Debash/оформление-и-структура-класса-3dc2f150c051" */
/*

перед классом перечисления и структуры
 
MARK: IB Outlets - аутлеты
MARK: Public properties - публичные переменные и константы
MARK: Private properties - приватные переменные и константы

MARK: Initializers - инициализаторы класса

MARK: Override Methods - переопределенные методы
 MARK: Life Cycles Methods  - отдельные типы переопределенных методов
 MARK: Navigation - переопределяемые методы для навигации
  Если же вы работаете с вью контроллером, то переопределенные методы идут сразу после свойств класса

MARK: IB Actions - методы связанные с пользовательским интерфейсом
 
MARK: Public Methods - публичные методы класса
MARK: Private Methods - приватные методы класса
 
после класса extensions
 
*/

class MainViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Private properties
    private let user = User()
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        setActiveField(as: userNameTextField)
    }
    
    // MARK: Override Methods - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let tabBarController = segue.destination as! UITabBarController
            let detailViewController = tabBarController.viewControllers?.first as! DetailViewController
            detailViewController.userName = sender as? String
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        //        if let _ = segue.source as? DetailViewController {
        //            userNameTextField.text = ""
        //            passwordTextField.text = ""
        //            setActiveField(as: userNameTextField)
        //        }
        
        //        if let _ = segue.source as? DetailViewController
        //
        //        Эта строка лишняя. У тебя ведь есть только одно место в приложение, от куда ты можешь сделать логаут и это место WelcomeViewController. Да даже если бы было не одно это все равно не имеет значения. Не важно с какого вью контроллера ты возвращаешься, тебе нужно просто отчистить текстовые поля.
        
        userNameTextField.text = ""
        passwordTextField.text = ""
        setActiveField(as: userNameTextField)
        
    }
    
    // MARK: Override Methods - Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        
        //      self.view.endEditing(true)
        //
        //        Ключевое слово self тут лишнее. Ты ведь обращаешься к свойству класса не из блока замыкания, поэтому явно указывать на то, что это свойство класса не нужно. Понять в каком месте нужно явно использовать self очень просто: везде пиши без self, а там где это надо, компилятор тебе сообщит. Это бывает в блоках замыканий, как я уже сказал и в том случае, когда параметр метода совпадает с названием свойства класса.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            setActiveField(as: passwordTextField)
        } else if textField == passwordTextField {
            logIn()
        }
        return false
    }
    
    // MARK: IB Actions
    @IBAction func logInActionButton(_ sender: UIButton) {
        logIn()
    }
    
    // MARK: IB Actions - Forgot
    @IBAction func forgotUserNameActionButton(_ sender: UIButton) {
        showAlert(with: "User name", and: "Please enter \"User\" ⏎", active: userNameTextField, set: user.userName)
    }
    
    @IBAction func forgotPasswordActionButton(_ sender: UIButton) {
        showAlert(with: "Password", and: "Please enter \"Password\" ⏎", active: passwordTextField, set: user.password)
    }
    
    // MARK: Private Methods
    private func setActiveField(as field: UITextField) {
        field.becomeFirstResponder()
    }
    
    // MARK: Private Methods - Log in
    private func checkCredential() -> Bool {
        //check name
        guard let inputTextName = userNameTextField.text, !inputTextName.isEmpty else {
            showAlert(with: "User name is empty", and: "Please enter 🖋", active: userNameTextField, set: "")
            return false
        }
        if let _ = Double(inputTextName) {
            showAlert(with: "Wrong format user name", and: "Please enter correctly ✒️", active: userNameTextField, set: "")
            return false
        }
        guard inputTextName == user.userName else {
            showAlert(with: "Invalid user name", and: "Please enter correctly ✒️", active: userNameTextField, set: "")
            return false
        }
        //check password
        guard let inputTextPassword = passwordTextField.text, !inputTextPassword.isEmpty else {
            showAlert(with: "Password is empty", and: "Please enter 🔏", active: passwordTextField, set: "")
            return false
        }
        guard inputTextPassword == user.password else {
            showAlert(with: "Invalid password", and: "Please enter correctly 🔐", active: passwordTextField, set: "")
            return false
        }
        return true
    }
    
    private func logIn() {
        if checkCredential() {
            performSegue(withIdentifier: "showDetails", sender: userNameTextField.text)
        }
    }
}

// MARK: UIAlertController
extension MainViewController {
    private func showAlert(with title: String, and message: String, active textField: UITextField, set value: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "🆗", style: .default) { _ in
            textField.text = value
            self.setActiveField(as: textField)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


