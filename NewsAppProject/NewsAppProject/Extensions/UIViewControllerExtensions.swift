//
//  UIViewControllerExtensions.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showTemporarilyAlert(title: String, message: String, duration: Int) {
        let durationOfAlert = DispatchTime.now() + .seconds(duration)
        let showTemporarilyAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(showTemporarilyAlert, animated: true, completion: nil)
        let when = durationOfAlert
        DispatchQueue.main.asyncAfter(deadline: when){
            showTemporarilyAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    func prepareNavigationItems(title: String, backButtonTitle: String) {
        self.navigationItem.title = title
        self.navigationItem.backButtonTitle = backButtonTitle
    }
    
}
