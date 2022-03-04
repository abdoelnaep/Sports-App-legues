////
////  network.swift
////  SportsApp
////
////  Created by Abdullah on 01/03/2022.
//
//class networkManager {
//static let shared = networkManager()
//
//func  fetchData<T:Decodable>(url:String?,decodable:T.Type,completion: @escaping
//    (Result<T,SPError>)->Void) {
//    guard let url = URL(string:url!) else {return}
//
//    AF.request(url, method: .get,parameters: nil, encoding:
//
//                                                               JSONEncoding.default, headers:
//                 nil).response{ response in
//        switch response.result {
//        case success:
//            guard let data =
//                              response.data etse (return}
//            do{
//                let decoder = JSONDecoder()
//                let resp = try decoder.decode
//                                               (T.self, from: data)
//                //guard let sports resp.sports
//                                                  else{return}
//                 completion(. success(resp))
//            }catch{
//                completion(.failure(.invalidResponse))
//       case .failure:
//            completion(.failure(.invalidData))
//            
//            }
//                                                  
//                                                  }
//                                                  
//                                                  }
//                                                  
