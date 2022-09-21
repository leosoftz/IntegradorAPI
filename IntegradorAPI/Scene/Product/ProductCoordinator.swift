//
//  ProductCoordinator.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

class ProductCoordinator: Coordinator {
    var navigation: UINavigationController
    var product: ResultWrapper
    
    init(navigationController: UINavigationController, product: ResultWrapper) {
        navigation = navigationController
        self.product = product
    }
    
    func start() {
        let productVC = ProductViewController()
        navigation.pushViewController(productVC, animated: true)
        productVC.product = self.product
    }
}
