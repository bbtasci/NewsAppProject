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
    @IBOutlet weak var topThreeHeadlinesPageController: UIPageControl!
    @IBOutlet weak var remainingNewsTableView: BaseTableView!
    
    // MARK: - PROPERTIES
    
    var APIKEY = "d488a7d146f24615b5950054fd4040b3"
    var companyId: String = ""
    var companyName: String = ""
    var newsListOfCompany = NewsCompanyModel()
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
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
        //prepareScrollView()
    }
    
    func prepareLayers() {
        prepareNavigationItem(title: "WORLD NEWS", backButtonTitle: "World News")
        
        companyNameLabel.prepareLightGrayLabel()
        companyNameLabel.text = companyName
    }
    
//    func prepareScrollView() {
//        configurePageController()
//
//        topThreeHeadlinesScrollView.delegate = self
//        topThreeHeadlinesScrollView.isPagingEnabled = true
//        self.view.addSubview(topThreeHeadlinesScrollView)
//
//        for index in 0..<4 {
//
//            frame.origin.x = self.topThreeHeadlinesScrollView.frame.size.width * CGFloat(index)
//            frame.size = self.topThreeHeadlinesScrollView.frame.size
//
//            let subView = UIView(frame: frame)
//            subView.backgroundColor = .brown
//
//
//            //let newsImageUrl = self.newsListOfCompany.articles.first?.urlToImage
//            //let url = URL(string: newsImageUrl ?? "")
//            //let imageData = try? Data(contentsOf: url!)
//            //subView.largeContentImage = UIImage(data: imageData!)
//
//
//
//            self.topThreeHeadlinesScrollView.addSubview(subView)
//        }
//
//        self.topThreeHeadlinesScrollView.contentSize = CGSize(width:self.topThreeHeadlinesScrollView.frame.size.width * 4,height: self.topThreeHeadlinesScrollView.frame.size.height)
//        topThreeHeadlinesPageController.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
//
//    }
//
//    func configurePageController() {
//        self.topThreeHeadlinesPageController.numberOfPages = newsListOfCompany.articles.count
//        self.topThreeHeadlinesPageController.currentPage = 0
//        self.topThreeHeadlinesPageController.tintColor = UIColor.red
//        self.topThreeHeadlinesPageController.pageIndicatorTintColor = UIColor.black
//        self.topThreeHeadlinesPageController.currentPageIndicatorTintColor = UIColor.green
//        self.view.addSubview(topThreeHeadlinesPageController)
//    }
//
//    @objc func changePage(sender: AnyObject) -> () {
//        let x = CGFloat(topThreeHeadlinesPageController.currentPage) * topThreeHeadlinesScrollView.frame.size.width
//        topThreeHeadlinesScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        let pageNumber = round(topThreeHeadlinesScrollView.contentOffset.x / scrollView.frame.size.width)
//        topThreeHeadlinesPageController.currentPage = Int(pageNumber)
//    }
//
    
    // MARK: - SERVICE CALL
    
    func getNewsChannelsFromAPI() {
        activityView.startAnimating()
        AF.request("https://newsapi.org/v2/top-headlines?sources=\(companyId)&apiKey=\(APIKEY)").responseJSON { response in
            if let channelNewsData = response.data {
                let newsListOfChannel = try! JSONDecoder().decode(NewsCompanyModel.self, from: channelNewsData)
                self.newsListOfCompany.articles = newsListOfChannel.articles
                self.remainingNewsTableView.reloadData()
                self.activityView.stopAnimating()
            }
        }
    }
    
    // MARK: - PREPARE SCROLL VIEW
    

    
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
            cell.addedNews = newsListOfCompany.articles[indexPath.row]
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


/*
 
 func prepareScrollView() {
     configurePageController()
     
     topThreeHeadlinesScrollView.delegate = self
     topThreeHeadlinesScrollView.isPagingEnabled = true
     self.view.addSubview(topThreeHeadlinesScrollView)
     
     for index in 0..<4 {

         frame.origin.x = self.topThreeHeadlinesScrollView.frame.size.width * CGFloat(index)
         frame.size = self.topThreeHeadlinesScrollView.frame.size

         let subView = UIView(frame: frame)
         subView.backgroundColor = .brown
         
         
         let newsImageUrl = self.newsListOfCompany.articles.first?.urlToImage
         let url = URL(string: newsImageUrl ?? "")
         let imageData = try? Data(contentsOf: url!)
         subView.largeContentImage = UIImage(data: imageData!)
         
         
         
         self.topThreeHeadlinesScrollView.addSubview(subView)
     }

     self.topThreeHeadlinesScrollView.contentSize = CGSize(width:self.topThreeHeadlinesScrollView.frame.size.width * 4,height: self.topThreeHeadlinesScrollView.frame.size.height)
     topThreeHeadlinesPageController.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)

 }

 func configurePageController() {
     self.topThreeHeadlinesPageController.numberOfPages = newsListOfCompany.articles.count
     self.topThreeHeadlinesPageController.currentPage = 0
     self.topThreeHeadlinesPageController.tintColor = UIColor.red
     self.topThreeHeadlinesPageController.pageIndicatorTintColor = UIColor.black
     self.topThreeHeadlinesPageController.currentPageIndicatorTintColor = UIColor.green
     self.view.addSubview(topThreeHeadlinesPageController)
 }

 @objc func changePage(sender: AnyObject) -> () {
     let x = CGFloat(topThreeHeadlinesPageController.currentPage) * topThreeHeadlinesScrollView.frame.size.width
     topThreeHeadlinesScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
 }

 func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

     let pageNumber = round(topThreeHeadlinesScrollView.contentOffset.x / scrollView.frame.size.width)
     topThreeHeadlinesPageController.currentPage = Int(pageNumber)
 }
 
 */
