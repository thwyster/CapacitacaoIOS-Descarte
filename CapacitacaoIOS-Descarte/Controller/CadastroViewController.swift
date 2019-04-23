//
//  CadastroViewController.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 12/04/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import Firebase

class CadastroViewController: UIViewController {

    //Variaveis dos Containers
    @IBOutlet weak var containerViewColetor: UIView!
    @IBOutlet weak var containerViewUsuario: UIView!
    
    let db = Firestore.firestore()
    
    //Dados Usuario
    //    @IBOutlet weak var txtNomeUsuario: UITextField!
    //    @IBOutlet weak var txtCPFUsuario: UITextField!
    //    @IBOutlet weak var txtCEPUsuario: UITextField!
    
    //Dados Coletor
    //@IBOutlet weak var txtNomeColetor: UITextField!
    //@IBOutlet weak var txtCPFCNPJColetor: UITextField!
    //@IBOutlet weak var txtCEPColetor: UITextField!
    //@IBOutlet weak var txtTelefoneColetor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerViewUsuario.alpha = 1

        self.containerViewColetor.alpha = 0
        
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.title = "Usuario"
                self.containerViewUsuario.alpha = 1
                self.containerViewColetor.alpha = 0
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.title = "Coletor"
                self.containerViewUsuario.alpha = 0
                self.containerViewColetor.alpha = 1
            })
        }
    }
}
