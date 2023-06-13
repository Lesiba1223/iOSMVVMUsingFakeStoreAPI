//
//  ProductCollectionViewCell.swift
//  MVVMFakeStorePractice
//
//  Created by DA MAC M1 139 on 2023/06/05.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    func imageSetup(with product: Product){
        productNameLbl.text = product.title
        productImageView.image = UIImage(named: product.image
        )
    }
}
