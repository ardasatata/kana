//
//  MyButton.swift
//  Kana
//
//  Created by Arda Satata on 08/07/19.
//  Copyright © 2019 Arda Satata. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    override func didMoveToWindow() {
        self.backgroundColor = UIColor.darkGray
        self.layer.cornerRadius = self.frame.height / 12
        self.setTitleColor(UIColor.white, for: .normal)
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowRadius = 4
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

}
