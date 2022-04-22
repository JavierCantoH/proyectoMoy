//
//  UITextField+Extension.swift
//  ProyectoMoy
//
//  Created by Luis Javier Canto Hurtado on 21/04/22.
//

import Foundation
import UIKit

extension UITextField {
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "ic_eye_show"), for: .normal)
        }else{
            button.setImage(UIImage(named: "ic_eye_hide"), for: .normal)
            
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
