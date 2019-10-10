//
//  ImageWithAttributes.swift
//  ImageFun
//
//  Created by Syd Polk on 10/9/19.
//  Copyright © 2019 Syd Polk. All rights reserved.
//

import UIKit

public struct ImageWithAttributes: Hashable {
    public let image: UIImage
    public let title: String
    public let attributes: String
    public let index: Int
    
    public init(image: UIImage, title: String, attributes: String) {
        self.image = image
        self.title = title
        self.attributes = attributes
        self.index = Int(arc4random_uniform(UInt32(1000000)))
    }
}
