//
//  OverlayViewController.swift
//  iPrototype
//
//  Created by Jack on 1/26/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class OverlayViewController: BaseViewController {
    
    enum OverleyType: Int {
        case Chat = 1
        case Slider = 2
        case Feed = 3
    }
    
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDefaults()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.openParentController()
    }

}

// MARK: - Private functions.

extension OverlayViewController {
    
    private func configureDefaults() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func openParentController() {
        
        let type = self.view.tag
        
        var controller = UIViewController()
        switch type {
        case 1:
            let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: ChatViewController.className) as! ChatViewController
        case 2:
            let storyboard = UIStoryboard.init(name: "Slider", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: SliderViewController.className) as! SliderViewController
        case 3:
            let storyboard = UIStoryboard.init(name: "Feed", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: FeedViewController.className) as! FeedViewController
        default:
            let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: ChatViewController.className) as! ChatViewController
        }
        
        self.navigationController?.pushViewController(controller, animated: false)
    }
}
