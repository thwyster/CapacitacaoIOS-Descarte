import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnEntrar(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtSenha.text!) { (result, error) in
            
            guard (result?.user) != nil
                else {
                    print("LOG - LOGIN DEU RUIM:  \(error!)")
                    return
            }
            
            print("LOG - LOGIN EFETUADO COM SUCESSO")
            
            self.performSegue(withIdentifier: "segueParaFiltros", sender: nil)
            
        }
    }
}

