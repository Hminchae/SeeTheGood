//
//  LineView.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/15/24.
//

import UIKit

final class LineView: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .thirdGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
