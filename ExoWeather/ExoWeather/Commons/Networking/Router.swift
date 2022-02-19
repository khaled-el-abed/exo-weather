//
//  Router.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation

import Alamofire

enum Router {

    enum Constants {
        static let authrizationKey: String = "0243fc2d7530f1f2e89317e181aec396"
    }

    enum path {
        static let  weathers = "weather"

    }

    static var baseUrl: String {
        "https://api.openweathermap.org/data/2.5/"
    }
}
