//
//  DropDownTextField.swift
//  ProyectoMoy
//
//  Created by Luis Javier Canto Hurtado on 20/04/22.
//

import UIKit

protocol DropDownTextFieldDelegate {
    func menuDidAnimate(up: Bool)
    func optionSelected(option: String)
}

class DropDownTextField: UIView {
    
    var delegate: DropDownTextFieldDelegate?
    private var options: [String]
    private var isDroppedDown = false
    private var initialHeight: CGFloat = 0
    private let rowHeight: CGFloat = 65
    
    var underline = UIView()
    
    let triangleIndicator: UIImageView = {
        let image = UIImage(named: "ic_arrow_down")
        image!.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tapView: UIView = UIView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DropDownCell.self, forCellReuseIdentifier: "option")
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = .lightGray
        return tableView
    }()
    
    let animationView = UIView()
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = .black
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        textField.placeholder = "Nombre"
        return textField
    }()
    
    init(frame: CGRect, title: String, options: [String]) {
        self.options = options
        super.init(frame: frame)
        self.textField.text = title
        calculateHeight()
        setupViews()
    }
    
    private override init(frame: CGRect) {
        options = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func animateMenu() {
        menuAnimate(up: isDroppedDown)
    }
    
}

extension DropDownTextField {
    
    private func calculateHeight() {
        self.initialHeight = self.bounds.height
        let rowCount = self.options.count
        let newHeight = self.initialHeight + (CGFloat(rowCount) * rowHeight)
        self.frame.size = CGSize(width: self.frame.width, height: newHeight)
    }
    
    func setupViews() {
        removeSubviews()
        addUnderline()
        addTriangleIndicator()
        addTextField()
        addTapView()
        addTableView()
        addAnimationView()
    }
    
    private func removeSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func addUnderline() {
        addSubview(underline)
        underline.backgroundColor = .lightGray
        underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline.topAnchor.constraint(equalTo: topAnchor, constant: initialHeight - 2),
            underline.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 0.8)
        ])
    }
    
    private func addTriangleIndicator() {
        triangleIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(triangleIndicator)
        let triSize: CGFloat = 30.0
        NSLayoutConstraint.activate([
            triangleIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            triangleIndicator.heightAnchor.constraint(equalToConstant: triSize),
            triangleIndicator.widthAnchor.constraint(equalToConstant: triSize),
            triangleIndicator.centerYAnchor.constraint(equalTo: topAnchor, constant: initialHeight / 2)
        ])
    }
    
    private func addTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.centerYAnchor.constraint(equalTo: topAnchor, constant: initialHeight / 2),
            textField.trailingAnchor.constraint(equalTo: triangleIndicator.leadingAnchor, constant: -8)
        ])
        textField.delegate = self
    }
    
    private func addTapView() {
        tapView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateMenu))
        tapView.addGestureRecognizer(tapGesture)
        addSubview(tapView)
        tapView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tapView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        tapView.constraintsPinTo(leading: textField.trailingAnchor, trailing: trailingAnchor, top: topAnchor, bottom: triangleIndicator.bottomAnchor)
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.constraintsPinTo(leading: leadingAnchor, trailing: trailingAnchor, top: underline.bottomAnchor, bottom: bottomAnchor)
        tableView.isHidden = true
    }
    
    private func addAnimationView() {
        self.addSubview(animationView)
        animationView.frame = CGRect(x: 0.0, y: initialHeight, width: bounds.width, height: bounds.height - initialHeight)
        self.sendSubviewToBack(animationView)
        animationView.backgroundColor = .white
        animationView.isHidden = true
    }
    
    private func menuAnimate(up: Bool) {
        let downFrame = animationView.frame
        let upFrame = CGRect(x: 0, y: self.initialHeight, width: self.bounds.width, height: 0)
        animationView.frame = up ? downFrame : upFrame
        animationView.isHidden = false
        tableView.isHidden = true
        triangleIndicator.image = UIImage(named: "ic_arrow_down")
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.animationView.frame = up ? upFrame : downFrame
        }, completion: { (bool) in
            self.isDroppedDown = !self.isDroppedDown
            self.animationView.isHidden = up
            self.animationView.frame = downFrame
            self.tableView.isHidden = up
            self.delegate?.menuDidAnimate(up: up)
            self.triangleIndicator.image = UIImage(named: "ic_arrow_up")
        })
    }
}



extension DropDownTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let capitalized = text.capitalized
        textField.text = capitalized
        delegate?.optionSelected(option: capitalized)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    func otherChosen() {
        animateMenu()
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
}

extension DropDownTextField: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "option") as? DropDownCell {
            cell.placeholder = options[indexPath.row]
            cell.dataTextField.tag = indexPath.row
            cell.dataTextField.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(options.count + 1)
    }
}
