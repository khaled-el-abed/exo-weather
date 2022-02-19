//
//  City.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 21/02/2022.
//

import Foundation
import CoreLocation

enum City: CaseIterable {
    case paris
    case nantes
    case rennes
    case bordeaux
    case lyon

    var title: String {
        switch self {
        case .paris:
            return "Paris"
        case .nantes:
            return "Nantes"
        case .rennes:
            return "Rennes"
        case .bordeaux:
            return "Bordeaux"
        case .lyon:
            return "Lyon"
        }
    }

    var location: CLLocation {
        switch self {
        case .paris:
            return CLLocation(latitude: CLLocationDegrees(48.8589466),
                              longitude: CLLocationDegrees(2.2769954))
        case .nantes:

            return CLLocation(latitude: CLLocationDegrees(47.238328),
                              longitude: CLLocationDegrees(-1.6303741))
        case .rennes:

            return CLLocation(latitude: CLLocationDegrees(48.1159863),
                              longitude: CLLocationDegrees(-1.7234628))
        case .bordeaux:

            return CLLocation(latitude: CLLocationDegrees(44.8638181),
                              longitude: CLLocationDegrees(-0.6560518))
        case .lyon:

            return CLLocation(latitude: CLLocationDegrees(45.7580491),
                              longitude: CLLocationDegrees(4.7650904))
        }
    }
}
