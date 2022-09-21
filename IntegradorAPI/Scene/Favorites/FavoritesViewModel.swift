//
//  FavoritesViewModel.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

struct FavoritesViewModel {
    func loadFavorites(handler: @escaping ([ResultWrapper]) -> Void) {
        let api = SearchAPI.shared
        let favorites = FavoritesRepository().getFavorites()
        var resultado = [ResultWrapper]()
        for item in 0..<favorites.count {
            let prodBasic = ProductBasicContent(id: favorites[item].0, position: 0, type: favorites[item].1)
            api.getProductsDetails(product: prodBasic,
                                   onError: { error in
                                       print(error)
                if item == favorites.count-1 { handler(resultado) }
                                   },
                                    onSuccess: { productDetail in
                resultado.append(productDetail)
                if item == favorites.count-1 {
                    handler(resultado) }
            })
        }
    }
}
