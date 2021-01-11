//
//  UIButtonExtension.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func setButtonTitleAndSize(title: String, titleSize: CGFloat) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleSize)
    }
}
