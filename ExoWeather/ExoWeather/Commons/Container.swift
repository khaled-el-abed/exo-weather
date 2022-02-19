//
//  Container.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import Foundation

import Swinject

extension Container {

    static let shared: Container = {
        let container = Container()
        container.register(Networking.self) { _ in ApiClient.init() }
        return container
    }()

}
