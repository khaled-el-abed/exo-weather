//
//  ApiClient.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestProtocol {
    var url: String { get }
    var urlString: String { get }
    var method: HttpMethod { get }
    var urlRequest: URLRequest { get }
}

extension RequestProtocol {

    var urlRequest: URLRequest {
        guard  let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: encodedUrl) else {
                    preconditionFailure("Invalid URL used to create URL instance")
                }

        return URLRequest(url: url)

    }

    var url: String {
        let url = "\(Router.baseUrl)\(urlString)" + "&appid=\(Router.Constants.authrizationKey)"
        return url
    }
}

enum WeatherRequest: RequestProtocol {
    var urlString: String {
        switch self {
        case .weather(let long, let lat):
            return Router.path.weathers + "?lon=\(long)" + "&lat=\(lat)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .weather: return .get
        }
    }

    case weather(long: Double, lat: Double)

}
