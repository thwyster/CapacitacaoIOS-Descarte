//
//  CadastroViewController.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 12/04/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import UIKit
import Firebase

class CadastroViewController: UIViewController {

    @IBOutlet weak var containerViewColetor: UIView!
    @IBOutlet weak var containerViewUsuario: UIView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerViewUsuario.alpha = 1

        self.containerViewColetor.alpha = 0
        
    }
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.title = "Usuario"
                self.containerViewUsuario.alpha = 1
                self.containerViewColetor.alpha = 0
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.title = "Coletor"
                self.containerViewUsuario.alpha = 0
                self.containerViewColetor.alpha = 1
            })
        }
    }
}
