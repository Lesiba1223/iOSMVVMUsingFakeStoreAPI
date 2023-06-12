//
//  ProductViewModel.swift
//  MVVMFakeStorePractice
//
//  Created by DA MAC M1 139 on 2023/06/05.
//

import Foundation

struct ProductViewModel{
    private let product: Product
    init(_ product: Product){
        self.product = product
    }
    
}
extension ProductViewModel{
    var title: String {
        return self.product.title
    }
    var price: Double{
        return self.product.price
    }
    var image: String{
        return self.product.image
    }
    
}
