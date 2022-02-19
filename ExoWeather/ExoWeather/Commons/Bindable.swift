//
//  Bindable.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 20/02/2022.
//

import Foundation

final class Bindable<T> {

    var value: T? {
        didSet {
            observer?(value)
        }
    }

    var observer: ((T?) -> ())?

    func bind(_ observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
