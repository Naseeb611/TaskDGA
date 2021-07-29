//
//  Model.swift
//  TaskDGA
//
//  Created by Sarath on 28/07/21.
//
import UIKit
import Alamofire

enum Methods {
    case get
    case post
}
struct ApiHandler {
    
    static func getParseService(with url:String?, methods: Methods, parameters: [String: Any]?, image :[UIImage?], in view: UIViewController?, background: Bool?, completion: @escaping (_ result: Any?, _ error: Error?, _ networkId: Int) -> Void){
        
        let network = NetworkManager(with: url, methods: methods, parameters: parameters, image: image, in: view, background: background, completion: completion)
        ApiHandler.networkQeue.append(network)
        
        for item in ApiHandler.networkQeue {
            if item.networkId == network.networkId {
                item.getParseService()
            }
        }
        
        if ApiHandler.networkQeue.count > 2 {
            ApiHandler.networkQeue.removeFirst()
        }
    }
    static var networkQeue = [NetworkManager]()
}


class NetworkManager {
    
    public var networkId  = Int.random(in: 1000..<1000000)
    
    private var url : String?
    
    private var image :UIImage?
     private var image1 :UIImage?
     private var image2 :UIImage?
    
    private let methods : Methods
    
    private var parameters : [String: Any]?
    
    private var view : UIViewController?
    
    private var background : Bool?
    
    private var completion : ((_ result: Any?, _ error: Error?, _ networkId: Int) -> Void)?
    
    func getJsonHeader() -> HTTPHeaders? {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        print(headers)
        return headers
    }
    func getAuthHeader() -> HTTPHeaders? {
        
        let key = UserDefaults.standard.string(forKey: "KeyAuthorization") ?? ""
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(key)"

            
        ]
     
        print("headers : \(headers)")
        return headers
    }
    init(with url:String?, methods: Methods, parameters: [String: Any]?, image: [UIImage?], in view: UIViewController?, background: Bool?, completion: ((_ result: Any?, _ error: Error?, _ networkId: Int) -> Void)?) {
        self.url = url
        self.methods = methods
        self.parameters = parameters
        self.image = image[0]
        if image.count == 2 {
            self.image1 = image[1]
        }
        if image.count == 3 {
             self.image2 = image[2]
        }
       
        self.view = view
        self.background = background
        self.completion = completion
        NotificationCenter.default.addObserver(self, selector: #selector(networkRetry), name: Notification.Name("networkRetry:\(self.networkId)"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(networkRetryForAll), name: Notification.Name("networkRetry:\(99)"), object: nil)
    }
    
    @objc private func networkRetry() {
        print(ApiHandler.networkQeue.count)
        
        ApiHandler.networkQeue.removeAll()
        ApiHandler.networkQeue.append(self)
        self.getParseService()
    }
    
    @objc private func networkRetryForAll() {
        
        self.getParseService()
    }
    
    public func getParseService() {
        
        guard url != nil else {
            return
        }
        
        print(url ?? "")
        print(parameters ?? [:])
        
        
        var header: HTTPHeaders?
//        if url!.contains(AppURL.SIGN_UP_URL)  || url!.contains(AppURL.EMAIL_VERIFICATION) || url!.contains(AppURL.VERIFY_OTP) || url!.contains(AppURL.CHANGE_PASS) {
//            header = self.getJsonHeader()
//        } else {
//            header = self.getAuthHeader()
//        }
        
        //Calling Api here
        switch methods {
        case .get:
            print("Header :: \(header)")
            
            if url == AppURL.List_URL {
                header = nil
            }
            Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                debugPrint(response)
                let status = response.response?.statusCode
                if status == 401 {
                    // Call Refresh tocken Api
                    self.refreshTocken(completion: { (result, error, status) in
                        if status == 1 {
                            self.networkRetry()
                        } else {
                            
                            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Invaild access token"])
                            self.completion?(nil, error, self.networkId)
                        }
                    })
                } else {
                    
                    if self.background == false {
                        
                    }
                    switch response.result {
                    case .success:
                        if let responseData = response.result.value {
                            print("responseData: \(responseData)")
                            self.completion?(responseData, nil, self.networkId)
                        }
                    case .failure(let error):
                        self.completion?(nil, error, self.networkId)
                    }
                }
            }
       
        case .post:
            break
        }
    }
    func managejson(data: Data) -> String? {
        var jsonString = String(data: data, encoding: .utf8)
        print(jsonString!)
        jsonString = jsonString?.replacingOccurrences(of: "\\'", with: "'")
        jsonString = jsonString?.replacingOccurrences(of: "\n", with: "")
        jsonString = jsonString?.trimmingCharacters(in: .whitespacesAndNewlines)
        print(jsonString!)
        jsonString = jsonString?.components(separatedBy: .whitespaces).joined()
        print(jsonString!)
        return jsonString
    }
    
    func refreshTocken(completion: @escaping (_ result: Result?, _ error: Error?, _ status: Int?) -> Void) {
        print(AppURL.REFRESH_TOCKEN_URL)
        Alamofire.request(AppURL.REFRESH_TOCKEN_URL, method: .post, parameters: nil, headers: self.getJsonHeader()).responseJSON { response in
            if let responseData = response.result.value {
                print("responseData: \(responseData)")
                if let josn = responseData as? [String : Any] {
                  
                   // completion(response.result, nil, 0)
                }
            }
        }
    }
 
}
