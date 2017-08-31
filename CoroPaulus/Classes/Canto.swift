//
//  Canto.swift
//  Pods
//
//  Created by Riccardo Crippa on 8/30/17.
//
//

import Foundation

public class Canto: CustomStringConvertible {
    
    public var description: String {
        return "Canto={nome=\(self.nome), url=\(self.url)}"
    }
    
    private var _nome: String
    private var _url: String
    
    public init(nome: String, url: String) {
        self._nome = nome
        self._url = url
    }
    
    public var nome: String {
        return self._nome
    }
    
    public var url: String {
        return self._url
    }
}
