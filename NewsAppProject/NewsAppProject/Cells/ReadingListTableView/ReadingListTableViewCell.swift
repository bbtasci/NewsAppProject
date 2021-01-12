//
//  ReadingListTableViewCell.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 12.01.2021.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    
    @IBOutlet weak var listNewsImageView: UIImageView!
    @IBOutlet weak var listNewsDescriptionLabel: BaseLabel!
    @IBOutlet weak var listNewsDateLabel: BaseLabel!
    
    // MARK: - PROPERTIES
    
    weak var delegate: ReadingListViewController?
    
    // MARK: - LIFE CYCLE METHODS
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prepareUI()
    }
    
    func prepareUI() {
        prepareLayers()
    }
    
    func prepareLayers() {
        listNewsImageView.prepareCornerRadius(radius: 5)
        listNewsDateLabel.prepareLightGrayLabel()
        listNewsDescriptionLabel.prepareLightGrayLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setListCell(item: Articles) {
        let url = URL(string: item.urlToImage ?? "")
        let imageData = try? Data(contentsOf: url!)
        
        listNewsImageView.image = UIImage(data: imageData!)
        listNewsDescriptionLabel.text = item.title
        listNewsDateLabel.text = String((item.publishedAt)?.prefix(10) ?? "")
    }
}
