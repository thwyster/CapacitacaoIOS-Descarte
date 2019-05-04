//
//  CadastroUsuarioViewController.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 24/04/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import Firebase

class CadastroUsuarioViewController: UIViewController {

    //Variáveis de Tela
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCPF: UITextField!
    @IBOutlet weak var txtCEP: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmacaoSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        if (ValidaCamposPreenchidos()) {
            if (ValidaSenha()) {
                CriarLogin()
            }
        }
    }
    
    //TODO - FUNCOES UTEIS, JOGAR ELAS PRA UMA BASE DEPOIS
    func ValidaCamposPreenchidos() -> Bool {
        if (txtNome.text != ""
            && txtCPF.text != ""
            && txtCEP.text != ""
            && txtEmail.text != ""
            && txtSenha.text != ""
            && txtConfirmacaoSenha.text != "")
        {
            return true
        }
        else {
            print("PREENCHA TODOS OS CAMPOS")
            return false
        }
    }
    
    func ValidaSenha() -> Bool {
        if (txtSenha.text! == txtConfirmacaoSenha.text!) {
            return true
        }
        else {
            return false
        }
    }
    
    func CriarLogin() {
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtSenha.text!) { (result, error) in
            guard let user = result?.user
                else
            {
                print("LOG - LOGIN DEU RUIM")
                print(error!)
                return
            }
            
            //Caso o cadastro da Colecao Usuario de errado já exclui o usuario cadastrado.
            if !self.CadastrarUsuarioCompleto(user.uid) {
                self.ExcluirUsuario()
            }
        }
    }
    
    func CadastrarUsuarioCompleto(_ idUsuario: String) -> Bool {
        let db = Firestore.firestore()
        var usuarioCadastrado = true;
        
        var ref: DocumentReference? = nil
        ref = db.collection("usuario").addDocument(data: [
            "Nome": txtNome.text!,
            "CPF": txtCPF.text!,
            "CEP": txtCEP.text!,
            "idUsuario": idUsuario
        ]) { err in
            if let err = err {
                print("LOG - ERRO AO CADASTRAR USUARIO: \(err)")
                usuarioCadastrado = false
            } else {
                print("LOG - USUARIO CADASTRADO COM SUCESSO: \(ref!.documentID)")
            }
        }
    
        return usuarioCadastrado
    }
    
    func ExcluirUsuario() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("LOG - ERRO AO EXCLUIR USUARIO: \(error)")
            } else {
                print("LOG - USUARIO EXCLUIDO COM SUCESSO")
            }
        }
    }
}

