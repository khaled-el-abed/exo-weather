//
//  ApiClient.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 21/02/2022.
//

import Foundation
import Swinject

final class ApiClient: Networking { }

// MARK: - Provider

protocol ApiClientProvider {

    var apiClient: Networking? { get }
}

extension ApiClientProvider {

    var apiClient: Networking? {
        Container.shared.resolve(Networking.self)
    }
}
