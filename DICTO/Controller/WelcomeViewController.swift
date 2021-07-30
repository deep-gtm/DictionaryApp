//
//  ViewController.swift
//  Dicto
//
//  Created by Deepanshu Gautam on 17/07/21.
//

import UIKit
import Firebase
import GoogleSignIn
class WelcomeViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let signInConfig = GIDConfiguration.init(clientID: "50994878318-slvgeu7sebe4ma69rhd05os2hklt250g.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextFields
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Buttons
        registerButton.layer.cornerRadius = registerButton.frame.size.height / 5
        registerButton.layer.shadowColor = UIColor(named: K.BrandColors.orange)?.cgColor
        registerButton.layer.shadowRadius = 1
        registerButton.layer.shadowOpacity = 0.5
        registerButton.layer.shadowOffset = CGSize(width: 8, height: 8)
        registerButton.layer.shouldRasterize = true
        
        logInButton.layer.cornerRadius = logInButton.frame.size.height / 5
        logInButton.layer.shadowColor = UIColor(named: K.BrandColors.orange)?.cgColor
        logInButton.layer.shadowRadius = 1
        logInButton.layer.shadowOpacity = 0.5
        logInButton.layer.shadowOffset = CGSize(width: 8, height: 8)
        logInButton.layer.shouldRasterize = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "" {
            Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
                if let e = error {
                    DispatchQueue.main.async {
                        self.errorLabel.text = e.localizedDescription
                    }
                } else {
                    DispatchQueue.main.async {
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                    }
                    self.dismissKeyboard()
                    self.performSegue(withIdentifier: K.Segues.loginToMain, sender: self)
                }
            }
        } else {
            errorLabel.text = "Field's Can't Be Empty."
        }
    }
    
    @IBAction func signIn(_ sender: GIDSignInButton) {
        print("Google Sign In")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: K.Segues.googleToMain, sender: self)
            }
        }
    }
}


//MARK: - ViewControllerLifeCycleMethods

extension WelcomeViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

//MARK: - UITextFieldDelegate

extension WelcomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Hello")
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

extension WelcomeViewController: UIGestureRecognizerDelegate {
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
       if touch.view is GIDSignInButton {
            return false
        }
        return true
    }
    
}

