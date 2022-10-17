//
//  LoginViewController.swift
//  y2k_Wellbeing
//
//  Created by Vikku Ponnaganti on 10/31/21.
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
import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController{
    

    // MARK: Outlets
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    // MARK: Properties
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
      super.viewDidLoad()
      initializeHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: false)
  
      handle = Auth.auth().addStateDidChangeListener { _, user in
        if user == nil {
            print("lvc user is nil")
          self.navigationController?.popToRootViewController(animated: true)
        } else {
            print("lvc user is not nil")
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
    
    @IBAction func login(_ sender: AnyObject) {
            guard
              let email = email.text,
              let password = password.text,
              !email.isEmpty,
              !password.isEmpty
            else { return }

            Auth.auth().signIn(withEmail: email, password: password) { user, error in
              if let error = error, user == nil {
                let alert = UIAlertController(
                  title: "Sign In Failed",
                  message: error.localizedDescription,
                  preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
              }
            }
    }
    
}
extension LoginViewController {
 
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

