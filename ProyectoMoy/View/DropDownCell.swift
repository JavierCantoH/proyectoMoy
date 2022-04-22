//
//  DropDownCell.swift
//  ProyectoMoy
//
//  Created by Luis Javier Canto Hurtado on 18/04/22.
//

import UIKit

enum TextFieldData: Int {
    case apellidoPaterno = 0
    case apellidoMaterno
    case fechaNacimiento
    case genero
}

class DropDownCell: UITableViewCell {

    var placeholder: String? {
        didSet {
            guard let item = placeholder else { return }
            dataTextField.placeholder = item
        }
    }
    
    let dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    func initConstraints(){
        addSubview(dataTextField)
        NSLayoutConstraint.activate([
//            dataTextField.heightAnchor.constraint(equalToConstant: 100),
            dataTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 54),
            dataTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dataTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dataTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
