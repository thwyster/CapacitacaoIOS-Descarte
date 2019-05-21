//
//  ColetorModel.swift
//  CapacitacaoIOS-Descarte
//
//  Created by ALUNO on 20/05/19.
//  Copyright © 2019 Aluno. All rights reserved.
//

import Foundation

class ColetorModel {
    var idColetor : String
    var CPFCNPJ : String
    var Nome : String
    var Telefone : String
    var TiposUsuario : String
    var CEP : String
    var ListaTiposDescarte : [String]
    
    init() {
        self.idColetor = ""
        self.CPFCNPJ = ""
        self.Nome = ""
        self.Telefone = ""
        self.TiposUsuario = ""
        self.CEP = ""
        self.ListaTiposDescarte = [""]
    }
}
