//
//  ViewController.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//  API Key: aaafdfadc47b4bedbaaa8e8d9e49d25c

import UIKit
import Alamofire

class HomeScreenViewController: BaseViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var readingListButton: BaseButton!
    @IBOutlet weak var categoryTextField: BaseTextField!
    @IBOutlet weak var newsChannelsTableView: BaseTableView!
    
    // MARK: - PROPERTIES
    
    var categoryList = ["all categories", "business", "entertainment", "general", "health", "science", "sports", "technology"]
    var categoryPickerView = ToolbarPickerView()
    var newsList = NewsApiModel()
    
    // MARK: - LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        newsChannelsTableView.reloadData()
        getNews()
        addActivityIndicator()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        prepareUI()
//        addActivityIndicator()
//        newsChannelsTableView.reloadData()
//        getNews()
//    }
    
    // MARK: - PREPARE UI
    
    func prepareUI() {
        prepareCategoryPickerView()
        prepareTableView()
        prepareLayers()
    }
    
    func prepareLayers() {
        prepareNavigationItems(title: "WORLD NEWS", backButtonTitle: "Home")
        readingListButton.prepareLightGrayButton()
        readingListButton.setButtonTitleAndSize(title: "READING LIST", titleSize: 20)
        categoryTextField.prepareLightGrayTextField()
        categoryTextField.placeholder = "Choose Category"
        newsChannelsTableView.prepareLightGrayTableView()
    }
    
    func prepareCategoryPickerView() {
        categoryTextField.inputView = categoryPickerView
        categoryTextField.inputAccessoryView = categoryPickerView.toolbar
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.toolbarDelegate = self
    }
    
    func prepareTableView() {
        newsChannelsTableView.delegate = self
        newsChannelsTableView.dataSource = self
        newsChannelsTableView.separatorColor = .black
        newsChannelsTableView.separatorStyle = .singleLine
        newsChannelsTableView.register(UINib(nibName: "NewsChannelsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsChannelsTableViewCell")
        newsChannelsTableView.reloadData()
    }
    
    func getTurkeyNews() {
            activityView.startAnimating()
            AF.request("https://newsapi.org/v2/top-headlines?country=tr&apiKey=aaafdfadc47b4bedbaaa8e8d9e49d25c").responseJSON { response in
                if let channelsData = response.data {
                    let newsChannelsList = try! JSONDecoder().decode(NewsApiModel.self, from: channelsData)
                    self.newsList.sources = newsChannelsList.sources
                    self.newsChannelsTableView.reloadData()
                    self.activityView.stopAnimating()
                }
            }
    }
        
    // MARK: - SERVICE CALL
    
    func getNews() {
        if categoryTextField.text == "" || categoryTextField.text?.lowercased() == "all categories"{
            activityView.startAnimating()
            AF.request("https://newsapi.org/v2/sources?language=en&apiKey=aaafdfadc47b4bedbaaa8e8d9e49d25c").responseJSON { response in
                if let channelsData = response.data {
                    let newsChannelsList = try! JSONDecoder().decode(NewsApiModel.self, from: channelsData)
                    self.newsList.sources = newsChannelsList.sources
                    self.newsChannelsTableView.reloadData()
                    self.activityView.stopAnimating()
                }
            }
        } else {
            activityView.startAnimating()
            AF.request("https://newsapi.org/v2/sources?language=en&category=\(categoryTextField.text?.lowercased() ?? "")&apiKey=aaafdfadc47b4bedbaaa8e8d9e49d25c").responseJSON { response in
                if let channelsData = response.data {
                    let newsChannelsList = try! JSONDecoder().decode(NewsApiModel.self, from: channelsData)
                    self.newsList.sources = newsChannelsList.sources
                    self.newsChannelsTableView.reloadData()
                    self.activityView.stopAnimating()
                }
            }
        }
        
    }
    
    // MARK: - ACTIONS
    
    @IBAction func readingListButtonTouched(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readingListViewController = storyboard.instantiateViewController(identifier: "ReadingListViewController") as! ReadingListViewController
        self.navigationController?.pushViewController(readingListViewController, animated: true)
    }
}

// MARK: - UITABLEVIEW DELEGATE AND DATASOURCE METHODS

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsChannelsTableViewCell") as? NewsChannelsTableViewCell {
            cell.setCell(item: newsList.sources[indexPath.row])
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsPageViewController = storyboard.instantiateViewController(identifier: "NewsPageViewController") as! NewsPageViewController
        newsPageViewController.companyId = self.newsList.sources.first?.id ?? ""
        newsPageViewController.companyName = self.newsList.sources.first?.name ?? ""
        self.navigationController?.pushViewController(newsPageViewController, animated: true)
    }
}

// MARK: - UIPICKERVIEW DELEGATE AND DATASOURCE METHODS

extension HomeScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row].capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categoryList[row].capitalized
    }
}

// MARK: - TOOLBAR PICKER VIEW DELEGATE (In order to add Cancel and Done Buttons to PickerView)

extension HomeScreenViewController: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        let categoryRow = self.categoryPickerView.selectedRow(inComponent: 0)
        self.categoryPickerView.selectRow(categoryRow, inComponent: 0, animated: false)
        self.categoryTextField.text = self.categoryList[categoryRow].capitalized
        self.categoryTextField.resignFirstResponder()
        self.newsChannelsTableView.reloadData()
        self.getNews()
    }
    
    func didTapCancel() {
        //self.categoryTextField.text = nil
        self.categoryTextField.resignFirstResponder()
    }
}
