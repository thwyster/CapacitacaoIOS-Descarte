import UIKit
import Firebase

class ColetorDetalhesViewController: UIViewController {
    @IBOutlet weak var lblNomeColetor: UILabel!
    @IBOutlet weak var lblTiposDescarte: UILabel!
    @IBOutlet weak var lblRegiao: UILabel!
    @IBOutlet weak var lblTelefone: UILabel!
    
    var idColetor : String = ""
    var coletor = ColetorModel()
    
    
    override func viewDidLoad() {
        CarregarColetor(idColetor)
        super.viewDidLoad()
    }
    
    func CarregarColetor(_ idColetor : String){
        CarregarTiposDescarte()
        lblNomeColetor.text = coletor.Nome
        lblRegiao.text = coletor.CEP
        lblTelefone.text = coletor.Telefone
    }
    
    func CarregarTiposDescarte(){//_ listaIDsTipoDescarte : [String]) -> String {
        let db = Firestore.firestore()
        var tiposDescarte : String = ""
        
        db.collection("tiposDescarte").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("LOG - ERRO AO CARREGAR TIPOS DESCARTE: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if self.coletor.ListaTiposDescarte.contains(document.documentID){
                        if tiposDescarte.isEmpty{
                            tiposDescarte += document.data()["Descricao"] as! String
                        }
                        else{
                            tiposDescarte += ", \(document.data()["Descricao"] as! String)"
                        }
                        
                    }
                }
                self.lblTiposDescarte.text = tiposDescarte
            }
        }
//        return tiposDescarte
    }
}
