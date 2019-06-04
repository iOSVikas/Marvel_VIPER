//
//  MLoader.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import SVProgressHUD

class MLoader: NSObject {
    
    //MARK: shared instense
    static let shared = MLoader()
    
    //MARK: Loader methods
    func showLoader() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4))
    }
    
    func showLoader(message: String){
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }

}
