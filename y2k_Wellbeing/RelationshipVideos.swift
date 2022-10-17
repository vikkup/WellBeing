//
//  RelationshipVideos.swift
//  y2k_Wellbeing
//
//  Created by Kevin Sampson on 11/29/21.
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

class RelationshipVideos: UIViewController, YTPlayerViewDelegate {
    
    
    @IBOutlet weak var playerView1: YTPlayerView!
    
    @IBOutlet weak var playerView2: YTPlayerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView1.load(withVideoId: "n3Xv_g3g-mA")
        playerView2.load(withVideoId: "dQPMyuW8VTQ")

    }
}
