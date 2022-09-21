//
//  SearchAPI.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//


import Alamofire

public class SearchAPI {
    static var shared: SearchAPI = SearchAPI()
    
    func getToken(onError: @escaping () -> Void, onSuccess: @escaping () -> Void) {
        let session = MeliApiManager.shared.sessionManager
        let url = URL(string: "https://api.mercadolibre.com/oauth/token")
        let parameters = ["grant_type": "refresh_token",
                          "client_id": "3524304451412303",
                          "client_secret": "iwGODit1BJe6vxD88Fw0Pjbwz3ojuZvi",
                          "refresh_token": "TG-6329f643c1626f0001143a4c-110521798"]
        session.request(url!,
                        method: .post,
                        parameters: parameters,
                        encoding: URLEncoding.queryString)
            .response(completionHandler: { response in
                guard let data = response.data else {
                    return
                }
                guard let accessToken = try? JSONDecoder().decode(AuthToken.self, from: data) else {
                    onError()
                    return
                }
                UserDefaults.standard.set(accessToken.accessToken, forKey: "token")
                UserDefaults.standard.synchronize()
                onSuccess()
            })
    }
    
    func getCategories(query: String, onError: @escaping (String) -> Void, onSuccess: @escaping (Category) -> Void) {
        let session = MeliApiManager.shared.sessionManager
        let urlString = "https://api.mercadolibre.com/sites/MLA/domain_discovery/search?q=\(query)".replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: urlString) else {
            onError("No ingresar caracteres especiales")
            return
        }
        session.request(url,
                        method: .get,
                        encoding: URLEncoding.queryString)
            .response(completionHandler: { response in
                guard let data = response.data else {
                    return
                }
                do {
                    let categoriesData = try JSONDecoder().decode(Category.self, from: data)
                    if categoriesData.isEmpty {
                        onError("No data.")
                        return
                    }
                    onSuccess(categoriesData)
                } catch {
                    print(error)
                    onError("error")
                }
            })
    }
    
    func getProducts(category: String,
                     onError: @escaping (String) -> Void,
                     onSuccess: @escaping (ProductBasic) -> Void) {
        let session = MeliApiManager.shared.sessionManager
        let url = URL(string: "https://api.mercadolibre.com/highlights/MLA/category/\(category)")
        session.request(url!,
                        method: .get,
                        encoding: URLEncoding.queryString)
            .response(completionHandler: { response in
                guard let data = response.data else {
                    return
                }
                do {
                    let str = String(data: data, encoding: .utf8)
                    print(str)
                    let prodData = try JSONDecoder().decode(ProductBasic.self, from: data)
                    onSuccess(prodData)
                } catch {
                    print(error)
                    onError("Error items")
                }
            })
    }
    
    func getTypeURL(type: ProductTypeEnum) -> String {
        switch type {
        case .product:
            return "products"
        case .item:
            return "items"
        }
    }
    
    func getProductsDetails(product: ProductBasicContent,
                            onError: @escaping (String) -> Void,
                            onSuccess: @escaping (ResultWrapper) -> Void) {
        
        let session = MeliApiManager.shared.sessionManager
        let typeURL = getTypeURL(type: product.type)
        let urlString = "https://api.mercadolibre.com/\(typeURL)/\(product.id)"
        let url = URL(string: urlString)
        session.request(url!,
                        method: .get,
                        encoding: URLEncoding.queryString)
            .response(completionHandler: { response in
                guard let data = response.data else {
                    return
                }
                do {
                    switch product.type {
                    case .item:
                        let prodData = try JSONDecoder().decode(ItemDetail.self, from: data)
                        onSuccess(ResultWrapper(prodData))
                    case .product:
                        let prodData = try JSONDecoder().decode(ProductDetail.self, from: data)
                        onSuccess(ResultWrapper(prodData))
                    }
                } catch {
                    print("ERROR ITEM \(product.id)")
                        print(error)
                }
            }
        )
    }
}

