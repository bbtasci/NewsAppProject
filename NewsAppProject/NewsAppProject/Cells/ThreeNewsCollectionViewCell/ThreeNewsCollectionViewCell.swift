//
//  ThreeNewsCollectionViewCell.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 12.01.2021.
//

import UIKit

class ThreeNewsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topNewsImageView: UIImageView!
    @IBOutlet weak var topNewsDescriptionLabel: BaseLabel!
    
    func setCollectionCell(item: Articles) {
        let url = URL(string: item.urlToImage ?? "")
        let imageData = try? Data(contentsOf: url!)
        
        topNewsImageView.image = UIImage(data: imageData!)
        topNewsDescriptionLabel.text = item.title
        
        topNewsDescriptionLabel.prepareLightGrayLabel()
    }
    
}
