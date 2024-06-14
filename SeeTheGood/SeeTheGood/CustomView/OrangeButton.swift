//
//  orangeButton.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/13/24.
//

import UIKit

final class OrangeButton: UIButton {
    
    init(style: ViewConstant.OrangeBtnTextStyle) {
        super.init(frame: .zero)
        
        setTitle(style.rawValue, for: .normal)
        titleLabel?.font = ViewConstant.Font.heavy16
        layer.cornerRadius = ViewConstant.Radius.orangeButton
        backgroundColor = .point
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
