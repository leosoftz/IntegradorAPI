

import Foundation

class FavoritesRepository {
    func addFavorite(item: String, type: ProductTypeEnum) {
        let localStorage = LocalStoreFavorites()
        localStorage.save(value: [item, type.rawValue])
    }
    
    func getFavorites() -> [(String, ProductTypeEnum)] {
        let localStorage = LocalStoreFavorites()
        let favorites = localStorage.getFavorites()
        var results: [(String, ProductTypeEnum)] = []
        for result in favorites {
            let currFav = (result[0], ProductTypeEnum(rawValue: result[1])!)
            results.append(currFav)
        }
        return results
    }
    
    func containsFavorite(_ itemID: String) -> Bool {
        let localStorage = LocalStoreFavorites()
        return localStorage.getFavorites().contains(where: { $0[0] == itemID })
        
    }
    
    func removeFavorite(_ itemID: String) {
        let localStorage = LocalStoreFavorites()
        localStorage.remove(value: itemID)
    }
}

