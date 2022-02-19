//
//  Int.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 21/02/2022.
//

import Foundation

extension Int {
    func toSmallDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }

    func toDate() -> String {

        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let format = DateFormatter()
        format.dateFormat = "EEEE, dd MMM yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
}
