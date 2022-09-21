//
//  HomeCoordinator.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController()
        self.navigation.pushViewController(homeVC, animated: true)
    }
}
