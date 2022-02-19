//
//  Alertable.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 21/02/2022.
//

import UIKit

protocol Alertable {
    func showAlert(with title: String, message: String, buttontitle: String?, buttonClosure: (() -> Void)? )
}

extension Alertable where Self: UIViewController {

    func showAlert(with title: String, message: String, buttontitle: String? = nil , buttonClosure: (() -> Void)? = nil) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttontitle ?? "Ok", style: .default, handler: { (action) -> Void in
            buttonClosure?()
         })

        dialogMessage.addAction(ok)
        present(dialogMessage, animated :true)
    }
}
