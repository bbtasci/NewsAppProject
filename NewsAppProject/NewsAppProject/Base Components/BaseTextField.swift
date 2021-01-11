//
//  BaseTextField.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import Foundation
import UIKit

class BaseTextField: UITextField {
    func prepareLightGrayTextField() {
        lightGrayBackground()
        prepareCornerRadius(radius: 5)
    }
    
    func prepareWhiteTextField() {
        whiteBackground()
        prepareCornerRadius(radius: 5)
    }
}
