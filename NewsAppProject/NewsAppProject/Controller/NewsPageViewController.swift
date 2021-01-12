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
    
    var APIKEY = "d488a7d146f24615b5950054fd4040b3"
    var companyId: String = ""
    var companyName: String = ""
    var newsListOfCompany = NewsCompanyModel()
    //var cellArticle = Articles()
    
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
        prepareCollectionView()
    }
    
    func prepareLayers() {
        prepareNavigationItem(title: "WORLD NEWS", backButtonTitle: "World News")
        companyNameLabel.prepareLightGrayLabel()
        companyNameLabel.text = companyName
    }
    
    // MARK: - PREPARE TABLE VIEW
    
    func prepareTableView() {
        remainingNewsTableView.delegate = self
        remainingNewsTableView.dataSource = self
        remainingNewsTableView.separatorColor = .black
        remainingNewsTableView.separatorStyle = .singleLine
        remainingNewsTableView.register(UINib(nibName: "RemainingNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "RemainingNewsTableViewCell")
        remainingNewsTableView.reloadData()
        remainingNewsTableView.prepareLightGrayTableView()
        
    }
    
    // MARK: - PREPARE COLLECTION VIEW
    
    func prepareCollectionView() {
        threeNewsCollectionView.delegate = self
        threeNewsCollectionView.dataSource = self
        threeNewsCollectionView.reloadData()
        threeNewsCollectionView.prepareCornerRadius(radius: 5)
    }
    
    // MARK: - SERVICE CALL
    
    func getNewsChannelsFromAPI() {
        activityView.startAnimating()
        AF.request("https://newsapi.org/v2/top-headlines?sources=\(companyId)&apiKey=\(APIKEY)").responseJSON { response in
            if let channelNewsData = response.data {
                let newsListOfChannel = try! JSONDecoder().decode(NewsCompanyModel.self, from: channelNewsData)
                self.newsListOfCompany.articles = newsListOfChannel.articles
                self.threeNewsCollectionView.reloadData()
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
            cell.backgroundColor = .lightGray
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailPageViewController = storyboard.instantiateViewController(identifier: "DetailPageViewController") as! DetailPageViewController
        detailPageViewController.newsTitle = newsListOfCompany.articles[indexPath.row].title
        detailPageViewController.newsAuthor = newsListOfCompany.articles[indexPath.row].author
        detailPageViewController.newsDate = newsListOfCompany.articles[indexPath.row].publishedAt
        detailPageViewController.newsDescription = newsListOfCompany.articles[indexPath.row].description
        detailPageViewController.newsImageUrl = newsListOfCompany.articles[indexPath.row].urlToImage
        self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
}

extension NewsPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsListOfCompany.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = newsListOfCompany.articles[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreeNewsCollectionViewCell", for: indexPath) as? ThreeNewsCollectionViewCell {
            cell.setCollectionCell(item: article)
//            cell.layer.borderWidth = 0.5
//            cell.layer.borderColor = UIColor.white.cgColor
//            cell.layer.cornerRadius = 5
//            cell.layer.masksToBounds = true
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //384 - 414
        
        let width = self.view.frame.width - 30
        let height: CGFloat = 200.0
        
        return CGSize(width: width, height: height)
    }
    
    
}
