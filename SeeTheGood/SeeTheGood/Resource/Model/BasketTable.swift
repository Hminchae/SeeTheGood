//
//  BasketTable.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import Foundation

import RealmSwift

class BasketTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var productId: Int
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var mallName: String
    @Persisted var price: String
    
    convenience init(productId: Int,
                     title: String,
                     link: String,
                     image: String,
                     mallName: String,
                     price: String
    ) {
        self.init()
        self.productId = productId
        self.title = title
        self.link = link
        self.image = image
        self.mallName = mallName
        self.price = price
    }
}
