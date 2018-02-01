//
//  FeedCollectionCell.swift
//  iPrototype
//
//  Created by Jack on 1/29/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class FeedCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoLabelHeight: NSLayoutConstraint!
    
    static let offset: CGFloat = 10
    
    var text: String?
    var image: UIImage? {
        didSet {
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

// Private functions.

extension FeedCollectionCell {
    
    private func configureCell() {
        
        self.imageView.image = self.image
        self.infoLabel.text = self.text ?? ""
        // Info label height.
        let cellWidth = (Constants.SCREEN_WIDTH - FeedCollectionCell.offset * 3) / 2
        let textWidth = cellWidth - 20
        
        self.infoLabelHeight.constant = self.infoLabel.text!.height(withConstrainedWidth: textWidth, font: UIFont.systemFont(ofSize: 17))
    }
}

// Class functions.

extension FeedCollectionCell {
    
    class func cellSize(image: UIImage, text: String) -> CGSize {
        
        // Cell width.
        let cellWidth = (Constants.SCREEN_WIDTH - offset * 3) / 2
        
        // Image.
        let scale = image.size.width / cellWidth
        let imageHeight = image.size.height / scale
        
        // Text.
        let textWidth = cellWidth - 20
        let textHeight = text.height(withConstrainedWidth: textWidth, font: UIFont.systemFont(ofSize: 17))
        
        // Cell height.
        let cellHeight = imageHeight + 10 + textHeight + 10
        
        // Cell cize.
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
}

