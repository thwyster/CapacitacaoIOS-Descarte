//
//  CadastroColetorViewController.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 24/04/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import Firebase

class CadastroColetorViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmacaoSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSalvar(_ sender: Any) {
        if (txtSenha.text! == txtConfirmacaoSenha.text!) {
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtSenha.text!) { (result, error) in
                guard (result?.user) != nil
                    else
                {
                    print(error!)
                    return
                }
                
                print("LOGIN DEU BOA")
            }
        }
        else {
            print("LOGIN DEU RUIM!!!")
        }
    }
}
