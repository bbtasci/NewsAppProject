//
//  NewsApiModel.swift
//  NewsAppProject
//
//  Created by Baris Berkin Tasci on 10.01.2021.
//

import Foundation

struct NewsApiModel: Codable {
    var sources: [Sources] = []
}

struct Sources: Codable {
    var id: String?
    var name: String?
    var description: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?    
}
