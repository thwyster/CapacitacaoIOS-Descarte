//
//  CadastroColetorViewController.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 24/04/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import Firebase

class CadastroColetorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Variaveis de Tela
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCPFCNPJ: UITextField!
    @IBOutlet weak var txtCEP: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmacaoSenha: UITextField!
    @IBOutlet weak var tvTiposDescarte: UITableView!
    
    var listaTiposDescarte = [TipoDescarteModel]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CarregarTiposDescarte()
//        tvTiposDescarte.dataSource = self
//        tvTiposDescarte.delegate = self
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
            && txtCPFCNPJ.text != ""
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
            guard (result?.user) != nil
                else
            {
                print("LOG - LOGIN DEU RUIM")
                print(error!)
                return
            }
            
            //Caso o cadastro da Colecao Usuario de errado já exclui o usuario cadastrado.
            if !self.CadastrarUsuarioCompleto() {
                self.ExcluirUsuario()
            }
        }
    }
    
    func CadastrarUsuarioCompleto() -> Bool {
        let db = Firestore.firestore()
        var usuarioCadastrado = true;
    
        db.collection("usuario").document((Auth.auth().currentUser?.uid)!).setData([
            "Nome": txtNome.text!,
            "CPFCNPJ": txtCPFCNPJ.text!,
            "CEP": txtCEP.text!,
            "Telefone": txtTelefone.text!,
            "ListaTiposDescarte": VinculaListaTiposDescarteAoColetor(),
            "TiposUsuario": "7IysAwgkSF4WC1F39I2y"
        ]) { err in
            if let err = err {
                print("LOG - ERRO AO CADASTRAR COLETOR: \(err)")
                usuarioCadastrado = false
            } else {
                print("LOG - COLETOR CADASTRADO COM SUCESSO")
                self.performSegue(withIdentifier: "segueParaLoginColetor", sender: nil)
            }
        }
        
        return usuarioCadastrado
    }
    
    func ExcluirUsuario() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("LOG - ERRO AO EXCLUIR COLETOR: \(error)")
            } else {
                print("LOG - COLETOR EXCLUIDO COM SUCESSO")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTiposDescarte.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvTiposDescarte.dequeueReusableCell(withIdentifier: "ItemDescarte", for: indexPath)
        let item = listaTiposDescarte[indexPath.row]
        
        cell.textLabel?.text = item.Descricao
        cell.selectionStyle = .blue 
        
        
        //Verificar a cell para trazer ela marcada
        //        if (true){
        //            cell.accessoryType = .checkmark
        //            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.bottom)
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
    }

    //Desenha os checkmark mas da BUG!
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        if let cell = tableView.cellForRow(at: indexPath) {
    //            cell.accessoryType = .none
    //
    //        }
    //    }
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if let cell = tableView.cellForRow(at: indexPath) {
    //            cell.accessoryType = .checkmark
    //
    //
    //        }
    //    }
    
    func CarregarTiposDescarte(){
        let db = Firestore.firestore()
        
        db.collection("tiposDescarte").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("LOG - ERRO AO CARREGAR TIPOS DESCARTE: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let tipoDescarte = TipoDescarteModel()
                    tipoDescarte.idTipoDescarte = document.documentID
                    tipoDescarte.Descricao = document.data()["Descricao"] as! String
                    
                    self.listaTiposDescarte.append(tipoDescarte)
                }
            }
            
            self.tvTiposDescarte.dataSource = self.listaTiposDescarte as? UITableViewDataSource
            self.tvTiposDescarte.reloadData()
            
            self.tvTiposDescarte.dataSource = self
            self.tvTiposDescarte.delegate = self
            self.tvTiposDescarte.allowsMultipleSelection = true
        }
    }
    
    func VinculaListaTiposDescarteAoColetor() -> [String]{
        //Seleciona as linhas selecioinadas da Tableview
        let lista = tvTiposDescarte.indexPathsForSelectedRows
        var listaIds : [String] = []
        
        for l in lista! {
            listaIds.append(listaTiposDescarte[l.row].idTipoDescarte)
        }
        
        return listaIds
    }
}

//tvTiposDescarte.indexPathsForSelectedRows //serve para pegar todas as linhas selecionadas

