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
    
    static func addFavoriteDoctor (user_id : String,  doctor_id : String , completion : @escaping(Result<FavoriteDoctor,AFError>)->Void) {
        performRequest(route: APIRouter.addFavoriteDoctor(user_id: user_id, doctor_id: doctor_id), completion: completion)
    }
    static func deleteFavoriteDoctor (user_id : String,  doctor_id : String , completion : @escaping(Result<FavoriteDoctor,AFError>)->Void) {
           performRequest(route: APIRouter.deleteFavoriteDoctor(user_id: user_id, doctor_id: doctor_id), completion: completion)

       }
    
    
    static func getFavoriteDoctors(user_id : String  , completion:@escaping
           (Result<AllFavoriteDoctor,AFError>)->Void){
           performRequest(route: APIRouter.getFavoriteDoctors(user_id: user_id), completion: completion)

       }
    
    static func getFavoriteDoctorsfailure(user_id : String  , completion:@escaping
        (Result<Failure,AFError>)->Void){
        performRequest(route: APIRouter.getFavoriteDoctors(user_id: user_id), completion: completion)

    }
    
    static func getAllProduct(completion:@escaping
        (Result<Products,AFError>)->Void){
        performRequest(route: APIRouter.getAllProducts, completion: completion)
        

    }
    
    static func getProductDetails(product_id: String, completion:@escaping
           (Result<ProductDetails,AFError>)->Void){
           performRequest(route: APIRouter.viewProduct(product_id: product_id), completion: completion)
    }
    
    static func buyProduct(user_id: String, product_id: String, completion:@escaping
           (Result<Failure,AFError>)->Void){
           performRequest(route: APIRouter.buyProduct(user_id: user_id, product_id: product_id), completion: completion)
    }
    
    static func getUserFavouritProducts(user_id: String, completion:@escaping
           (Result<Failure,AFError>)->Void){
           performRequest(route: APIRouter.getUserProducts(user_id: user_id), completion: completion)
    }
    
    

    static func forgetPass(user_email : String , completion:@escaping(Result<ForgetPass,AFError>)->Void){
            performRequest(route: APIRouter.forget_pass(user_email: user_email), completion: completion)
            }
        
        static func updatePassword(user_id : String , Current_Password  : String, New_Password  : String, ReType_New_Password: String ,  completion:@escaping(Result<UpdatePassword,AFError>)->Void){
            performRequest(route: APIRouter.update_password(user_id: user_id, Current_Password: Current_Password, New_Password: New_Password, ReType_New_Password: ReType_New_Password), completion: completion)
        }
        
        
        static func editProfile(user_id : String , user_name  : String, user_mail  : String, user_phone: String ,  completion:@escaping(Result<EditProfile,AFError>)->Void){
            performRequest(route: APIRouter.editProfile(user_id: user_id, user_name: user_name, user_mail: user_mail, user_phone: user_phone), completion: completion)
        }
    
    static func getDoctors(user_id : String ,completion:@escaping(Result<Doctors,AFError>)->Void){
        performRequest(route: APIRouter.getAllDoctors(user_id: user_id) , completion: completion)
    }
    
    static func getSearchedDoctors(search_words: String, order_by: String,user_id : String ,completion:@escaping(Result<EditProfile,AFError>)->Void){
        performRequest(route: APIRouter.Search(search_words: search_words, order_by: order_by, user_id: user_id) , completion: completion)
    }
    
    static func rateDoctor( user_id : String ,doctor_id : String , rate: Double ,completion:@escaping(Result<Failure,AFError>)->Void){
        performRequest(route: APIRouter.addRate(user_id: user_id, doctor_id: doctor_id, rate: rate  ) , completion: completion)
    }
    static func getUserProducts (user_id : String , completion:@escaping(Result<Products,AFError>)->Void){
           performRequest(route: APIRouter.getUserProducts(user_id: user_id), completion: completion)
       }
       
       static func getUserProductsfailure (user_id : String , completion:@escaping(Result<Failure,AFError>)->Void){
              performRequest(route: APIRouter.getUserProducts(user_id: user_id), completion: completion)
          }
}


