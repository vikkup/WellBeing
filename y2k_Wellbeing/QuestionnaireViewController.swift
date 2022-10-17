//
//  QuestionnaireViewController.swift
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
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class QuestionnaireViewController: UIViewController {
    
    var items = Items()
    var counter = 0
    var indices = [0,0,0,0,0]
    
    @IBOutlet weak var qLabel: UILabel!
    @IBOutlet weak var qSlider: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextQ(_ sender: Any) {
        switch counter {
        case 0:
            items.emotion[indices[0]].score = Int(qSlider.value)
            indices[1] =  Int.random(in: 0..<4)
            qLabel.text = items.accomplishment[indices[1]].question
            qSlider.value = Float(items.accomplishment[indices[1]].score)
        case 1:
            items.accomplishment[indices[1]].score = Int(qSlider.value)
            indices[2] =  Int.random(in: 0..<3)
            qLabel.text = items.engagement[indices[2]].question
            qSlider.value = Float(items.engagement[indices[2]].score)

        case 2:
            items.engagement[indices[2]].score = Int(qSlider.value)
            indices[3] =  Int.random(in: 0..<4)
            qLabel.text = items.relationship[indices[3]].question
            qSlider.value = Float(items.relationship[indices[3]].score)

        case 3:
            items.relationship[indices[3]].score = Int(qSlider.value)
            indices[4] =  Int.random(in: 0..<3)
            qLabel.text = items.meaning[indices[4]].question
            qSlider.value = Float(items.meaning[indices[4]].score)
            
        case 4:
            items.meaning[indices[4]].score = Int(qSlider.value)
            qLabel.text = "Your score is \(getScore())"
            qSlider.isHidden = true
            nextButton.isHidden = true
            //nextButton.setTitle("Continue", for: .normal)
            
        default:
            //self.performSegue(withIdentifier: "ContinueToCharts", sender: self)
            return
            
        }
            
        counter+=1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        indices[0] =  Int.random(in: 0..<4)
        qLabel.text = items.emotion[indices[0]].question
        qSlider.value = Float(items.emotion[indices[0]].score)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getScore() -> Int {
        var score: Int = 0
        score += items.emotion[indices[0]].revScore ? 10 - items.emotion[indices[0]].score : items.emotion[indices[0]].score
        score += items.accomplishment[indices[1]].score
        score += items.engagement[indices[2]].score
        score += items.relationship[indices[3]].revScore ? 10 - items.relationship[indices[3]].score : items.relationship[indices[3]].score
        score += items.meaning[indices[4]].score
        
        let db = Firestore.firestore()
        
        let data: [String: Any] = ["date": Date(),
                                   "score": "\(score)"]
        
        if let userID = Auth.auth().currentUser?.uid {
            db.collection("user_scores").document(userID).setData([ "scores": FieldValue.arrayUnion([data])], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        
        return score
    }
}


struct Score: Codable{
    var score: String
    var date: Date
}

struct Scores: Codable {
    var scores: [Score]
}

struct Item {
    var question: String
    var score: Int
    var revScore: Bool
}

struct Items {
    var emotion: [Item] =
    [Item(question: "To what degree did you feel joyful today?",
          score: 5, revScore: false),
     Item(question: "To what degree did you feel positive today?",
          score: 5, revScore: false),
     Item(question: "How much did you feel anxious today?",
          score: 5, revScore: true),
     Item(question: "Taking all things together, how happy were you today?",
          score: 5, revScore: false)]
    
    var accomplishment: [Item] =
    [Item(question: "How much did you feel you made progress towards accomplishing your goals today?", score: 5, revScore: false),
     Item(question: "To what degree were you able to handle your responsibilities today?", score: 5, revScore: false),
     Item(question: "To what extent did you feel pleased about having accomplished something?", score: 5, revScore: false),
     Item(question: "To what extent did you feel a sense of accomplishment from the things you did today?", score: 5, revScore: false)]
    
    var engagement: [Item] =
    [Item(question: "On average, to what degree were you fully absorbed in what you were doing today?", score: 5, revScore: false),
     Item(question: "On average, to what extent did you feel excited and interested in the things you did today?", score: 5, revScore: false),
     Item(question: "On average, how engaged and interested were you in the things you did today?", score: 5, revScore: false)]
    
    var relationship: [Item] =
    [Item(question: "To what extent did you feel loved today?", score: 5, revScore: false),
     Item(question: "To what extent did you receive help and support from others when you needed it today?", score: 5, revScore: false),
     Item(question: "How lonely did you feel today?", score: 5, revScore: true),
     Item(question: "How much of the time today did you feel close/connected to other people?", score: 5, revScore: false)]
    
    var meaning: [Item] =
    [Item(question: "To what degree did you work on purposeful and meaningful things today?", score: 5, revScore: false),
     Item(question: "To what extent do you feel that the things you were doing today are valuable and worthwhile?", score: 5, revScore: false),
     Item(question: "To what extent did the things you did today give you a sense of direction in your life?", score: 5, revScore: false)]
}
