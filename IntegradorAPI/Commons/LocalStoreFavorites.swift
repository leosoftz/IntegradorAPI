
import UIKit

class LocalStoreFavorites: NSObject {
    static let item = "item"
    func save(value: [String]) {
        let favorites = UserDefaults.standard.value(forKey: LocalStoreFavorites.item) ?? []
        var favoriteItems = favorites as? [[String]]
        if favoriteItems!.contains(where: {$0[0] == value[0]}) { return }
        favoriteItems!.append(value)
        UserDefaults.standard.set(favoriteItems!, forKey: LocalStoreFavorites.item)
        UserDefaults.standard.synchronize()
    }
    func getFavorites() -> [[String]] {
        let favorites = UserDefaults.standard.value(forKey: LocalStoreFavorites.item) ?? []
        let favoriteItems = favorites as? [[String]]
        return favoriteItems!
    }
    
    func remove(value: String) {
        let favorites = UserDefaults.standard.value(forKey: LocalStoreFavorites.item) ?? []
        var favoriteItems = favorites as? [[String]]
        favoriteItems!.removeAll { $0[0] == value }
        UserDefaults.standard.set(favoriteItems!, forKey: LocalStoreFavorites.item)
        UserDefaults.standard.synchronize()
    }
}

