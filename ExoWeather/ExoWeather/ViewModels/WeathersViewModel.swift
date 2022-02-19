//
//  WeatherViewModel.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation
import CoreLocation

final class WeathersViewModel: WeatherServiceProvider {

    private enum LocalConstant {
        static let cityTimer: Double = 10
        static let messageTimer: Double = 6
    }

    // MARK: - Life Cycle

    init() {
        currentCity = City.allCases.last ?? .nantes
    }

    deinit {

        fetchTimer.invalidate()
        messageTimer.invalidate()
    }

    // MARK: - Public Properties

    private(set) var isLoading: Bindable<Bool> = Bindable<Bool>()
    private(set) var isSuccess: Bindable<Bool> = Bindable<Bool>()
    private(set) var progressValue: Bindable<Double> = Bindable<Double>()
    
    private(set) var message: Bindable<String> = Bindable<String>()
    private(set) var hasError: Bindable<WeatherError> = Bindable<WeatherError>()

    var citiesCount: Int {
        City.allCases.count
    }

    var progress: String {
        "\(Int((progressValue.value ?? 0) * 100))%"
    }

    // MARK: - Private Properties

    private var weathers : Array<(key: City, value: WeatherData)> = []
    private var fetchTimer: Timer!
    private var messageTimer: Timer!
    private var currentCity: City {
        didSet {
            getWeather(for: currentCity)
        }
    }

    private var currentMessage: Message = .last

    // MARK: - Public Functions

    func getCityWeather(at index: Int) -> (key: City, value: WeatherData)? {
        guard index < weathers.count else { return nil }

        return weathers[index]
    }

    func startFetching() {
        isLoading.value = true
        setupTimer()
        fetchTimer.fire()
        messageTimer.fire()
    }

    // MARK: - Private Functions

    private func setupTimer() {
        fetchTimer = Timer.scheduledTimer(timeInterval: LocalConstant.cityTimer, target: self, selector: #selector(fireFetching), userInfo: nil, repeats: true)
        messageTimer = Timer.scheduledTimer(timeInterval: LocalConstant.messageTimer, target: self, selector: #selector(fireMessage), userInfo: nil, repeats: true)
    }

    private func getWeather(for country: City) {
        weatherService?.getWeahter(for: country.location, comlpetion: { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let weather):
                self.weathers.append((key: self.currentCity, value: weather))
                self.incrementProgress()
                if let lastCountry = City.allCases.last, lastCountry == self.currentCity  {

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isLoading.value = false
                        self.isSuccess.value = true
                    }

                }
            case .failure:
                self.isSuccess.value = false
                self.hasError.value = .notDefined
            }
        })
    }

    @objc private func fireFetching() {
        currentCity = currentCity.next()

        if let lastCountry = City.allCases.last, lastCountry == self.currentCity  {
            fetchTimer.invalidate()
        }
    }

    @objc private func fireMessage() {
        currentMessage = currentMessage.next()
        message.value = currentMessage.title
    }

    private func incrementProgress() {
        let index: Int = City.allCases.firstIndex(of: self.currentCity) ?? 0
        let progress = (100/City.allCases.count) * (index+1)
        progressValue.value = Double(progress)/Double(100)
    }
}


extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
