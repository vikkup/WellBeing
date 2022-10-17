//
//  ChartsView.swift
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
import Charts
import ToastViewSwift
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class ChartsView: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      barChartView.animate(yAxisDuration: 2.0)
      barChartView.pinchZoomEnabled = false
      barChartView.drawBarShadowEnabled = false
      barChartView.drawBordersEnabled = false
      barChartView.doubleTapToZoomEnabled = false
      barChartView.drawGridBackgroundEnabled = true
      barChartView.chartDescription?.text = "Bar Chart View"
    
        guard let userID = Auth.auth().currentUser?.uid else {
            let toast = Toast.text("User must be logged in")
            toast.show()
            return
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("user_scores").document(userID)
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dates = [String]()
                var values = [Int]()
                do {
                    if let scores = try document.data(as: Scores.self) {
                        for score in scores.scores {
                            let dateStr = formatter1.string(from: score.date)
                            dates.append(dateStr)
                            values.append(Int(score.score)!)
                        }
                    }
                } catch {
                    let toast = Toast.text("Technical Error! Please try later.")
                    toast.show()
                    print(error)
                }
                
                self.setChart(dataPoints: dates, values: values.map { Double($0) })
                
            } else {
                print("Document does not exist.")
                let toast = Toast.text("No data found.")
                toast.show()
            }
        }

    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
      barChartView.noDataText = "You need to provide data for the chart."
      
      var dataEntries: [BarChartDataEntry] = []
      
      for i in 0..<dataPoints.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
      }
      
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        chartDataSet.colors = [UIColor(red: 229/255, green: 114/255, blue: 71/255, alpha: 1)]
      let chartData = BarChartData(dataSet: chartDataSet)
      barChartView.data = chartData
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }

    @IBAction func QuestionButtonClicked(_ sender: Any) {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            let toast = Toast.text("User must be logged in")
            toast.show()
            return
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("user_scores").document(userID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    if let scores = try document.data(as: Scores.self) {
                        let count = scores.scores.count
                        let score = scores.scores[count-1]
                        if Calendar.current.isDate(Date(), inSameDayAs:score.date) {
                            let toast = Toast.text("You have done the questionnaire already today.")
                            toast.show()
                        } else {
                            print("Today's entry doesnt exists")
                            self.performSegue(withIdentifier: "ChartsToQ", sender: self)
                        }
                    }
                } catch {
                    let toast = Toast.text("Techincal Error! Please try later")
                    toast.show()
                    print(error)
                }
                
            } else {
                print("Document does not exist")
                self.performSegue(withIdentifier: "ChartsToQ", sender: self)
            }
        }
        
    }
}
