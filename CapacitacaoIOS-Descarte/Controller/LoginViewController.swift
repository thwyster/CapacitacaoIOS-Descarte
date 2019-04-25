import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmacaoSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        if (txtSenha.text! == txtConfirmacaoSenha.text!) {
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtSenha.text!) { (result, error) in
                guard (result?.user) != nil
                else
                {
                    print(error!)
                    return
                }
                
                print("LOGIN DEU BOA")
            }
        }
        else {
            print("LOGIN DEU RUIM!!!")
        }
    }
}
