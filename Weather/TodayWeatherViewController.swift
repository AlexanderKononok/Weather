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
        sendRequest()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        chosenCityLabel.text = chosenCity
        roundButton(nameButton: [todayButton, threeDaysButton, fiveDaysButton])
    }

    func sendRequest() {
    }

}

extension TodayWeatherViewController {
    func roundButton(nameButton: [UIButton]) {
        for button in nameButton {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
}
