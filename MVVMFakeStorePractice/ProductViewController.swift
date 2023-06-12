//
//  ViewController.swift
//  MVVMFakeStorePractice
//
//  Created by DA MAC M1 139 on 2023/06/05.
//

import UIKit

class ProductViewController: UIViewController {
    
    private var productsVM: ProductsViewModel!

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        setup()
        
    }
    func setup() {
        guard let url = URL(string:"https://fakestoreapi.com/products") else
        {
            return
        }
        
        Webservice().getProducts(url: url) { products in
            
            if let products = products {
                self.productsVM = ProductsViewModel(products: products)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
extension ProductViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return productsVM == nil ? 0 : self.productsVM.numberOfSections
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsVM.numberOfRowsInSection(section)
        //return productsVM.products.count
    }    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
        
        let productsVM = self.productsVM.productAtIndex(indexPath.row)
        cell.productImageView.image = UIImage(named: String(productsVM.image))
        cell.productNameLbl.text = productsVM.title
        return cell
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 300)
    }
}


