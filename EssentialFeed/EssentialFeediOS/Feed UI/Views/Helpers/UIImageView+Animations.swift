//
//  UIImageView+Animations.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 09/09/25.
//
import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
