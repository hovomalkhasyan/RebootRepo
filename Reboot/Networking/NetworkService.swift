//
//  NetworkService.swift
//  Reboot
//
//  Created by Hovo on 11/11/20.
//


import Foundation
import Alamofire


class BaseError: Codable {
    let status: String?
    let detail: Detail?
}

class Detail: Codable {
    let errors: [Message]
}
class Message: Codable {
    let message: String
}

typealias RequestCompletion<T: Codable> = ((RequestResult<T>) -> Void)
public enum RequestResult<Value> {
    case success(Value?)
    case failure(String)
    
}

class NetWorkService {
    
    private static let refreshTokenEndPoint = "auth/tokens/refresh/"
    private static let baseUrl = "https://api.reboot.ru/api/ru/"
    private static let alamofireSessionMeneger = Alamofire.Session.default
    
    class func getHeaders() -> HTTPHeaders? {
        if let token = UserDefaults.standard.value(forKey: "token") as? String {
            return  ["Authorization": "Bearer \(token)"]
        }
        return nil
        
    }
    
    class func request<T: Codable>(url: String, method: HTTPMethod, param: Encodable?, encoding: JSONEncoding, complition: @escaping (RequestCompletion<T?>)) {
        alamofireSessionMeneger.request(baseUrl + url, method: method, parameters: param?.asDictionary(), encoding: encoding, headers: getHeaders()).responseJSON { (resp) in
            if resp.response?.statusCode == 401 {
                refreshToken {
                    request(url: url, method: method, param: param, encoding: encoding, complition: complition)
                }
                return
            }
            switch resp.result {
            case.success(let data):
                print(data)
                do {
                    let res = JSONDecoder()
                    res.keyDecodingStrategy = .convertFromSnakeCase
                    let json = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                    let responseData = try res.decode(T.self, from: json)
                    complition(RequestResult.success(responseData))
                } catch {
                    print(error)
                    do {
                        let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        let responseData = try JSONDecoder().decode(BaseError.self, from: json)
                        let error = responseData.detail?.errors.first?.message ?? ""
                        complition(RequestResult.failure(error))
                        
                        self.showAlert(title: error)
                        
                    } catch {
                        print(error)
                    
                    }
                }
                
            case.failure(let error):
                print(error.localizedDescription)
                self.showAlert(title: error.localizedDescription)
                
            }
        }
        
    }
    
    private class func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    private class func refreshToken(complition: @escaping () -> Void) {
        
        let model = RefreshToken(token:UserDefaults.standard.value(forKey: "token") as? String)
        NetWorkService.request(url: refreshTokenEndPoint, method: .post, param: model, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<LoginResponse?>) in
            switch resp {
            case .success(let data):
                guard let data = data else {return}
                UserDefaults.standard.setValue(data?.token, forKey: "token")
                complition()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

struct RefreshToken: Codable {
    let token : String?
}
   
