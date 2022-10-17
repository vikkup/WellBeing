//
//  GratitudeTree.swift
//  y2k_Wellbeing
//
//  Created by Kevin Sampson on 12/13/21.
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

class GratitudeTree: UIViewController {
    
    @IBOutlet var timeLabel:  UILabel!
    let userDefaults = UserDefaults()
    @IBOutlet weak var textInput: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        timeLabel.text = "The current day is: " + Date().dayOfWeek
    }
    
  
    func alertPopUP(ttl:String,msg:String)
    {
        let dialogMsg = UIAlertController(title: ttl, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in print("OK Button Tapped")})
        dialogMsg.addAction(ok)
        self.present(dialogMsg,animated: true, completion: nil)
    }
    
    @IBAction func sundayBtn(_ sender: Any)
    {
        if let value = userDefaults.value(forKey: "sun") as? String {
            alertPopUP(ttl: "Sunday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Sunday", msg: "No entry created this week")
        }
    }
    @IBAction func mondayBtn(_ sender: Any)
    {
        if let value = userDefaults.value(forKey: "mon") as? String {
            alertPopUP(ttl: "Monday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Monday", msg: "No entry created this week")
        }
    }
    @IBAction func tuesdayBtn(_ sender: Any)
    {
        if let value = userDefaults.value(forKey: "tues") as? String {
            alertPopUP(ttl: "Tuesday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Tuesday", msg: "No entry created this week")
        }
    }
    
    @IBAction func wednesdayLeaf(_ sender: Any) {
        if let value = userDefaults.value(forKey: "wed") as? String {
            alertPopUP(ttl: "Wednesday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Wednesday", msg: "No entry created this week")
        }
    }
    @IBAction func thursdayBtn(_ sender: Any)
    {
        if let value = userDefaults.value(forKey: "thur") as? String {
            alertPopUP(ttl: "Thursday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Thursday", msg: "No entry created this week")
        }
    }
    @IBAction func fridayBtn(_ sender: Any)
    {
        if let value = userDefaults.value(forKey: "fri") as? String {
            alertPopUP(ttl: "Friday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Friday", msg: "No entry created this week")
        }
    }
    @IBAction func saturdayBtn(_ sender: Any)
    {
        if let value = userDefaults.value(forKey: "sat") as? String {
            alertPopUP(ttl: "Saturday", msg: value)
        }
        else
        {
            alertPopUP(ttl: "Saturday", msg: "No entry created this week")
        }
    }
    
    
    @IBAction func clearTreeBtn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sun")
        UserDefaults.standard.removeObject(forKey: "mon")
        UserDefaults.standard.removeObject(forKey: "tues")
        UserDefaults.standard.removeObject(forKey: "thur")
        UserDefaults.standard.removeObject(forKey: "fri")
        UserDefaults.standard.removeObject(forKey: "sat")
        alertPopUP(ttl: "Tree Cleared", msg: "All leaves have been reset")
    }
    
    
    
    
    @IBAction func createLeafMsg(_ sender: Any) {
    
        if textInput.text == ""
        {
            alertPopUP(ttl: "Error!", msg: "You must submit a message.")
        }
        else if Date().dayOfWeek == "Sunday"
        {
            userDefaults.setValue(textInput.text, forKey: "sun")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else if Date().dayOfWeek == "Monday"
        {
            userDefaults.setValue(textInput.text, forKey: "mon")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else if Date().dayOfWeek == "Tuesday"
        {
            userDefaults.setValue(textInput.text, forKey: "tues")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else if Date().dayOfWeek == "Wednesday"
        {
            userDefaults.setValue(textInput.text, forKey: "wed")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else if Date().dayOfWeek == "Thursday"
        {
            userDefaults.setValue(textInput.text, forKey: "thur")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else if Date().dayOfWeek == "Friday"
        {
            userDefaults.setValue(textInput.text, forKey: "fri")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else if Date().dayOfWeek == "Saturday"
        {
            userDefaults.setValue(textInput.text, forKey: "sat")
            textInput.text = ""
            alertPopUP(ttl: "Success!", msg: "Check todays leaf to see your message.")
        }
        else
        {
            print("there was issues")
        }
    }
}
extension GratitudeTree {
 
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

extension Date {
  /**
   Usage: print(Date().dayOfWeek) \\\ Monday
   */
  var dayOfWeek: String {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("EEEE")
    return formatter.string(from: self)
  }
}
