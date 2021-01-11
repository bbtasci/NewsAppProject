//
//  RemainingNewsTableViewCell.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import UIKit

class RemainingNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var readListActionButton: UIButton!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    
    weak var delegate: RemainingNewsTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readListActionButton.layer.cornerRadius = 5
        readListActionButton.layer.masksToBounds = true
        readListActionButton.setTitle("Read List", for: .normal)
        newsImageView.layer.cornerRadius = 5
        newsImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNewsCell(item: ArticleModel) {
        let url = URL(string: item.urlToImage ?? "")
        let imageData = try? Data(contentsOf: url!)
        
        newsImageView.image = UIImage(data: imageData!)
        newsDescriptionLabel.text = item.title
        newsDateLabel.text = String((item.publishedAt)?.prefix(10) ?? "")
    }
    
    @IBAction func readListActionButtonTouched(_ sender: Any) {
    }
    
}
