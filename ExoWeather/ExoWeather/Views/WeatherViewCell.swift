//
//  MeteoViewCell.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 20/02/2022.
//

import UIKit
import Kingfisher

class WeatherViewCell: UITableViewCell {

    static let identifier = String(describing: WeatherViewCell.self)

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var meteoLabel: UILabel!
    @IBOutlet private weak var weatherValueLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!

    var viewModel: MeteoViewModel! {
        didSet {
            dayLabel.text = viewModel.day
            meteoLabel.text = viewModel.weather
            weatherValueLabel.text = viewModel.weatherValue
            cityLabel.text = viewModel.cityName
            let url = URL(string: viewModel.icon)
            iconImageView.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
