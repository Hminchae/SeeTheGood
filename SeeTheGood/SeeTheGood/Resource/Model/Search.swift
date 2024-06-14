//
//  Search.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import Foundation

struct Search: Decodable {
    let lastBuildDate: String
    let total, start, display: Int
    var items: [Item]
}

struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice: String
    let mallName: String
    let productId, productType, brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
}
