//
//  NewsChannelsTableViewCell.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import UIKit

class NewsChannelsTableViewCell: UITableViewCell {

    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelDescriptionLabel: UILabel!
    
    weak var delegate: NewsChannelsTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(item: Sources) {
        channelNameLabel.text = item.name
        channelDescriptionLabel.text = item.description
    }
    
}
