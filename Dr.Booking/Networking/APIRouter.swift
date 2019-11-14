//
//  APIRouter.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
   
    
    case login(mail:String , password : String)
    case register(user_name:String ,mail:String , phone:String , pass:String )
    case addFavoriteDoctor(user_id : String,doctor_id : String )
    case deleteFavoriteDoctor(user_id : String, doctor_id : String )
    case getFavoriteDoctors(user_id : String)
    case addRate(user_id : String, doctor_id : String , rate : Double)
    case getAllProducts
    case viewProduct(product_id : String)
    case buyProduct(user_id : String, product_id : String)
    case getUserProducts(user_id : String)
    case editProfile(user_id : String , user_name : String , user_mail : String ,user_phone : String)
    case Search(search_words : String ,order_by : String ,user_id : String)
    case viewDoctor(user_id : String, doctor_id : String )
    case make_reservation(user_id : String, doctor_id : String , docotor_reservation_date_id : String)
    case view_reservations(user_id : String)
    case getAllDoctors(user_id : String)
    case viewProfile(user_id : String)
    case forget_pass(user_email : String)
    case update_password(user_id : String,Current_Password : String ,New_Password : String ,ReType_New_Password : String )
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .get
        case .register:
             return .get
        case .addFavoriteDoctor:
             return .get
        case .deleteFavoriteDoctor:
             return .get
        case .getFavoriteDoctors:
             return .get
        case .addRate:
             return .get
        case .getAllProducts:
             return .get
        case .viewProduct:
             return .get
        case .buyProduct:
             return .get
        case .getUserProducts:
             return .get
        case .editProfile:
             return .get
        case .Search:
             return .get
        case .viewDoctor:
             return .get
        case .make_reservation:
             return .get
        case .view_reservations:
             return .get
        case .getAllDoctors:
             return .get
        case .viewProfile:
             return .get
        case .forget_pass:
             return .get
        case .update_password:
             return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .login(let mail, let password):
            return "/\(K.ProductionServer.userType)/login/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(mail)/\(password)"
        case .register(let user_name, let mail, let phone, let pass):
            return "/\(K.ProductionServer.userType)/register/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_name)/\(mail)/\(phone)/\(pass)"
        case .addFavoriteDoctor(let user_id, let doctor_id):
            return "/\(K.ProductionServer.userType)/addFavoriteDoctor/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(doctor_id)"
        case .deleteFavoriteDoctor(let user_id, let doctor_id):
            return "/\(K.ProductionServer.userType)/deleteFavoriteDoctor/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(doctor_id)"
        case .getFavoriteDoctors(let user_id):
            return "/\(K.ProductionServer.userType)/getFavoriteDoctors/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)"
        case .addRate(let user_id, let doctor_id, let rate):
            return "/\(K.ProductionServer.userType)/addRate/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(doctor_id)/\(rate)"
        case .getAllProducts:
            return "/\(K.ProductionServer.productType)/getAll/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)"
        case .viewProduct(let product_id):
            return "/\(K.ProductionServer.productType)/view/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(product_id)"
        case .buyProduct(let user_id, let product_id):
            return "/\(K.ProductionServer.productType)/buyProduct/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(product_id)"
        case .getUserProducts(let user_id):
            return "/\(K.ProductionServer.userType)/getUserProducts/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)"
        
        case .editProfile(let user_id, let user_name, let user_mail, let user_phone):
            return "/\(K.ProductionServer.userType)/editProfile/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(user_name)/\(user_mail)/\(user_phone)"
        case .Search(let search_words, let order_by, let user_id):
            return "/Search/index/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(search_words)/\(order_by)/\(user_id)"
        case .viewDoctor(let user_id, let doctor_id):
            return "/\(K.ProductionServer.DoctorType)/view/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(doctor_id)"
        case .make_reservation(let user_id, let doctor_id, let docotor_reservation_date_id):
            return "/\(K.ProductionServer.userType)/make_reservation/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)\(user_id)/\(doctor_id)/\(docotor_reservation_date_id)"
        case .view_reservations(let user_id):
            return "/\(K.ProductionServer.userType)/view_reservations/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)\(user_id)"
        case .getAllDoctors(let user_id):
            return "/\(K.ProductionServer.DoctorType)/getAll/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)"
       case .viewProfile(let user_id):
           return "/\(K.ProductionServer.userType)/view/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)\(user_id)"
        case .forget_pass(let user_email):
            return "/\(K.ProductionServer.userType)/forget_pass/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_email)"
        case .update_password(let user_id, let Current_Password, let New_Password, let     ReType_New_Password):
           return "/\(K.ProductionServer.userType)/update_password/\(K.ProductionServer.webserviceUser)/\(K.ProductionServer.webservicePass)/\(user_id)/\(Current_Password)/\(New_Password)/\(ReType_New_Password)"
        
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        
        case .login( _, _):
            return nil
        case .register( _ , _ , _ , _ ):
            return nil
        case .addFavoriteDoctor(let user_id, let doctor_id ):
             return nil
        
        case .deleteFavoriteDoctor(let user_id, let doctor_id):
             return nil
        case .getFavoriteDoctors(let user_id):
             return nil
        case .addRate(let user_id, let doctor_id, let rate):
             return nil
        case .getAllProducts:
             return nil
        case .viewProduct(let product_id):
             return nil
        case .buyProduct(let user_id, let product_id):
             return nil
        case .getUserProducts(let user_id):
             return nil
        case .editProfile(let user_id, let user_name, let user_mail, let user_phone):
             return nil
        case .Search(let search_words, let order_by, let user_id):
             return nil
        case .viewDoctor(let user_id, let doctor_id):
             return nil
        case .make_reservation(let user_id, let doctor_id, let docotor_reservation_date_id):
             return nil
        case .view_reservations(let user_id):
             return nil
        case .getAllDoctors(let user_id):
             return nil
        case .viewProfile(let user_id):
             return nil
        case .forget_pass(let user_email):
             return nil
        case .update_password(let user_id, let Current_Password, let New_Password, let ReType_New_Password):
             return nil
        }
}
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        print("*****************\(urlRequest)")
        // Parameters
        if let parameters = parameters {
            do {
                
                urlRequest = try URLEncoding.httpBody.encode(urlRequest, with: parameters)
               
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }


}

