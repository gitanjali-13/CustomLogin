//
//  LoginViewController.swift
//  CustomLogin
//
//  Created by Admin on 08/01/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        //style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        // validate textfields
        
        //craete textfield
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
               //could't signin
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
                
            } else {
                let homeViewController =
                self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboards.homeViewController) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
