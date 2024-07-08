//
//  BasketTable.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import Foundation

import RealmSwift

class BasketCategory: Object {
    @Persisted var categoryTitle: String
    @Persisted var productList: List<BasketTable>
}


class BasketTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var productNum: Int
    @Persisted var link: String
    @Persisted var imageUrl: String
    @Persisted var mallName: String
    @Persisted var price: String
    
    convenience init(title: String,
                     productNum: Int,
                     link: String,
                     imageUrl: String,
                     mallName: String,
                     price: String
    ) {
        self.init()
        self.title = title
        self.productNum = productNum
        self.link = link
        self.imageUrl = imageUrl
        self.mallName = mallName
        self.price = price
    }
}


