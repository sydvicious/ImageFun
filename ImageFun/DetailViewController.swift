//
//  DetailViewController.swift
//  ImageFun
//
//  Created by Syd Polk on 10/9/19.
//  Copyright © 2019 Syd Polk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var attributes: UITextView!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let imageAttrs = imageWithAttributes {
            image.image = imageAttrs.image
            imageTitle.text = imageAttrs.title
            attributes.text = attributes.text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var imageWithAttributes: ImageWithAttributes? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

