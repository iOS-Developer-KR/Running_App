import Foundation
import JWTDecode
import SwiftUI

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

class LoginModel {
    @EnvironmentObject var isLogged: LoginStatus

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
//            print("토큰값: \(token)")
            let credentials = Credentials(username: userid, psssword: password, token: token)
            Task {
                try KeyChain.save(credentials: credentials)
                completion(true)
            }
            
        }.resume()
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
                        if try KeyChain.CheckToken() {
                            try KeyChain.update(credentials: credentials)
                            completion(true)
                        } else {
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
    
//    func attemptAutoLogin() {
//        do {
//            if try KeyChain.CheckToken() { // 만약 토큰이 존재했다면 기존에 토큰을 지우고 재로그인
//                Relogin(completion: { result in
//                    if result { // 재로그인을 다시 시도했을때 성공할 경우
//                        print("재로그인 성공 -> ContentView로 이동해야한다")
//                        DispatchQueue.main.async {
//                            self.isLogged.checklogged(logged: true)
//                        }
//                    } else { // 재로그인을 실패했을때 로그인창으로 회원정보 재입력
//                        print("재로그인 실패 -> 로그인뷰로 이동해야한다")
//                        DispatchQueue.main.async {
//                            self.isLogged.checklogged(logged: false)
//                        }
//                    }
//                })
//            } else { // 만약 토큰이 애초에 존재하지 않았다면 새로 로그인
//                isLogged.checklogged(logged: false)
//            }
//        } catch {
//            print("에러 발생:\(error)")
//        }
//    }
    
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

//struct tmp: Codable {
//    var key1: [tmp2]
//}
//
//struct tmp2: Codable {
//    var date
//    var 횟수
//    var 세트수
//}
