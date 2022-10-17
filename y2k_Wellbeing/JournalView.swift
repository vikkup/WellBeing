//
//  JournalView.swift
//  y2k_Wellbeing
//
//  Created by Kevin Sampson on 10/11/21.
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

import UIKit
import FirebaseDatabase
import FirebaseAuth

class JournalView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var models: [(title: String, note: String)] = []
    
    var ref: DatabaseReference!
    let currentUser = Auth.auth().currentUser
   
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Journal"
        ref = Database.database().reference(withPath: "user-journals")
        // Do any additional setup after loading the view.
        //get journal data from firebase realtime db
        let userRef = ref.child(currentUser!.uid)
        userRef.observe(.value, with: { snapshot in
            //reset models array
            self.models = []
            // This is the snapshot of the data at the moment in the Firebase database
            // To get value from the snapshot, we use snapshot.value
            for child in snapshot.children{
                let childDS = child as! DataSnapshot
                if let dictionary = childDS.value as? [String: Any] {
                    if let note = dictionary["note"] as? String {
                        // access individual value in dictionary
                        self.models.append((title: childDS.key, note: note))
                    }
                }
            }
            if (self.models.count > 0) {
                self.table.isHidden = false
            }
            self.table.reloadData()
        })
    }
    
    @IBAction func newJournalEntry() {
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = "New Journal"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { [self]journalTitle, journal in
            self.navigationController?.popToRootViewController(animated: true)
            //self.models.append((title: journalTitle, note: journal))
            let userRef = self.ref.child(currentUser!.uid)
            let journalRef = userRef.child(journalTitle)
            journalRef.setValue(["note": journal])
            self.label.isHidden = true
            self.table.isHidden = false
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "journal") as? JournalController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Journal"
        vc.journalTitle = model.title
        vc.text = model.note
        navigationController?.pushViewController(vc, animated: true)
    }
}
