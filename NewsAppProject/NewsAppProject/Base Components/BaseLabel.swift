//
//  BaseLabel.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import Foundation
import UIKit

class BaseLabel: UILabel {
    func prepareLightGrayLabel() {
        prepareCornerRadius(radius: 5)
        lightGrayBackground()
    }
}
