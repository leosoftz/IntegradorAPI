//
//  Coordinator.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

protocol Coordinator {
    func start()
    var navigation: UINavigationController { get }
}

