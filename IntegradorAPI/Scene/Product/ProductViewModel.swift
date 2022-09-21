//
//  ProductViewModel.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

protocol ProductViewModelDelegate {
    func showSuccess(message: String)
}

struct ProductViewModel {
    let delegate: ProductViewModelDelegate?
    
    func pressFavorite(item: ResultWrapper) {
        let repository = FavoritesRepository()
        let itemID = item.id
        if repository.containsFavorite(itemID) {
            repository.removeFavorite(itemID)
            delegate?.showSuccess(message: "Eliminado de favoritos.")
        } else {
            repository.addFavorite(item: itemID, type: item.type)
            delegate?.showSuccess(message: "Agregado a favoritos.")
        }
    }
}
