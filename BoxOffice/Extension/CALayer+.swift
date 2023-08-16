//
//  CALayer+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/04.
//

import UIKit

extension CALayer {
    func addSeparator(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let separator = CALayer()
        
        separator.frame = CGRect.init(x: x, y: y, width: width, height: height)
        separator.backgroundColor = UIColor.systemGray2.cgColor
        
        self.addSublayer(separator)
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
