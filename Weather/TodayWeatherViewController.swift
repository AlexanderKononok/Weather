//
//  TodayWeatherViewController.swift
//  Weather
//
//  Created by Alexander Kononok on 12/27/20.
//

import UIKit

class TodayWeatherViewController: UIViewController {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var threeDaysButton: UIButton!
    @IBOutlet weak var fiveDaysButton: UIButton!
    @IBOutlet weak var chosenCityLabel: UILabel!
    @IBOutlet weak var temperatureTodayLabel: UILabel!
    @IBOutlet weak var conditionTodayLabel: UILabel!

    var chosenCity: String = ""
    private let APIkey: String = "e5262135f4982e0de188dadb4defd702"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        chosenCityLabel.text = chosenCity
        todayWeatherSendRequest(chosenCity: chosenCity)
        roundButton(nameButton: [todayButton, threeDaysButton, fiveDaysButton])
    }
    
    func todayWeatherSendRequest(chosenCity: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(chosenCity)&appid=\(APIkey)"

        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {
                (data, response, error) in guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) {
                            let jsonDataDictionary = jsonData as? [String: Any]
                            let weatherCondition = jsonDataDictionary?["weather"] as? [[String: Any]]
                            let cityCondition = weatherCondition?[0].filter { $0.0 == "main" }
                            // swiftlint:disable force_cast
                            self.conditionTodayLabel.text = cityCondition?["main"] as! String
                            let weatherMainIndicators = jsonDataDictionary?["main"] as? [String: Any]
                            let cityTemperature = weatherMainIndicators?.filter { $0.0 == "temp" }
                            // swiftlint:disable force_cast
                            var cityTemperatureInCelsius = self.conversionKelvinToCelsius(temperature: cityTemperature?["temp"] as! Double)
                            self.temperatureTodayLabel.text = String(cityTemperatureInCelsius)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }

    func conversionKelvinToCelsius(temperature: Double) -> Double {
        return Double(round((temperature - 273.15) * 10) / 10)
    }
}

extension TodayWeatherViewController {
    func roundButton(nameButton: [UIButton]) {
        for button in nameButton {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
}
