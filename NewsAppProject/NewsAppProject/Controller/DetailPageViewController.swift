//
//  DetailPageViewController.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import UIKit

class DetailPageViewController: BaseViewController {

    @IBOutlet weak var newsTitleLabel: BaseLabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsAuthorLabel: BaseLabel!
    @IBOutlet weak var newsDateLabel: BaseLabel!
    @IBOutlet weak var newsDescriptionLabel: BaseLabel!
    
    var newsTitle: String?
    var newsImageUrl: String?
    var newsAuthor: String?
    var newsDate: String?
    var newsDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        // Do any additional setup after loading the view.
    }
    
    func prepareUI() {
        let url = URL(string: newsImageUrl ?? "")
        let imageData = try? Data(contentsOf: url!)
        newsImageView.image = UIImage(data: imageData!)
        prepareLayers()
    }
    func prepareLayers() {
        
        newsImageView.layer.cornerRadius = 5
        newsImageView.layer.masksToBounds = true
        
        newsTitleLabel.text = newsTitle
        newsTitleLabel.prepareLightGrayLabel()
        
        newsAuthorLabel.text = newsAuthor
        newsAuthorLabel.prepareLightGrayLabel()
        
        newsDateLabel.text = String(newsDate?.prefix(10) ?? "")
        newsDateLabel.prepareLightGrayLabel()
        
        newsDescriptionLabel.text = newsDescription
        newsDescriptionLabel.prepareLightGrayLabel()
    }

}
