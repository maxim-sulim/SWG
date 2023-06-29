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
    
    
    func workDataITunes(urlString: String, responce: @escaping (ResultsITunes?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(ResultsITunes.self, from: data)
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
    
    func workDataGitUsers(urlString: String, responce: @escaping (ResultsGit?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(ResultsGit.self, from: data)
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
