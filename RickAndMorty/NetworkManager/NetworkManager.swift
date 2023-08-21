//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Sergey Kykhov on 19.08.2023.
//

import Foundation
import UIKit

final class NetworkManager {
        
    static let shared = NetworkManager()
    
    //MARK: - Methods URLSession
    func makeRequst<T:Decodable>(url: String, params: String, complition: @escaping (T) -> Void) {
        guard let completeUrl = URL(string: url + params) else {
            fatalError("ERROR")
        }
        var request = URLRequest(url: completeUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let characters = try JSONDecoder().decode(T.self, from: data)
                print("OK")
                complition(characters)
            } catch {
                print("Error decoding: \(error)")
            }
        }
        task.resume()
    }
}
