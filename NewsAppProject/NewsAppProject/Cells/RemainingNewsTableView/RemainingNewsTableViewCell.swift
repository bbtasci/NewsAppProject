//
//  RemainingNewsTableViewCell.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import UIKit

class RemainingNewsTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    
    @IBOutlet weak var readListActionButton: UIButton!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    
    // MARK: - PROPERTIES
    
    weak var delegate: RemainingNewsTableViewCell?
    var addedNews: Articles?
    
    // MARK: - LIFE CYCLE METHODS
    
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
    
    // MARK: - METHODS
    
    func setNewsCell(item: Articles) {
        let url = URL(string: item.urlToImage ?? "")
        let imageData = try? Data(contentsOf: url!)
        newsImageView.image = UIImage(data: imageData!)
        
        newsDescriptionLabel.text = item.title
        newsDateLabel.text = String((item.publishedAt)?.prefix(10) ?? "")
    }
    
    func addToReadingList() {
        if ReadingListConveyor.shared.shownList.first(where: { $0.content == addedNews?.content }) != nil {
            print("Already in list")
        } else {
            ReadingListConveyor.shared.shownList.append(addedNews!)
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func readListActionButtonTouched(_ sender: Any) {
        addToReadingList()
        readListActionButton.layer.backgroundColor = CGColor(red: 5/255, green: 182/255, blue: 0/255, alpha: 1)
        readListActionButton.setTitle("In Reading List", for: .normal)
    }
    
}
