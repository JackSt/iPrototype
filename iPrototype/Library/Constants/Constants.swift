//
//  Constants.swift
//  iPrototype
//
//  Created by Jack on 1/28/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import Foundation
import UIKit
//import PKHUD

class Constants {
    
    static let sharedInstance = Constants()
        
        
        // Sizes.
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        
        // Activity.
        
//        class func showActivity() {
//            HUD.show(.rotatingImage(#imageLiteral(resourceName: "loader")))
//            HUD.dimsBackground = true
//        }
//
//        class func hideActivity() {
//            HUD.hide(animated: true)
//        }
    
        // Alerts.
        
        class func showAlert(title: String, message: String) {
            let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alertVC.view.tintColor = UIColor.black
            alertVC.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { action -> Void in
            }))
            let topVC = UIApplication.topViewController()
            if topVC is UIAlertController {
                return
            }
            topVC?.present(alertVC, animated: true, completion: nil)
        }

}
