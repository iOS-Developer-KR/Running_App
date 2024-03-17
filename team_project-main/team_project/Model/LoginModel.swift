import Foundation
import JWTDecode
import SwiftUI
import Alamofire

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

class LoginModel {
//    @EnvironmentObject var isLogged: LoginStatus

    let httpClient = HTTPClient()

    // 여기서 토큰 체크하고 갱신한다
    
    //MARK: 로그인 (토큰처음부터 없었을때)
    func login(userid: String, password: String, completion: @escaping (Bool) -> Void) {
        let loginData = ["userid": userid, "password": password]
        var request = URLRequest(url: Constants().loginPath!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginData)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(false)
                return
            }
            let credentials = Credentials(username: userid, psssword: password, token: token)
            Task {
                try KeyChain.save(credentials: credentials)
                completion(true)
            }
            
        }.resume()
    }
    
    func login1(userid: String, password: String, completion: @escaping (Bool) -> Void) {
        let loginData = ["userid": userid, "password": password]
        AF.request(Constants().loginPath!, method: .post, parameters: loginData, encoder: JSONParameterEncoder.default).responseString { token in
            guard let token = token.value else {
                return completion(false) // 토큰값이 없으면
            }
            let credentials = Credentials(username: userid, psssword: password, token: token)
            Task {
                do {
                    try KeyChain.save(credentials: credentials)
                    return completion(true)
                } catch {
                    return completion(false)
                }
            }
        }
    }
    
    //MARK: 재로그인 (토큰만료됐을때)
    func Relogin(completion: @escaping (Bool) -> Void) {
        do {
            let credentials = try KeyChain.get()
            let loginData = ["userid": credentials.username, "password": credentials.psssword]
            var request = URLRequest(url: Constants().loginPath!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(loginData)
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                guard let token = String(data: data, encoding: .utf8) else {
                    completion(false)
                    return
                }
//                print("토큰값: \(token)")
                // 새로 로그인해서 가져온 토큰값으로 업데이트
                let credentials = Credentials(username: credentials.username, psssword: credentials.psssword, token: token)
                Task {
                    do {
                        if KeyChain.CheckTokenExist() { // 존재한다면
                            try KeyChain.update(credentials: credentials)
                            completion(true)
                        } else {
                            try KeyChain.delete()
                            try KeyChain.save(credentials: credentials)
                            completion(true)
                        }
                    } catch {
                        print("에러:\(error)")
                        completion(false)
                    }
                }
                
            }.resume()
        } catch {
            
        }
        
        
        
    }
    
    func Relogin2(completion: @escaping (Bool) -> Void) {
        do {
            let credentials = try KeyChain.get()
            login1(userid: credentials.username, password: credentials.psssword) { result in
                return completion(result)
            }
        } catch {
            return completion(false)
        }
    }
    
}

struct something: Codable {
    var key1: String?
}

struct somethingDTO: Codable {
    var error: String?
}

struct RegisterResponseDTO: Codable {
    var error: Bool
    var reason: String?
}

