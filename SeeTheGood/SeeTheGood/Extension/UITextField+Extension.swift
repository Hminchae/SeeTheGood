//
//  UITextField+Extension.swift
//  SeeTheGood
//
//  Created by 황민채 on 6/14/24.
//

import UIKit

public extension UITextField {
    // 플레이스홀더 텍스트의 색상을 변경하는 extension
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}
