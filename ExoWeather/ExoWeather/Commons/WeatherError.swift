//
//  WeatherError.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation

enum WeatherError: Error {
    case notFound
    case notDefined

    var title: String {
        "Error"
    }

    var description: String {
        switch self {
        case .notFound:
            return "Ce lien n'existe plus."
        case .notDefined:
            return "Un Erreur est surevenu, merci de réessayer plus tard."
        }
    }
}
