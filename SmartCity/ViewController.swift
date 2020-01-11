//
//  ViewController.swift
//  SmartCity
//
//  Created by Prithviraj Murthy on 20/11/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignIn_Up: UIButtonX!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Auto Sign in
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid != nil {
            self.performSegue(withIdentifier: "mainpage", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextFieldX) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func SignInOrLogIn(_ sender: Any) {
//        SVProgressHUD.show()
//        SVProgressHUD.dismiss()
//        signUp(email: emailTextField.text!, password: passwordTextField.text!)
        if emailTextField.text != "" && passwordTextField.text != "" {
                   
                   let ref = Database.database().reference().child("users")
                    print("SIGNING IN")
        
                   ref.observe(.childAdded) { (snap) in
                       let snapshotValue = snap.value as! NSDictionary
                       print("EMAILS ARE \(snapshotValue)")
                       let email = snapshotValue["Email"] as! String


                               if email == self.emailTextField.text {
                                   print("LOGGIN IN")
                                   self.login(email: self.emailTextField.text!, password: self.passwordTextField.text!)
                               }else{
                                   print("SIGNING UP")
                                   self.signUp(email:self.emailTextField.text!,password: self.passwordTextField.text!)
                               }


                   }
               }else{
                   self.alertTheUser(title: " Email and Password required ", message: "Please enter email and password")
               }
    }
    
 
    func login(email: String,password: String){
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error == nil{
//                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "mainpage", sender: self)
                }else{
                    print("ERROR WHILE LOGGING IN \(error?.localizedDescription)")
                    self.alertTheUser(title: error!.localizedDescription, message: "")
//                    SVProgressHUD.dismiss()
                }
            }
        }
    
    func signUp(email:String,password:String){
              Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                  
                  
                  /*   This is a closure. A closure is a function with no name. Therefore when performing a Segue in a closure always remember to add a
                   self.  before performSegue method as done below.  */
                  
                  if (user != nil) {
                      //Success
                      
                      print("Registration Successful")
                      let ref = Database.database().reference().child("IOSusers").child(Auth.auth().currentUser!.uid)
                      ref.updateChildValues(["Email" : email])
//                      SVProgressHUD.dismiss()
                      self.performSegue(withIdentifier: "mainpage", sender: self)
                      
                  } else {
                      print("ERROR WHILE SIGNING UP IS :: \(error?.localizedDescription)")
                      self.alertTheUser(title: (error?.localizedDescription)!, message: "Email eg: test@mail.com ")
//                      SVProgressHUD.dismiss()
                          
                      }
                  }
              }
    
    
    
    func alertTheUser(title: String, message: String){
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           //        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
               alert.dismiss(animated: true, completion: nil)
           }))
           self.present(alert, animated: true, completion: nil)
           
       }
}

