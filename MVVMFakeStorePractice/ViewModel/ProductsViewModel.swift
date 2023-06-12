//
//  ProductsViewModel.swift
//  MVVMFakeStorePractice
//
//  Created by DA MAC M1 139 on 2023/06/05.
//

import Foundation

struct ProductsViewModel{
    let products: [Product]
    
    var numberOfSections: Int{
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        return products.count
    }
    func productAtIndex(_ index: Int) -> ProductViewModel {
        let product = self.products[index]
        return ProductViewModel(product)
    }
    
}
