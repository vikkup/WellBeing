//
//  MeaningfulAccomplishVideos.swift
//  y2k_Wellbeing
//
//  Created by Kevin Sampson on 11/29/21.
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
import youtube_ios_player_helper
import SwiftUI

class MeaningfulAccomplishVideos: UIViewController, YTPlayerViewDelegate {
    
   
    @IBOutlet weak var playerView1: YTPlayerView!
    
    @IBOutlet weak var playerView2: YTPlayerView!
    
    @IBOutlet weak var playerView3: YTPlayerView!
    
    @IBOutlet weak var playerView4: YTPlayerView!
    
    @IBOutlet weak var playerView5: YTPlayerView!
    
    @IBOutlet weak var playerView6: YTPlayerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView1.load(withVideoId: "dArgOrm98Bk")
        playerView2.load(withVideoId: "B2B94bBUB_I")
        playerView3.load(withVideoId: "O9UByLyOjBM")
        playerView4.load(withVideoId: "8LBwl8caLIs")
        playerView5.load(withVideoId: "ZBYB9kUr9-Q")
        playerView6.load(withVideoId: "JW6d7RA5n9A")
    }
}
