//
//  ProfieViewModel.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/10/24.
//

import Foundation

class ProfieViewModel {
    
    var inputSelectedImageNum: Observable<Int?> = Observable(nil)
    var outputSelectedImageNum = Observable("")
    
    var inputNickname: Observable<String?> = Observable(nil)
    var outputNickname = Observable("")
    
    init() {
        if inputSelectedImageNum.value == nil {
            inputSelectedImageNum.value = Int.random(in: 0...11)
        }
        inputSelectedImageNum.bind { _ in
            self.imageIndex()
        }
    }
    
    private func imageIndex() {
        guard let imageNum = inputSelectedImageNum.value else { return }
        outputSelectedImageNum.value = "profile_\(imageNum)"
    }
}
