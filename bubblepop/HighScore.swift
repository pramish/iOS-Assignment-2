//
//  HighScore.swift
//  bubblepop
//
//  Created by Nicholas Yee on 2/5/18.
//  Copyright © 2018 Nicholas Yee. All rights reserved.
//

import UIKit

class HighScore: NSObject {
    
    var name = String()
    var highScore = Int()
    
    func HighScore(nname: String, nscore: Int){
        self.name = nname
        self.highScore = nscore
    }

}
