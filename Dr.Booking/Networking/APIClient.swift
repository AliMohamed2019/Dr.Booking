//
//  APIClient.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 14/12/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//
import Alamofire
import SwiftyJSON
class APIClient {
   
   @discardableResult
   private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)->Void) -> DataRequest {
       return AF.request(route)
                      .responseDecodable (decoder: decoder){
                           (response: DataResponse<T,AFError>) in
                           completion(response.result)
       }
   }
   @discardableResult
   private static func performRequestSimple(route:APIRouter, completion: @escaping (Result<String, AFError>)->Void) -> DataRequest {
       return AF.request(route)
           .responseString(encoding: String.Encoding.utf8) {
               (response) in
               completion(response.result)
       }
   }
    
    
    
    //---------------------------------------------------
      
    static func login(mail : String , password : String , completion:@escaping
        (Result<Login,AFError>)->Void){
        performRequest(route: APIRouter.login(mail: mail, password: password), completion: completion)
    
    }
    
    static func loginfailure(mail : String , password : String , completion:@escaping
           (Result<Failure,AFError>)->Void){
           performRequest(route: APIRouter.login(mail: mail, password: password), completion: completion)
       
       }
    
    static func register (user_name : String , mail : String , phone : String , pass : String , completion : @escaping(Result<Register,AFError>)->Void){
        performRequest(route: APIRouter.register(user_name: user_name, mail: mail, phone: phone, pass: pass), completion: completion)
    }
    
    static func registerfailure (user_name : String , mail : String , phone : String , pass : String , completion : @escaping(Result<Failure,AFError>)->Void){
           performRequest(route: APIRouter.register(user_name: user_name, mail: mail, phone: phone, pass: pass), completion: completion)
       }
    
    static func addFavoriteDoctor (user_id : Int,  doctor_id : Int , completion : @escaping(Result<FavoriteDoctor,AFError>)->Void) {
        performRequest(route: APIRouter.addFavoriteDoctor(user_id: user_id, doctor_id: doctor_id), completion: completion)
    }
    static func deleteFavoriteDoctor (user_id : Int,  doctor_id : Int , completion : @escaping(Result<FavoriteDoctor,AFError>)->Void) {
           performRequest(route: APIRouter.deleteFavoriteDoctor(user_id: user_id, doctor_id: doctor_id), completion: completion)

       }
    
    
    static func getFavoriteDoctors(user_id : Int  , completion:@escaping
           (Result<AllFavoriteDoctor,AFError>)->Void){
           performRequest(route: APIRouter.getFavoriteDoctors(user_id: user_id), completion: completion)

       }
    
    static func getFavoriteDoctorsfailure(user_id : Int  , completion:@escaping
        (Result<Failure,AFError>)->Void){
        performRequest(route: APIRouter.getFavoriteDoctors(user_id: user_id), completion: completion)

    }
    
}


