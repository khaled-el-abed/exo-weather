//
//  ViewController.swift
//  ExoWeather
//
//  Created by Khaled ElAbed perso on 19/02/2022.
//

import UIKit

class ViewController: UIViewController, Alertable {

    // MARK: - IBOutlets

    @IBOutlet private weak var progressView: ProgressView! {
        didSet {
            progressView.gradientColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var precentLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var restartButton: UIButton!

    @IBOutlet private weak var restartContainerView: UIView!
    @IBOutlet private weak var progressContainerView: UIView!
    @IBOutlet private weak var messageContainerView: UIView!

    // MARK: - IBActions

    @IBAction private func restartTouchedUp(_ sender: Any) {
        viewModel.startFetching()
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupView()
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.startFetching()
    }

    // MARK: - Public Properties
    
    private(set) var viewModel = WeathersViewModel()

    // MARK: - Private Methods

    private func setupBinding() {
        viewModel.progressValue.bind { [weak self] progress in
            guard let self = self else { return }

            self.progressView.progress = CGFloat(progress ?? 0)
            self.precentLabel.text = self.viewModel.progress

        }

        viewModel.isLoading.bind { [weak self]  shouldReload in
            guard let shouldReload = shouldReload else { return }

            self?.processResult(with: shouldReload)
        }

        viewModel.message.bind { [weak self] message in
            self?.messageLabel.text = message
        }

        viewModel.hasError.bind { [weak self] error in
            guard let error = error else { return }

            self?.processError(with: error)
        }

        viewModel.isSuccess.bind { [weak self] isSuccess in
            self?.processResult(with: isSuccess ?? false)
        }

        viewModel.isLoading.bind { [weak self] isLoading in
            self?.processLoading(with: isLoading ?? false)
        }
    }

    private func setupView() {
        let nib = UINib(nibName: WeatherViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: WeatherViewCell.identifier)
        tableView.dataSource = self
    }

    private func processResult(with isSuccess: Bool) {
        restartContainerView.isHidden = !isSuccess
        tableView.isHidden = !isSuccess
        tableView.reloadData()
    }

    private func processError(with error: WeatherError) {
        tableView.isHidden = true
        showAlert(with: error.title, message: error.description)
    }

    private func processLoading(with isLoading: Bool) {
        tableView.isHidden = isLoading
        messageContainerView.isHidden = !isLoading
        progressContainerView.isHidden = !isLoading
        restartContainerView.isHidden = isLoading
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citiesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherViewCell.identifier, for: indexPath) as? WeatherViewCell,
              let weather = viewModel.getCityWeather(at: indexPath.row) else { return UITableViewCell() }

        cell.viewModel = MeteoViewModel(weatherData: weather.value, city: weather.key)
        return cell
    }
}
