//
//  RegisterModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import Alamofire

struct RegisterModel {
    let httpClient = HTTPClient()
    
    func register(userid: String, password: String) async -> RegisterResponseDTD {
        let registerData = ["username": userid, "password": password]
        do {
            let request = Resource(url: Constants().registerPath!, method: .post(try JSONEncoder().encode(registerData)), modelType: RegisterResponseDTD.self)
            return try await httpClient.load(request)
        } catch {
            print("에러 \(error)")
            return RegisterResponseDTD(error: false, reason: error.localizedDescription)
        }
    }
    
    func registers(userid: String, password: String, completion: @escaping (Result<RegisterResponseDTD, NetworkError>) -> Void) {
        let registerData = ["username": userid, "password": password]
        AF.request(Constants().registerPath!, method: .post, parameters: registerData, encoder: JSONParameterEncoder.default).responseDecodable(of: RegisterResponseDTD.self) { response in
            if response.error != nil {
                return completion(.failure(.invalidResponse))
            } // 만일 성공했다면
            guard let data = response.value else {
                 return completion(.failure(.noData))
            }
            completion(.success(data))
        }
    }
    
}
