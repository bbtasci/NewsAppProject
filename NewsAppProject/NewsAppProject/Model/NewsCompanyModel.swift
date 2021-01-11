//
//  NewsCompanyModel.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 11.01.2021.
//

import Foundation

struct NewsCompanyModel: Codable {
    var articles: [ArticleModel] = []
}

struct ArticleModel: Codable {
    var source: Source
    var title: String?
    var description: String?
    var content: String?
    var author: String?
    var publishedAt: String?
    var urlToImage: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}
