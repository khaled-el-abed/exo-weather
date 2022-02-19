//
//  WeatherViewModel.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 20/02/2022.
//

import Foundation

struct MeteoViewModel {

    // MARK: - Life Cycle

    init(weatherData: WeatherData, city: City) {

        self.city = city
        self.weatherData = weatherData

        guard let weather = weatherData.weather.first, let iconName = weather.icon else { return }

        icon = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
        day = weatherData.dt.toSmallDate()
        self.weather = weather.main ?? ""
        weatherValue = weatherData.main.temp?.toCelsius() ?? ""
        cityName = city.title
    }

    // MARK: - Public Properties

    private(set) var country: String = ""
    private(set) var icon: String = ""
    private(set) var day: String = ""
    private(set) var weather: String = ""
    private(set) var weatherValue: String = ""
    private(set) var cityName: String = ""

    // MARK: - Private Properties

    private var weatherData: WeatherData
    private var city: City

}
