//
//  ColetorViewController.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 20/05/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import Firebase

class ColetorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    var listaColetores = [ColetorModel]()
    var itemColetor = ColetorModel()
    var idColetor : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CarregarColetoresPorFiltro()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaColetores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemColetor", for: indexPath)
        let item = self.listaColetores[indexPath.row]
        
        cell.textLabel?.text = item.Nome
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICOU NA CELL \(indexPath.row)")
        idColetor = listaColetores[indexPath.row].idColetor
        self.performSegue(withIdentifier: "segueParaColetorDetalhes", sender: nil)
    }
    
    func CarregarColetoresPorFiltro(){
        let db = Firestore.firestore()
        
        db.collection("usuario")
        .whereField("TiposUsuario", isEqualTo: "7IysAwgkSF4WC1F39I2y")
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("LOG - ERRO AO CARREGAR COLETORES: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("DEU BOA")
                    print("\(document.documentID) => \(document.data())")
                    
                    self.itemColetor.idColetor = document.documentID
                    self.itemColetor.CPFCNPJ = document.data()["CPFCNPJ"] as! String
                    self.itemColetor.Nome = document.data()["Nome"] as! String
                    self.itemColetor.Telefone = document.data()["Telefone"] as! String
                    self.itemColetor.TiposUsuario = document.data()["TiposUsuario"] as! String
                    self.itemColetor.CEP = document.data()["CEP"] as! String
                    
                    self.listaColetores.append(self.itemColetor)
                    
                    print("QTD COLETORES -> \(self.listaColetores.count)")
                }
            }
            
            self.tableview.dataSource = self.listaColetores as? UITableViewDataSource
            self.tableview.reloadData()
            
            self.tableview.dataSource = self
            self.tableview.delegate = self
        }
        
        print("PASSEI AQUI")
    }
    
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "segueParaColetorDetalhes") {
            let secondViewController = segue.destination as! ColetorDetalhesViewController
            let idColetor = sender as! String
            secondViewController.idColetor = idColetor
        }
    }
    
//    func VinculaColetorAColetorDetalhes() -> [String]{
//        let lista = tableview.indexPathsForSelectedRows
//        var listaIds : [String] = []
//
//        for l in lista! {
//            listaIds.append(listaTiposDescarte[l.row].idTipoDescarte)
//        }
//
//        return listaIds
//    }
    
}
