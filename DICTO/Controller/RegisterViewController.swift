//
//  RegisterViewController.swift
//  Dicto
//
//  Created by Deepanshu Gautam on 19/07/21.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "" {
            Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
                if let e = error {
                    DispatchQueue.main.async {
                        self.errorLabel.text = e.localizedDescription
                    }
                } else {
                    self.performSegue(withIdentifier: K.Segues.registerToMain, sender: self)
                }
            }
        } else {
            errorLabel.text = "Field's Can't Be Empty."
        }
    }
}

//MARK: - ViewDidLoad

extension RegisterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Controller
        title = K.appName
        // Text Fields
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        
        // Buttons
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height / 5
        signUpButton.layer.shadowColor = UIColor(named: K.BrandColors.orange)?.cgColor
        signUpButton.layer.shadowRadius = 1
        signUpButton.layer.shadowOpacity = 0.5
        signUpButton.layer.shadowOffset = CGSize(width: 8, height: 8)
        signUpButton.layer.shouldRasterize = true
        signUpButton.isUserInteractionEnabled = true
        signUpButton.isEnabled = true
        // TextFieldDelegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

//MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

//MARK: - GestureRecognizer

extension RegisterViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


