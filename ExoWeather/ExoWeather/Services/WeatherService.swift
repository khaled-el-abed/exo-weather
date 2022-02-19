//
//  WeatherService.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation
import CoreLocation
import Swinject

//    0 secondes Rennes, à 10 secondes Paris, à 20 secondes Nantes, etc pour Bordeaux et Lyon
protocol WeatherServiceProtocol {

    func getWeahter(for location: CLLocation, comlpetion: @escaping (Result<WeatherData, Error>) -> Void)
}

final class WeatherService: WeatherServiceProtocol, ApiClientProvider {

    func getWeahter(for location: CLLocation, comlpetion: @escaping (Result<WeatherData, Error>) -> Void) {

        let request: RequestProtocol = WeatherRequest.weather(long: location.coordinate.longitude, lat: location.coordinate.latitude)

        apiClient?.execute(request, completion: { (result: Result<WeatherData, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let banks):
                    comlpetion(.success(banks))
                case .failure:
                    comlpetion(.failure(WeatherError.notDefined))
                }
            }
        })
    }
}

// MARK: - Provider

protocol WeatherServiceProvider {
    var weatherService: WeatherServiceProtocol? { get }
}

extension WeatherServiceProvider {

    var weatherService: WeatherServiceProtocol? {
        Container.shared.resolve(WeatherServiceProtocol.self)
    }
}
