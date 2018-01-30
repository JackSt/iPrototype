//
//  OverlayViewController.swift
//  iPrototype
//
//  Created by Jack on 1/26/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class OverlayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}

extension OverlayViewController {
    
    private func openParentController(_ type: Int) {
        
        var controller = BaseViewController()
        switch type {
        case 1:
            
            controller =
        default:
            <#code#>
        }
    }
}
