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
    
    // 데이터 패치
    func fetchAll() -> [BasketTable] {
        let value = realm.objects(BasketTable.self).sorted(byKeyPath: "productId", ascending: false)
        
        return Array(value)
    }

    // 데이터 생성
    func createItem(_ data: BasketTable) {
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
    
    // 데이터 수정
    func updateItem(_ data: BasketTable,
                    target: String,
                    value: Any
    ) {
        do {
            try realm.write {
                realm.create(BasketTable.self,
                             value: ["id": data.id,
                                     target: value],
                             update:  .modified)
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
