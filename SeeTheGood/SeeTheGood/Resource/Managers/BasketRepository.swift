//
//  basketRepository.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import Foundation

import RealmSwift

final class BasketRepository {
    
    private let realm = try! Realm()
    
    // 카테고리 목록 패치()
    func fetchCategory() -> [BasketCategory] {
        let value = realm.objects(BasketCategory.self)
        return Array(value)
    }
    
    // 데이터 패치
    func fetchAll() -> [BasketTable] {
        let value = realm.objects(BasketTable.self).sorted(byKeyPath: "title", ascending: false)
        
        return Array(value)
    }
    
    // 데이터 추가
    func addBasketDetailToCategory(data: BasketTable) {
        // "내꺼"라는 title을 가진 BasketCategory 검색
        if let category = realm.objects(BasketCategory.self).filter("categoryTitle == %@", "내꺼").first {
            do {
                try realm.write {
                    category.productList.append(data)
                }
                print("Item added to category successfully")
            } catch {
                print("Failed to add item to category: \(error)")
            }
        } else {
            print("Category with title '내꺼' not found")
        }
    }
    
    // 데이터 생성
    func createItem(_ category: String, data: BasketTable) {
        do {
            try realm.write {
                realm.add(data)
                
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    // 데이터 삭제
    func deleteItem(_ data: BasketTable) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    // 데이터 위치 출력
    func priteFileLocation() {
        print(realm.configuration.fileURL ?? "파일 위치를 찾을 수 없음")
    }
}
