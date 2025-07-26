//
//  NetworkManager.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://3.39.18.57:8080"
    
    // GET 요청
    func get<T: Decodable>(
        path: String,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)\(path)"
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decoded):
                    completion(.success(decoded))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // POST 요청
    func post<T: Decodable, U: Encodable>(
        path: String,
        body: U,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)\(path)"
        
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // POST 요청 - 문자열 바디 전용
    func postStringBody<T: Decodable>(
        path: String,
        body: String,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)\(path)"
        let data = try? JSONEncoder().encode(body)
        
        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        AF.request(request)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decoded):
                    completion(.success(decoded))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func postWithoutDecoding<U: Encodable>(
        path: String,
        body: U,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let url = "\(baseURL)\(path)"
        
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default)
        .validate()
        .response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
