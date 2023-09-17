//
//  ViewController.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 16/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var BtnLoggin: UIButton!
    @IBOutlet weak var LblRegister: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleNavigateToRegister))
        LblRegister.isUserInteractionEnabled = true
        LblRegister.addGestureRecognizer(tap)
    }
    
    @objc
    func handleNavigateToRegister() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterScreen") as? RegisterViewController else {
            return
        }
        self.present(vc, animated: true)
    }

    @IBAction func handleLogin(_ sender: Any) {
        self.clearField(field: TxtEmail, placeholder: "E-mail")
        self.clearField(field: TxtPassword, placeholder: "Senha")
        guard let email = TxtEmail.text, !email.isEmpty else {
            self.errorField(field: TxtEmail, placeholder: "Campo de e-mail não pode ser vazio")
            return
        }
        guard let password = TxtPassword.text, !password.isEmpty else {
            self.errorField(field: TxtPassword, placeholder: "Campo de senha não pode ser vazio")
            return
        }
        
        let result = email.range(
            of: #"^\S+@\S+\.\S+$"#,
            options: .regularExpression
        )
        
        if result == nil {
            TxtEmail.text = ""
            self.errorField(field: TxtEmail, placeholder: "Campo de e-mail é inválido")
            return
        }
        
    
        self.handleReqLogin(email: email, password: password)
    }
    
    private func handleReqLogin(email: String, password: String) {
        print("email: \(email), password: \(password)")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav") as? MainController else {
            return
        }
        self.present(vc, animated: true)
    }
    
    private func clearField(field: UITextField, placeholder: String) {
        field.layer.borderWidth = 0.0
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    private func errorField(field: UITextField, placeholder: String) {
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.red.cgColor
        field.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

