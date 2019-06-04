//
//  MNavigationController.swift
//  Marvels
//
//  Created by Karambalkar, Vikas - Ext on 05/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class MNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = .black
        self.navigationBar.backIndicatorImage = UIImage(named: "Navigation_Back")
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        // Do any additional setup after loading the view.
    }
}
