//
//  AllVideos.swift
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

class AllVideos: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var playerView1: YTPlayerView!
    
    @IBOutlet weak var playerView2: YTPlayerView!
    
    @IBOutlet weak var playerView3: YTPlayerView!
    
    @IBOutlet weak var playerView4: YTPlayerView!
    
    @IBOutlet weak var playerView5: YTPlayerView!
    
    @IBOutlet weak var playerView6: YTPlayerView!
    
    @IBOutlet weak var playerView7: YTPlayerView!
    
    @IBOutlet weak var playerView8: YTPlayerView!
    
    @IBOutlet weak var playerView9: YTPlayerView!
    
    @IBOutlet weak var playerView10: YTPlayerView!
    
    @IBOutlet weak var playerView11: YTPlayerView!
    
    @IBOutlet weak var playerView12: YTPlayerView!
    
    @IBOutlet weak var playerView13: YTPlayerView!
    
    @IBOutlet weak var playerView14: YTPlayerView!
    
    @IBOutlet weak var playerView15: YTPlayerView!
    
    @IBOutlet weak var playerView16: YTPlayerView!
    
    @IBOutlet weak var playerView17: YTPlayerView!
    
    @IBOutlet weak var playerView18: YTPlayerView!
    
    
    @IBOutlet weak var playerView19: YTPlayerView!
    
    @IBOutlet weak var playerView20: YTPlayerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView1.load(withVideoId: "U5lZBjWDR_c")
        playerView2.load(withVideoId: "JMd1CcGZYwU")
        playerView3.load(withVideoId: "oHv6vTKD6lg")
        playerView4.load(withVideoId: "WPPPFqsECz0")
        playerView5.load(withVideoId: "3o9etQktCpI")
        playerView6.load(withVideoId: "nsGbtrl1WkU")
        playerView7.load(withVideoId: "IReEu2kI6oI")
        playerView8.load(withVideoId: "LAFhiiDfii0")
        playerView9.load(withVideoId: "V-E8XYRQJNg")
        playerView10.load(withVideoId: "PnzVzfQXq_s")
        playerView11.load(withVideoId: "-qXldjnrf4A")
        playerView12.load(withVideoId: "v7AYKMP6rOE")
        
        playerView13.load(withVideoId: "dArgOrm98Bk")
        playerView14.load(withVideoId: "B2B94bBUB_I")
        playerView15.load(withVideoId: "O9UByLyOjBM")
        playerView16.load(withVideoId: "8LBwl8caLIs")
        playerView17.load(withVideoId: "ZBYB9kUr9-Q")
        playerView18.load(withVideoId: "JW6d7RA5n9A")
        
        playerView19.load(withVideoId: "n3Xv_g3g-mA")
        playerView20.load(withVideoId: "dQPMyuW8VTQ")
    }
}
