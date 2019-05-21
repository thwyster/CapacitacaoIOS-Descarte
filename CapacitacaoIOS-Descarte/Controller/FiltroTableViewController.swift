import UIKit
import Firebase

class FiltroTableViewController: UITableViewController {


    
    var listaTiposDescarte = [TipoDescarteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        
        CarregarTiposDescarte()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        CarregarTiposDescarte()
        print("QTD TIPOS DESCARTE \(self.listaTiposDescarte.count)")
        return self.listaTiposDescarte.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDescarte", for: indexPath)
        let item = self.listaTiposDescarte[indexPath.row]
        
        cell.textLabel?.text = item.Descricao
//        cell.selectionStyle = .blue
        
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
                    
                    print("QTD TIPOS DESCARTE \(tipoDescarte.Descricao)")
                    self.listaTiposDescarte.append(tipoDescarte)
                }
            }
            
//            self.tableView.dataSource = self.listaTiposDescarte as? UITableViewDataSource
//            self.tableView.allowsMultipleSelection = true
            self.tableView.reloadData()
        }
    }
    
    func VinculaListaTiposDescarteAoFiltro() -> [String]{
        //Seleciona as linhas selecioinadas da Tableview
        let lista = tableView.indexPathsForSelectedRows
        var listaIds : [String] = []
        
        if(lista != nil)
        {
            for l in lista! {
                listaIds.append(listaTiposDescarte[l.row].idTipoDescarte)
            }
        }
        else{
            print("LOG - ERRO NENHUM FILTRO FOI SELECIONADO")
        }

        return listaIds
    }

    @IBAction func btnFiltrar(_ sender: Any) {
        var listaIds = VinculaListaTiposDescarteAoFiltro()
        print(listaIds.count)
        
        if  listaIds.count > 0
        {
            self.performSegue(withIdentifier: "segueParaColetores", sender: nil)
        }
    }
}
