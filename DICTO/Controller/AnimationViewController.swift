//
//  AnimationViewController.swift
//  DICTO
//
//  Created by Deepanshu Gautam on 22/07/21.
//

import UIKit
import Firebase
import GoogleSignIn
class AnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: K.Segues.animationToMain, sender: self)
            } else if GIDSignIn.sharedInstance.currentUser != nil {
                self.performSegue(withIdentifier: K.Segues.animationToMain, sender: self)
            } else {
                self.performSegue(withIdentifier: K.Segues.animationToLogin, sender: self)
            }
        }
    }
}
