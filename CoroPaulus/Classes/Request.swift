//
//  Request.swift
//  Pods
//
//  Created by Riccardo Crippa on 8/30/17.
//
//

import Foundation

struct Request {
    struct Method {
        static let GET = "GET"
    }
    static let SONGS = "request.php"
    static let BACKEND = "http://coropaulus.altervista.org/"
}
struct Song {
    static let NOME = "nome"
    static let URL = "url"
}

public class CoroRequest {
    
    private var _backend: String
    
    public var backend: String {
        return _backend
    }
    
    public init() {
        self._backend = Request.BACKEND
    }
    
    public init(backend: String) {
        self._backend = backend
    }
    
    // GET /request.php
    public func fetchCanti(handler: @escaping ([Canto]) -> Void){
        makeRequest(Request.SONGS, usingMethod: Request.Method.GET, withParameters: nil) { (response) in
            var canti = [Canto]()
            do {
                let json = try JSONSerialization.jsonObject(with: response.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String : Any]]
                for i in 0..<json!.count {
                    let nome = json?[i][Song.NOME] as? String
                    let url = json?[i][Song.URL] as? String
                    let canto = Canto(nome: nome!, url: url!)
                    canti.append(canto)
                }
            } catch {
                canti.removeAll()
            }
            handler(canti)
        }
    }
    
    private func makeRequest(_ request: String, usingMethod method: String, withParameters parameters: String?, completionHandler handler: @escaping (String) -> Void){
        fetch(request: request, method: method, parameters: parameters, handler: handler)
    }
    
    private func fetch(request: String, method: String, parameters: String?, handler: @escaping (String) -> Void) {
        let url = URL(string: "\(backend)\(request)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method
        urlRequest.httpBody = parameters?.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let data = data, error == nil else {
                print("error: \(String(describing: error))")
                return
            }
            do {
                let _ = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            } catch {
                print("error: \(error)")
            }
            let response = String(data: data, encoding: .utf8)
            handler(response!)
        }
        task.resume()
    }
}
