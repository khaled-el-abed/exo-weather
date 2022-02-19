//
//  Networking.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation
import Swinject

protocol Networking {

    /// Excure a request
    ///
    /// - Parameters:
    ///     - requestProvider: The request to provide to server
    ///     - completion: The result to get from server
    func execute<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void)

}

extension Networking {

    func execute<T: Decodable>(_ request: RequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = request.urlRequest
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
