import UIKit
import Firebase

class FiltroColetorViewController: UITableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        CarregarColetoresPorTipoDescarte(["teste"])
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
    
    func CarregarColetoresPorTipoDescarte(_ listaTiposDescarte:[String]){
        let db = Firestore.firestore()
        
        db.collection("usuarios").whereField("TiposUsuario", isEqualTo: "7IysAwgkSF4WC1F39I2y")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("LOG - ERRO AO CARREGAR COLETORES: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }

        
//        db.collection("tiposDescarte").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("LOG - ERRO AO CARREGAR TIPOS DESCARTE: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    let tipoDescarte = TipoDescarteModel()
//                    tipoDescarte.idTipoDescarte = document.documentID
//                    tipoDescarte.Descricao = document.data()["Descricao"] as! String
//
//                    self.listaTiposDescarte.append(tipoDescarte)
//                }
//            }
//
//            self.tvTiposDescarte.dataSource = self.listaTiposDescarte as? UITableViewDataSource
//            self.tvTiposDescarte.reloadData()
//
//            self.tvTiposDescarte.dataSource = self
//            self.tvTiposDescarte.delegate = self
//            self.tvTiposDescarte.allowsMultipleSelection = true
//        }
    }
}
