//
//  NewsPageViewController.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import UIKit
import Alamofire

class NewsPageViewController: BaseViewController {

    // MARK: - OUTLETS
    
    @IBOutlet weak var companyNameLabel: BaseLabel!
    @IBOutlet weak var threeNewsCollectionView: UICollectionView!
    @IBOutlet weak var remainingNewsTableView: BaseTableView!
    
    // MARK: - PROPERTIES
    
    var companyId: String = ""
    var companyName: String = ""
    var newsListOfCompany = NewsCompanyModel()
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getNewsChannelsFromAPI()
        addActivityIndicator()
    }
    
    // MARK: - PREPARE UI
    
    func prepareUI() {
        prepareLayers()
        prepareTableView()
    }
    
    func prepareLayers() {
        prepareNavigationItem(title: "\(companyName.uppercased())", backButtonTitle: "Home")
        companyNameLabel.prepareLightGrayLabel()
        companyNameLabel.text = companyName
        remainingNewsTableView.prepareLightGrayTableView()
    }
    
    // MARK: - PREPARE TABLE VIEW
    
    func prepareTableView() {
        remainingNewsTableView.delegate = self
        remainingNewsTableView.dataSource = self
        remainingNewsTableView.separatorColor = .black
        remainingNewsTableView.separatorStyle = .singleLine
        remainingNewsTableView.register(UINib(nibName: "RemainingNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "RemainingNewsTableViewCell")
        remainingNewsTableView.reloadData()
        
    }
    
    // MARK: - SERVICE CALL
    
    func getNewsChannelsFromAPI() {
        activityView.startAnimating()
        AF.request("https://newsapi.org/v2/top-headlines?sources=\(companyId)&apiKey=aaafdfadc47b4bedbaaa8e8d9e49d25c").responseJSON { response in
            if let channelNewsData = response.data {
                let newsListOfChannel = try! JSONDecoder().decode(NewsCompanyModel.self, from: channelNewsData)
                self.newsListOfCompany.articles = newsListOfChannel.articles
                self.remainingNewsTableView.reloadData()
                self.activityView.stopAnimating()
            }
        }
    }
    
}

// MARK: - UITABLEVIEW DELEGATE AND DATASOURCE METHODS

extension NewsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListOfCompany.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Hide first three news that will be shown in top
        if indexPath.row == 0 {
            return 0
        } else if indexPath.row == 1 {
            return 0
        } else if indexPath.row == 2 {
            return 0
        }
        return tableView.rowHeight
        
        //return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RemainingNewsTableViewCell") as? RemainingNewsTableViewCell {
            cell.setNewsCell(item: newsListOfCompany.articles[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailPageViewController = storyboard.instantiateViewController(identifier: "DetailPageViewController") as! DetailPageViewController
        detailPageViewController.newsTitle = newsListOfCompany.articles.first?.title
        detailPageViewController.newsAuthor = newsListOfCompany.articles.first?.author
        detailPageViewController.newsDate = newsListOfCompany.articles.first?.publishedAt
        detailPageViewController.newsDescription = newsListOfCompany.articles.first?.description
        detailPageViewController.newsImageUrl = newsListOfCompany.articles.first?.urlToImage
        self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
}
