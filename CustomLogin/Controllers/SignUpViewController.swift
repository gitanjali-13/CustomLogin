//
//  SignUpViewController.swift
//  CustomLogin
//
//  Created by Admin on 08/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // add back button to go back main page
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
        
    }
// chck fields and validate that the data is correct if everything correct return nil otherwise return error.
    func validateFields() -> String? {
        // check fields are filled
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Please fill the fields"
        }
        
        // check password is valid
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "please check password must be contain atleast 8 characters and special symbols and number"
        }
        return nil
    }
   
    @IBAction func signUpButton(_ sender: Any) {
        
        //validte the user
        let error = validateFields()
        if error != nil {
//            errorLabel.text = error!
//            errorLabel.alpha = 1
            showError(error!)
        } else {
            //create cleaned of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check the errors
                if err != nil {
                    // there was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    //user crated successfully
                    let db = Firestore.firestore()
                    
                    //adding new data using .document().setData() methods
                    db.collection("users").document(result!.user.uid).setData(["firstname" : firstName,"lastname": lastName,"email" : email, "password" : password,"uid": result!.user.uid])
                    
                    // using getDocument(completion:) we can retrieve data from dashboard.
//                    db.collection("users").document(result!.user.uid).getDocument { snapshot , err in
//                        if err != nil {
//                            self.showError("error in saving user data")
//                        }
//                    }
//
                    
                     //adding new data using .addDocument()
//                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid])
//                    { error in
//
//                        if error != nil {
//                            self.showError("error saving dada")
//
//                        }
//                    }
                    //transition to home page
                    self.transitionToHome()
                }
                
            }
        }
        
    }
    func showError (_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome() {
        let homeViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboards.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
