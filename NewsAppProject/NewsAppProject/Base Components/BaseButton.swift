//
//  BaseButton.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import Foundation
import UIKit

class BaseButton: UIButton {
    func prepareBlackButton() {
        darkBackground()
        prepareCornerRadius(radius: 5)
    }
    
    func prepareLightGrayButton() {
        lightGrayBackground()
        prepareCornerRadius(radius: 5)
    }
}
