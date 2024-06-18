//
//  UILabel+Extension.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/17/24.
//

import UIKit

public extension UILabel {
    // 레이블에 하이라이팅을 하는 익스텐션
    func setHighlighted(_ text: String, with search: String) {
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: search, options: .caseInsensitive)
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: UIColor.point.withAlphaComponent(0.5)]
        
        attributedText.addAttributes(highlightedAttributes, range: range)
        self.attributedText = attributedText
    }
}
