import UIKit
import Firebase

class ColetorDetalhesViewController: UIViewController {

    var idColetor : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func CarregarColetor(_ idColetor : String){
        let db = Firestore.firestore()
        
        db.collection("usuario").getDocuments(completion: <#T##FIRQuerySnapshotBlock##FIRQuerySnapshotBlock##(QuerySnapshot?, Error?) -> Void#>) { (querySnapshot, err) in
            if let err = err {
                print("LOG - ERRO AO CARREGAR TIPOS DESCARTE: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let tipoDescarte = TipoDescarteModel()
                    tipoDescarte.idTipoDescarte = document.documentID
                    tipoDescarte.Descricao = document.data()["Descricao"] as! String
                }
            }
        }
    }
}
