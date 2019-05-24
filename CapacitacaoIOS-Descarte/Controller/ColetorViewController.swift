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
    var listaColetoresFiltrados = [ColetorModel]()

    var coletor = ColetorModel()
    var filtrosAtivos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CarregarColetores()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaColetoresFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemColetor", for: indexPath)
        let item = self.listaColetoresFiltrados[indexPath.row]
        
        cell.textLabel?.text = item.Nome
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICOU NA CELL \(indexPath.row)")
        coletor = listaColetoresFiltrados[indexPath.row]
        self.performSegue(withIdentifier: "segueParaColetorDetalhes", sender: nil)
    }
    
    func CarregarColetores(){
        let db = Firestore.firestore()
        
        db.collection("usuario")
        .whereField("TiposUsuario", isEqualTo: "7IysAwgkSF4WC1F39I2y")
        //.whereField("ListaTiposDescarte", arrayContains: "2ofT9qSPOGxNf0a3tCUX")
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("LOG - ERRO AO CARREGAR COLETORES: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var itemColetor = ColetorModel()
                    
                    print("DEU BOA")
                    print("\(document.documentID) => \(document.data())")
                    
                    itemColetor.idColetor = document.documentID
                    itemColetor.CPFCNPJ = document.data()["CPFCNPJ"] as! String
                    itemColetor.Nome = document.data()["Nome"] as! String
                    itemColetor.Telefone = document.data()["Telefone"] as! String
                    itemColetor.TiposUsuario = document.data()["TiposUsuario"] as! String
                    itemColetor.CEP = document.data()["CEP"] as! String
                    itemColetor.ListaTiposDescarte = document.data()["ListaTiposDescarte"] as! [String]
                    
                    self.listaColetores.append(itemColetor)
                }
                
                self.FiltrarColetores(self.filtrosAtivos)
            }
            
            self.tableview.dataSource = self.listaColetores as? UITableViewDataSource
            self.tableview.reloadData()
            
            self.tableview.dataSource = self
            self.tableview.delegate = self
        }
        
        print("PASSEI AQUI")
    }
    
    func FiltrarColetores(_ filtrosAtivos : [String]){
        for coletor in self.listaColetores {
            var possuiTodosFiltros : Bool = true
            
            for filtro in self.filtrosAtivos {
                if (!coletor.ListaTiposDescarte.contains(filtro)){
                    possuiTodosFiltros = false
                }
            }
            if (possuiTodosFiltros){
                listaColetoresFiltrados.append(coletor)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueParaColetorDetalhes") {
            let secondViewController = segue.destination as! ColetorDetalhesViewController
            secondViewController.coletor = coletor
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
