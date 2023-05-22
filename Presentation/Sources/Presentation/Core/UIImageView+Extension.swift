//
//  UIImageView+Extension.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

extension UIImageView {
    func setImage(image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.image = image
        self.contentMode = contentMode
    }
    
    func setPlaceholder(image: UIImage?) {
        setImage(image: image, contentMode: .scaleAspectFill)
    }
}
