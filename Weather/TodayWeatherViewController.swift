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

    var chosenCity: String = ""
    private let APIkey: String = "e5262135f4982e0de188dadb4defd702"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let urlCityList = Bundle.main.path(forResource: "city.list", ofType: ".json") {
            let url = URL(fileURLWithPath: urlCityList)
            do {
                let data = try Data(contentsOf: url)
//                let cityName = try? JSONDecoder().decode(CityList.self, from: data)
//                print(cityName?.name)
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    let cityListDict = json as? [String: Any]
                    let cityName = cityListDict?["name"] as? [String]
                    print("TEST")
                    print(cityName)
                }
            } catch {
                print(error.localizedDescription)
            }
        }

        chosenCityLabel.text = chosenCity
        roundButton(nameButton: [todayButton, threeDaysButton, fiveDaysButton])
    }

}

extension TodayWeatherViewController {
    func roundButton(nameButton: [UIButton]) {
        for button in nameButton {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
}
