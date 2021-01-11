//
//  UITextFieldExtensions.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import Foundation
import UIKit

extension UIView {
    func prepareCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func darkBackground() {
        self.backgroundColor = .black
    }
    
    func lightGrayBackground() {
        self.backgroundColor = .lightGray
    }
    
    func whiteBackground() {
        self.backgroundColor = .white
    }
}
