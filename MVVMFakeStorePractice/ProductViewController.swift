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
                    print("Success")
                    self.collectionView.reloadData()
//                    self.collectionView.setNeedsLayout()
                }
            }
        }
    }
}

extension ProductViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return productsVM == nil ? 0 : self.productsVM.numberOfSections
        //return productsVM.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsVM.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
        
        let productsVM = self.productsVM.productAtIndex(indexPath.row)
        
        print(indexPath.row)
        
        let imageURL = self.productsVM.productAtIndex(indexPath.row).image as? String
        print(String(describing: imageURL!.description))
        
        if let url = URL(string: imageURL!){
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    // Convert the downloaded data into a UIImage
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        // Update the UIImageView in the collection view cell with the downloaded image
                        cell.productImageView.image = image
                        cell.setNeedsLayout() // Ensure the image view is updated
                    }
                }
            }.resume()
        }
        
        cell.productNameLbl.text = productsVM.title
        cell.productImageView.image = UIImage(named: self.productsVM.productAtIndex(indexPath.row).image)
        cell.productPriceLbl.text = "R " + String(productsVM.price)
        //cell.productImageView.image = UIImage(named: productsVM.image)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.setNeedsLayout()
        cell.reloadInputViews()
        return cell
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 300)
    }
}

//MARK: Extension from StackOverFlow
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

