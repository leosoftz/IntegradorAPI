//
//  FavoritesCoordinator.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var navigation: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigation = navigationController
    }
    
    func start() {
        let favoritesVC = FavoritesViewController()
        navigation.pushViewController(favoritesVC, animated: true)
    }
}
