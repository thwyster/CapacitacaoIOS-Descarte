import UIKit
import Firebase

class FiltrosTableViewController: UITableViewController {
    var listaTiposDescarte = [TipoDescarteModel]()

    override func viewDidLoad() {
        CarregarTiposDescarte()
        
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTiposDescarte.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDescarte", for: indexPath)
        let item = listaTiposDescarte[indexPath.row]
        
        cell.textLabel?.text = item.Descricao
        cell.selectionStyle = .blue
        
        return cell
    }
    
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
            
            self.tableView.dataSource = self.listaTiposDescarte as? UITableViewDataSource
            self.tableView.allowsMultipleSelection = true
            self.tableView.reloadData()
        }
    }
}
