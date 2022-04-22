//
//  ViewController.swift
//  ProyectoMoy
//
//  Created by Luis Javier Canto Hurtado on 18/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        button.backgroundColor = .green
        button.setTitle("Registrar usuario", for: .normal)
        return button
    }()
    
    @objc func tapButton(){
        let register = RegisterViewController()
        navigationController?.pushViewController(register, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        navigationItem.title = "Inicio"
    }
}
