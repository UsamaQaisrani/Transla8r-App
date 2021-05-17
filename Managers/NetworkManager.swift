//
//  NetworkManager.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation
import Moya

class NetworkManager {
    
    //MARK:- Class Properties
    static let shared = NetworkManager()
    let dataProvider = MoyaProvider<MoyaServices>()
}

//MARK:- Class Methods
extension NetworkManager {
    
    func fetchData<T: Codable>(method: MoyaServices, completion: @escaping (Result<T,Swift.Error>)->Void){
        dataProvider.request(method) { (result) in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(decodedData))
                }
                catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
