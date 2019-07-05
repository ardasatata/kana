//
//  Character.swift
//  Kana
//
//  Created by Arda Satata on 02/07/19.
//  Copyright © 2019 Arda Satata. All rights reserved.
//

import UIKit
import os.log

class Character {
    
    //PROP
    var id: Int
    var type: String
    var char: String
    var romaji: [String]
    
    init(id:Int, type:String, char:String , romaji:[String]) {
        self.id = id // identifier
        self.type = type // hiragana atau katakana
        self.char = char // characternya
        self.romaji = romaji // array 
    }
    
    init(){
        self.id = -1
        self.type = ""
        self.char = ""
        self.romaji = []
    }
    
}
