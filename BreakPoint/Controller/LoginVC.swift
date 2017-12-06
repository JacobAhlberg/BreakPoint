//
//  LoginVC.swift
//  BreakPoint
//
//  Created by Jacob Ahlberg on 2017-11-28.
//  Copyright © 2017 Jacob Ahlberg. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginCreationComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginCreationComplete: { (success, nil) in
                            print("SUCCESSFULLY CREATED USER")
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
                
            })
        }
        
        
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
}
