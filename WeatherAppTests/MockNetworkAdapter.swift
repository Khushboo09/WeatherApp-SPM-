//
//  MockNetworkAdapter.swift
//  WeatherAppTests
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation
@testable import WeatherApp

struct MockNetworkAdaptor<T>: NetworkAdaptor {
    
    let fileName: String
    
    func fetch<T>(with request: URLRequest, type: [T].Type, completion: @escaping (Result<[T], APIError>) -> Void) where T : Decodable {
        //read from json and decode into T
        guard let data = try? JSONUtility().dataFromFile(named: fileName) else {
            completion(Result.failure(.invalidData))
            return
        }
        do {
            let genericModel = try JSONDecoder().decode(type, from: data)
            completion(Result.success(genericModel))
        } catch {
            completion(Result.failure(.jsonParsingFailure))
        }
    }
    
}

enum JsonError: Error {
    case encodingError
    case serializationError(error: Error?)
}

enum FileError: Error {
    case notFound
}

final class JSONUtility {
    
    func dataFromFile(named fileName: String) throws -> Data {
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            throw FileError.notFound
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch let error {
            throw JsonError.serializationError(error: error)
        }
    }
}
