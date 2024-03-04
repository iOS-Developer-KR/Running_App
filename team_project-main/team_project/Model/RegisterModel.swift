//
//  RegisterModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation

struct RegisterModel {
    let httpClient = HTTPClient()
    
    func register(userid: String, password: String, key: String) async -> RegisterResponseDTD {
        let registerData = ["username": userid, "password": password, "key1":key]
        do {
            let request = Resource(url: Constants().registerPath!, method: .post(try JSONEncoder().encode(registerData)), modelType: RegisterResponseDTD.self)
            return try await httpClient.load(request)
        } catch {
            print("에러 \(error)")
            return RegisterResponseDTD(error: false, reason: error.localizedDescription)
        }
    }
    
    
//    func register(userid: String, password: String, key: String) async -> RegisterResponseDTD {
//        do {
//            let url = URL(string: "http://lsproject.shop/register")!
//            let registerData = ["username": userid, "password": password, "key1":key]
//            var uploadData = try JSONEncoder().encode(registerData)
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
//                if let error = error {
//                    print ("error: \(error)")
//                    return
//                }
//                guard let response = response as? HTTPURLResponse,
//                      (200...299).contains(response.statusCode) else {
//                    print ("server error")
//                    return //RegisterResponseDTD(error: true, reason: "이미 존재하는 아이디")
//                }
//                if let mimeType = response.mimeType,
//                   mimeType == "application/json",
//                   let data = data,
//                   let dataString = String(data: data, encoding: .utf8) {
//                    print ("got data: \(dataString)")
//                }
//            }
//            task.resume()
//        }
//        catch {
//            print("인코딩 에러")
//        }
//        
//    }
}
