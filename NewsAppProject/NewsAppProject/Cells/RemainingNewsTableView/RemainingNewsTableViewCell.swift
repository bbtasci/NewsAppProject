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
    var article: Articles?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readListActionButton.layer.cornerRadius = 5
        readListActionButton.layer.masksToBounds = true
        readListActionButton.layer.borderWidth = 2
        readListActionButton.layer.borderColor = UIColor.black.cgColor
        readListActionButton.layer.backgroundColor = UIColor.lightGray.cgColor
        readListActionButton.setTitleColor(.black, for: .normal)
        readListActionButton.setTitle("Add to Read List", for: .normal)
        
        newsImageView.layer.borderWidth = 2
        newsImageView.layer.borderColor = UIColor.black.cgColor
        newsImageView.layer.cornerRadius = 5
        newsImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setNewsCell(item: Articles) {
        let url = URL(string: item.urlToImage ?? "")
        let imageData = try? Data(contentsOf: url!)
        newsImageView.image = UIImage(data: imageData!)
        
        newsDescriptionLabel.text = item.title
        newsDateLabel.text = String((item.publishedAt)?.prefix(10) ?? "")
    }
    
    @IBAction func readListActionButtonTouched(_ sender: Any) {
        //article?.urlToImage =
        // add to reading list
        //readListActionButton.layer.backgroundColor = UIColor.green.cgColor
        //readListActionButton.setTitle("In Reading List", for: .normal)
        //Transporter.shared.shownList.append(article!)
       
    }
    
}
