//
//  DetailViewController.swift
//  ImageFun
//
//  Created by Syd Polk on 10/9/19.
//  Copyright © 2019 Syd Polk. All rights reserved.
//

import UIKit

public protocol DetailViewDelegate {
    func setItemTitle(_ imageWithAttributes: ImageWithAttributes, title: String)
}

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTitle: UITextField!
    @IBOutlet weak var attributes: UITextView!
    
    var delegate: DetailViewDelegate?
    
    func configureView() {
        // Update the user interface for the detail item.
        
        guard let _image = image, let _imageTitle = imageTitle, let _attributes = attributes else {
            return
        }
        
        if let imageAttrs = imageWithAttributes {
            _image.image = imageAttrs.image
            _imageTitle.text = imageAttrs.title
            _attributes.text = attributes.text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageTitle.delegate = self
        // Do any additional setup after loading the view.
        configureView()
    }

    var imageWithAttributes: ImageWithAttributes? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func update(_ sender: Any) {
    }
    
    private func updateObserver() {
        if let _delegate = delegate, let _title = imageTitle.text, let _image = imageWithAttributes {
            _delegate.setItemTitle(_image, title: _title)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateObserver()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateObserver()
    }
}

