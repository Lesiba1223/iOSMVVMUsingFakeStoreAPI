//
//  webserverice.swift
//  MVVMFakeStorePractice
//
//  Created by DA MAC M1 139 on 2023/06/05.
//

import Foundation
struct Webservice {
    func getProducts(url: URL, completion: @escaping ([Product]?) -> Void) {
        URLSession.shared.dataTask(with: url) { data,response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                    print(data)
                let products = try? JSONDecoder().decode(Products.self, from: data).products
                if let products = products{
                    print(products)
                    completion(products)
                }
                }
        }.resume()
        }
    }
