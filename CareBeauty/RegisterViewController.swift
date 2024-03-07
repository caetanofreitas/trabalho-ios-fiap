//
//  RegisterViewController.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 16/09/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var TxtConfirmPassword: UITextField!
    @IBOutlet weak var BtnRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBOutlet weak var CancelButton: UIButton!
    @IBAction func handleClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func handleRegister(_ sender: UIButton) {
        self.clearField(field: TxtEmail, placeholder: "E-mail")
        self.clearField(field: TxtPassword, placeholder: "Senha")
        self.clearField(field: TxtConfirmPassword, placeholder: "Confirmar Senha")
        
        guard let email = TxtEmail.text, !email.isEmpty else {
            self.errorField(field: TxtEmail, placeholder: "Campo de e-mail não pode ser vazio")
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
        
        guard let password = TxtPassword.text, !password.isEmpty else {
            self.errorField(field: TxtPassword, placeholder: "Campo de senha não pode ser vazio")
            return
        }
        guard let confirmPassword = TxtConfirmPassword.text, !confirmPassword.isEmpty else {
            TxtConfirmPassword.text = ""
            self.errorField(field: TxtConfirmPassword, placeholder: "Campo de confirmação  de senha não pode ser vazio")
            return
        }
        
        if password != confirmPassword {
            TxtConfirmPassword.text = ""
            self.errorField(field: TxtConfirmPassword, placeholder: "Campo diferente da senha")
            return
        }
    
        self.handleReqRegister(email: email, password: password)
    }
    
    private func handleReqRegister(email: String, password: String) {
        if self.verifyUserExistance(email: email) {
            do {
                let newUser = User(context: context)
                newUser.email = email
                newUser.password = password
                try context.save()
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav") as? MainController else {
                    return
                }
                self.present(vc, animated: true)
            } catch {
                self.errorField(field: TxtEmail, placeholder: error.localizedDescription)
                self.errorField(field: TxtPassword, placeholder: error.localizedDescription)
            }
        } else {
            self.errorField(field: TxtEmail, placeholder: "Falha para criar novo usuário")
            self.errorField(field: TxtPassword, placeholder: "Falha para criar novo usuário")
        }
    }
    
    private func verifyUserExistance(email: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    
    private func clearField(field: UITextField, placeholder: String) {
        field.layer.borderWidth = 0.0
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    private func errorField(field: UITextField, placeholder: String) {
        field.text = ""
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.red.cgColor
        field.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
