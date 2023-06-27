//
//  NetworkData.swift
//  SWG
//
//  Created by Максим Сулим on 27.06.2023.
//

import Foundation


class NetworkData {
    
    static let shared = NetworkData()
    
    private init() {}
    
    
    func workData(urlString: String, responce: @escaping (Results?, Error?) -> Void) {
        
        NetworkRequest.shared.requestITunes(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(Results.self, from: data)
                    responce(resultData,nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
        
    }
    
}
