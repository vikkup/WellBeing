//
//  SignUpViewController.swift
//  y2k_Wellbeing
//
//  Created by Vikku Ponnaganti on 11/7/21.
//  This project is called Wellbeing and is a program that asks the user about their mental health
//  and allows the user to create journal entries so that they can record how their day was.
//  Copyright (C) 2021 Brian Boyle, Vikku Ponnaganti, Kevin Sampson
//  This file is part of Wellbeing.
//    Wellbeing is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Wellbeing is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Wellbeing.  If not, see <https://www.gnu.org/licenses/>.
//

import Foundation
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    


    // MARK: Outlets

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    // MARK: Properties
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }

    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
      super.viewDidLoad()
      initializeHideKeyboard()
      email.delegate = self
      password.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: false)
      handle = Auth.auth().addStateDidChangeListener { _, user in
        if user != nil {
          print("cavc user not nil")
          let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myTabBarController")
          viewController.modalPresentationStyle = .fullScreen
          self.present(viewController, animated: false, completion: nil)
          self.email.text = nil
          self.password.text = nil
        }
      }
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      guard let handle = handle else { return }
      Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        guard
            let email = email.text,
            let password = password.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
            
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
            } else {
                print("Error in createAccount: \(error?.localizedDescription ?? "")")
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == email {
      password.becomeFirstResponder()
    }

    if textField == password {
      textField.resignFirstResponder()
    }
    return true
  }
}
extension SignUpViewController {
 
     func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
 
 }
