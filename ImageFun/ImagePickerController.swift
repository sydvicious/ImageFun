//
//  ImagePickerController.swift
//  ImageFun
//
//  Created by Syd Polk on 10/9/19.
//  Copyright © 2019 Syd Polk. All rights reserved.
//

import UIKit

public protocol ImagePickerControllerDelegate {
    func setImage(image: UIImage?)
}

class ImagePickerController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var imagePicker: ImagePicker!
    var delegate: ImagePickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.cameraButton.isEnabled = false
        }
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    public func setDelegate(_ delegate: ImagePickerControllerDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.setImage(image: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        self.delegate?.setImage(image: self.imageView.image)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoLibrary(_ sender: Any) {
        self.imagePicker.presentPicker(for: .photoLibrary)
    }
    
    @IBAction func cameraRoll(_ sender: Any) {
        self.imagePicker.presentPicker(for: .savedPhotosAlbum)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        self.imagePicker.presentPicker(for: .camera)
    }
}

extension ImagePickerController: ImagePickerDelegate {
    public func didSelect(image: UIImage?) {
        guard let image = image else {
            self.doneButton.isEnabled = false
            return
        }
        self.imageView.image = image
    }
}
