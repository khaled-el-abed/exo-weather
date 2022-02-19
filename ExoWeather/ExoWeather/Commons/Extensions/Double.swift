//
//  Double.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 21/02/2022.
//

import Foundation

extension Double {
    func toCelsius() -> String {
        String(format: "%.0f°", self-273.15 )
    }
}
