//
//  ProductViewController.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

import UIKit
import AndesUI

class ProductViewController: UIViewController, ProductViewModelDelegate {
    
    @IBOutlet weak var lblSoldCondition: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnBuy: AndesButton!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var imgTest: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    
    var product: ResultWrapper!
    var viewModel: ProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnBack()
        setupBtnFavorite()
        self.viewModel = ProductViewModel(delegate: self)
        setupProduct()
        setupLblStock()
        setupBtnBuy()
        setupBar()
    }
    
    func setupLblStock() {
        lblStock.text = "Stock disponible"
    }
    
    func setupBtnBuy() {
        btnBuy.text = "Comprar ahora"
        btnBuy.hierarchy = .loud
    }
    
    func setupBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupProduct() {
        do {
            let url = URL(string: self.product!.picturesURL.first!!)
            let data = try Data(contentsOf: url!)
            self.imgTest.image = UIImage(data: data)
        } catch {
            print(error)
        }
        lblProduct.text = product?.title
        if let price = self.product?.price {
            lblPrice.text = "$ \(price)"
        }
        if let condition = self.product?.condition {
            lblSoldCondition.text = "\(condition.capitalized) | \(self.product!.soldQuantity) vendidos"
        }
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFavorite(_ sender: Any) {
        self.viewModel.pressFavorite(item: self.product!)
    }
    
    func setupBtnBack() {
        let imageBack = UIImage(named: "andes_ui_arrow_left_20", in: AndesBundle.bundle(), with: nil)
        btnBack.setImage(imageBack, for: .normal)
        btnBack.tintColor = .black
    }

    func setupBtnFavorite() {
        let imageBack = UIImage(named: "andes_navegacion_favoritos_24", in: AndesBundle.bundle(), with: nil)
        btnFavorite.setImage(imageBack, for: .normal)
        btnFavorite.tintColor = .black
        let imageSelected = UIImage(named: "andes_ui_arrow_left_24", in: AndesBundle.bundle(), with: nil)
        btnFavorite.setImage(imageSelected, for: .selected)
    }

    func showSuccess(message: String) {
        let bar = AndesSnackbar(text: message, duration: .short, type: .success)
        bar.show()
    }
}
