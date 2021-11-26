//
//  LoginViewController.swift
//  semana7
//
//  Created by MAC07 on 25/11/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        validateSession()
    }
    

    @IBAction func onClickLogin(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        loginUser(email: email, password: password)
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            authResponse, error in
            
            if error == nil {
                self.goMain()
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            authResponse, error in
            
            if error == nil {
                self.goMain()
            }
        }
    }
    
    func validateSession() {
        if Auth.auth().currentUser != nil {
            self.goMain()
        }
    }
    
    func goMain() {
        self.performSegue(withIdentifier: "segueLogin", sender: nil)
    }
    

}
