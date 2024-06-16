//
//  Basket.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/17/24.
//

import Foundation

struct Basket: Codable, Equatable {
    let id: String
    let imageUrl: String
    let link: String
    let title: String
    let price: String
}
