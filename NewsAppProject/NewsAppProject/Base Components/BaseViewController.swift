//
//  BaseViewController.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var activityView : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
    
    func addActivityIndicator() {
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        activityView.color = .black
        activityView.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    func prepareNavigationItem(title: String, backButtonTitle: String) {
        self.navigationItem.title = title
        self.navigationItem.backButtonTitle = backButtonTitle
    }
    
}
