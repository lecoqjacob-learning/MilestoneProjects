//
//  UserService.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import Foundation

enum NetworkError: Error {
    case BadURL, NoData, DecodingError
}

class UserService {
    
    func getUsers(completion : @escaping(Result<[UserModel],NetworkError>) -> Void){
            
            guard let url = URL.userURL() else {
                return completion(.failure(.BadURL))
            }
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return completion(.failure(.NoData))
                }
                
                print("here")
                print(data)
                
                let userResponse = try? JSONDecoder().decode([UserModel].self, from: data)
                                
                if let userResponse = userResponse {
                    completion(.success(userResponse))
                } else {
                    completion(.failure(.DecodingError))
                }
            }.resume()
            
        }
}
