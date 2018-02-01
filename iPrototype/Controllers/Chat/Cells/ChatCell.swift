//
//  ChatCell.swift
//  iPrototype
//
//  Created by Jack on 1/28/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var bubbleViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bubbleViewLeadingSpace: NSLayoutConstraint!
    var message: Dictionary<String, Any>? {
        didSet {
            self.configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

// MARK: - Private functions.

extension ChatCell {
    
    private func configureCell() {
        
        self.infoLabel.text = message?["message"] as? String ?? ""
        
        let textWidth: CGFloat = (self.infoLabel.text?.width(withConstraintedHeight: 21, font: UIFont.systemFont(ofSize: 17)))!
        if textWidth < 30 {
            self.bubbleViewWidth.constant = 30
        } else {
            self.bubbleViewWidth.constant = (textWidth + 20 > Constants.SCREEN_WIDTH / 2) ? (Constants.SCREEN_WIDTH / 2) : (textWidth + 20)
        }
        
        let name = message?["name"] as? String ?? ""
        let leftSpeaker: Bool = name == "Jack"
        self.bubbleViewLeadingSpace.constant = leftSpeaker ? 15 : Constants.SCREEN_WIDTH - self.bubbleViewWidth.constant - 15
        self.bubbleView.backgroundColor = leftSpeaker ? UIColor.blue : UIColor.green
        
    }
}
