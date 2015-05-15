//
//  ROLAboutController.swift
//  ResearchOL
//
//  Created by Joshua on 15/5/15.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLAboutController: UIViewController {
    @IBOutlet weak var iconView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iconView.layer.cornerRadius = 12
        self.iconView.layer.masksToBounds = true
        self.view.backgroundColor = ROLColors.coolGrayColor
    }
}
