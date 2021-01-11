//
//  ReadingListViewController.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import UIKit

class ReadingListViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var readingListTableView: BaseTableView!
    
    // MARK: - PROPERTIES
    
    var readingList = NewsCompanyModel()
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()

    }
    
    // MARK: - PREPARE UI
    
    func prepareUI() {
        prepareLayers()
        prepareTableView()
    }
    
    func prepareLayers() {
        titleLabel.prepareLightGrayLabel()
        titleLabel.text = "MY READING LIST"
        
        readingListTableView.prepareLightGrayTableView()
    }
    
    func prepareTableView() {
        readingListTableView.delegate = self
        readingListTableView.dataSource = self
        readingListTableView.separatorColor = .black
        readingListTableView.separatorStyle = .singleLine
        readingListTableView.register(UINib(nibName: "ReadingListTableViewCell", bundle: nil), forCellReuseIdentifier: "ReadingListTableViewCell")
        readingListTableView.reloadData()
    }

}

    // MARK: - UITABLEVIEW DELEGATE AND DATASOURCE METHODS

extension ReadingListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingList.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RemainingNewsTableViewCell") as? RemainingNewsTableViewCell {
            cell.setNewsCell(item: readingList.articles[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailPageViewController = storyboard.instantiateViewController(identifier: "DetailPageViewController") as! DetailPageViewController
        detailPageViewController.newsTitle = readingList.articles.first?.title
        detailPageViewController.newsAuthor = readingList.articles.first?.author
        detailPageViewController.newsDate = readingList.articles.first?.publishedAt
        detailPageViewController.newsDescription = readingList.articles.first?.description
        detailPageViewController.newsImageUrl = readingList.articles.first?.urlToImage
        self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            readingList.articles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
