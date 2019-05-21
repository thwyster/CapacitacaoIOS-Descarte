import UIKit
import Firebase

class CadastroUsuarioViewController: UIViewController {

    //Variáveis de Tela
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCPF: UITextField!
    @IBOutlet weak var txtCEP: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmacaoSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        if (ValidaCamposPreenchidos()) {
            if (ValidaSenha()) {
                CriarLogin()
            }
        }
    }
    
    //TODO - FUNCOES UTEIS, JOGAR ELAS PRA UMA BASE DEPOIS
    func ValidaCamposPreenchidos() -> Bool {
        if (txtNome.text != ""
            && txtCPF.text != ""
            && txtCEP.text != ""
            && txtEmail.text != ""
            && txtSenha.text != ""
            && txtConfirmacaoSenha.text != "")
        {
            return true
        }
        else {
            print("PREENCHA TODOS OS CAMPOS")
            return false
        }
    }
    
    func ValidaSenha() -> Bool {
        if (txtSenha.text! == txtConfirmacaoSenha.text!) {
            return true
        }
        else {
            return false
        }
    }
    
    func CriarLogin() {
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtSenha.text!) { (result, error) in
            guard (result?.user) != nil
                else
            {
                print("LOG - LOGIN DEU RUIM")
                print(error!)
                return
            }
            
            //Caso o cadastro da Colecao Usuario de errado já exclui o usuario cadastrado.
            if !self.CadastrarUsuarioCompleto() {
                self.ExcluirUsuario()
            }
        }
    }
    
    func CadastrarUsuarioCompleto() -> Bool {
        let db = Firestore.firestore()
        var usuarioCadastrado = true;
        
        db.collection("usuario").document((Auth.auth().currentUser?.uid)!).setData([
            "Nome": txtNome.text!,
            "CPF": txtCPF.text!,
            "CEP": txtCEP.text!,
            "idUsuario": Auth.auth().currentUser?.uid as Any,
            "tiposUsuario": "9ceRJCZKur3TLr9mGqmW"
        ]){ err in
            if let err = err {
                print("LOG - ERRO AO CADASTRAR USUARIO: \(err)")
                usuarioCadastrado = false
            } else {
                print("LOG - USUARIO CADASTRADO COM SUCESSO:")
                self.performSegue(withIdentifier: "segueParaLoginUsuario", sender: nil)
            }
        }
        return usuarioCadastrado
    }
    
    func ExcluirUsuario() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("LOG - ERRO AO EXCLUIR USUARIO: \(error)")
            } else {
                print("LOG - USUARIO EXCLUIDO COM SUCESSO")
            }
        }
    }
}

