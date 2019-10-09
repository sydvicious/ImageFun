//
//  ImageViewCell.swift
//  ImageFun
//
//  Created by Syd Polk on 10/9/19.
//  Copyright © 2019 Syd Polk. All rights reserved.
//

import UIKit

protocol ImageViewCellDelegate {
    func updateWithDetails(image: UIImage?, title: String?, attributes: String? ) -> Void
}

class ImageViewCell: UITableViewCell, ImageViewCellDelegate {

    
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var attributes: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateWithDetails(image: UIImage?, title: String?, attributes: String? ) -> Void {
        self.imageContainer.image = image
        self.title.text = title
        self.attributes.text = attributes
    }

}
