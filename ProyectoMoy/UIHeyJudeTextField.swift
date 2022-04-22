//
//  UIHeyJudeTextField.swift
//  Hey Jude
//
//  Created by Moisés  Garduño Reyes on 18/04/22.
//

import Foundation
import UIKit

class UIHeyJudeTextField : UITextField {
    
    var textPadding = UIEdgeInsets(
        top: 12,
        left: 14,
        bottom: 12,
        right: 14
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
