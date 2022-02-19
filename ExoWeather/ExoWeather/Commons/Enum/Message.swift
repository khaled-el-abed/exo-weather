//
//  Message.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 21/02/2022.
//

import Foundation

enum Message: CaseIterable {
    case first
    case second
    case last

    var title: String {
        switch self {
        case .first:
            return "Nous téléchargeons les données…"
        case .second:
            return "C’est presque fini…"
        case .last:
            return "Plus que quelques secondes avant d’avoir le résultat…"
        }
    }
}
