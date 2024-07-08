//
//  UINavigationBar+Extension.swift
//  SeeTheGood
//
//  Created by 황민채 on 7/8/24.
//

import UIKit

extension UINavigationBar {
    func makeLineOnNavBar() {
        let bottomLine = UIView(frame: CGRect(x: 0, 
                                              y: self.frame.size.height - 1,
                                              width: self.frame.size.width,
                                              height: 1))
        
        bottomLine.backgroundColor = .gray.withAlphaComponent(0.5)
        bottomLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        self.addSubview(bottomLine)
    }
}
