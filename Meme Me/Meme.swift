//
//  Meme.swift
//  Meme Me
//
//  Created by Ken Westdorp on 7/4/17.
//
//

import Foundation
import UIKit

struct Meme {
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!

    init (topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
