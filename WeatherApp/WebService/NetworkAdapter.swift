//
//  NetworkAdapter.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation

protocol NetworkAdaptor {
    func fetch<T: Decodable>(with request: URLRequest, type: [T].Type, completion: @escaping (Result<[T], APIError>) -> Void)
}

struct NetworkManager: NetworkAdaptor {
    
    func fetch<T: Decodable>(with request: URLRequest, type: [T].Type, completion: @escaping (Result<[T], APIError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.failure(.jsonParsingFailure))
                return
            }
            DispatchQueue.main.async {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let genericModel = try JSONDecoder().decode(type, from: data)
                            completion(Result.success(genericModel))
                        } catch {
                            completion(Result.failure(.jsonParsingFailure))
                        }
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                } else {
                    completion(Result.failure(.responseUnsuccessful))
                }
            }
        }.resume()
    }
    
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
