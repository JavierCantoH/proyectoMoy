//
//  RegisterViewController.swift
//  ProyectoMoy
//
//  Created by Luis Javier Canto Hurtado on 20/04/22.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    private var dropDown: DropDownTextField!
    private var flavourOptions = ["Apellido Paterno", "Apellido Materno", "Fecha de nacimiento", "Género"]
    
    private func addDropDown() {
        let lm = view.layoutMargins
        let height: CGFloat = 40.0
        let dropDownFrame = CGRect(x: lm.left, y: lm.top + 120, width: view.bounds.width - (2 * lm.left), height: height)
        dropDown = DropDownTextField(frame: dropDownFrame, title: "", options: flavourOptions)
        dropDown.delegate = self
        view.addSubview(dropDown)
    }
    
    @UsesAutoLayout
    var emailTextField: UIHeyJudeTextField = {
        let email = UIHeyJudeTextField()
        email.placeholder = "Correo electrónico"
        return email
    }()
    
    @UsesAutoLayout
    var passwordTextField: UIHeyJudeTextField = {
        let password = UIHeyJudeTextField()
        password.placeholder = "Nueva contraseña"
        password.rightViewMode = .always
        return password
    }()
    
    @UsesAutoLayout
    var passwordStrengthProgressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.setProgress(0.5, animated: true)
        progress.trackTintColor = .lightGray
        progress.tintColor = .blue
        return progress
    }()
    
    @UsesAutoLayout
    var passwordStrengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Fuerza contraseña"
        return label
    }()
    
    @UsesAutoLayout
    var confirmPasswordTextField: UIHeyJudeTextField = {
        let confirmPassword = UIHeyJudeTextField()
        confirmPassword.placeholder = "Confirmar Nueva Contraseña"
        confirmPassword.rightViewMode = .always
        return confirmPassword
    }()
    
    @UsesAutoLayout
    var passwordsMatchLabel: UILabel = {
        let label = UILabel()
        label.text = "Las contraseñas coinciden"
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()
    
    @UsesAutoLayout
    var termsLabel: UILabel = {
        let label = UILabel()
        label.text = "Términos y condiciones"
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .cyan
        return label
    }()
    
    @UsesAutoLayout
    var termsSwitch: UISwitch = {
        let swicth = UISwitch()
        return swicth
    }()
    
    @UsesAutoLayout
    var termsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    @UsesAutoLayout
    var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .cyan
        button.setTitle("Regístrate", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // NavBar
        navigationItem.title = "Nuevo Registro"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 40)!]
        // Dropdown
        self.view.layoutMargins = UIEdgeInsets(top: self.view.layoutMargins.top, left: 12.0, bottom: self.view.layoutMargins.bottom, right: 12.0)
        addDropDown()
        // Elements
        view.addSubview(emailTextField)
        //emailTextField.topAnchor.constraint(equalTo: height, constant: 10).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        emailTextField.addLine(position: .bottom, color: .lightGray, width: 0.8)
        
        view.addSubview(passwordTextField)
        passwordTextField.enablePasswordToggle()
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        passwordTextField.addLine(position: .bottom, color: .lightGray, width: 0.8)
        
        view.addSubview(passwordStrengthLabel)
        passwordStrengthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        passwordStrengthLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        
        view.addSubview(passwordStrengthProgressBar)
        passwordStrengthProgressBar.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 22).isActive = true
        passwordStrengthProgressBar.widthAnchor.constraint(equalToConstant: 190).isActive = true
        passwordStrengthProgressBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        passwordStrengthProgressBar.leadingAnchor.constraint(equalTo: passwordStrengthLabel.trailingAnchor, constant: 50).isActive = true
        passwordStrengthProgressBar.layer.cornerRadius = 5
        passwordStrengthProgressBar.clipsToBounds = true
        
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.enablePasswordToggle()
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordStrengthLabel.bottomAnchor, constant: 10).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        confirmPasswordTextField.addLine(position: .bottom, color: .lightGray, width: 0.8)
        
        view.addSubview(passwordsMatchLabel)
        passwordsMatchLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 5).isActive = true
        passwordsMatchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passwordsMatchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        termsStack.addArrangedSubview(termsLabel)
        termsStack.addArrangedSubview(termsSwitch)
        termsLabel.leadingAnchor.constraint(equalTo: termsStack.leadingAnchor, constant: 15).isActive = true
        view.addSubview(termsStack)
        termsStack.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 25).isActive = true
        termsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        termsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        termsStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        termsStack.addLine(position: .bottom, color: .lightGray, width: 0.8)
        
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension RegisterViewController: DropDownTextFieldDelegate {
    func menuDidAnimate(up: Bool) {
        print("animating up: \(up)")
        
    }
    
    func optionSelected(option: String) {
        print("option selected: \(option)")
    }
}
