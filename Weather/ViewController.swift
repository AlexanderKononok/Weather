//
//  ViewController.swift
//  Weather
//
//  Created by Alexander Kononok on 12/27/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cityPicker: UIPickerView!

    let citiesArray: [String] = ["Minsk", "Gomel"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "WEATHER"

        cityPicker.dataSource = self
        cityPicker.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        okButton.layer.cornerRadius = okButton.frame.height / 2
    }

    @IBAction func okButtonPressed(_ sender: Any) {
        let todayWeatherStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let todayWeatherViewController = todayWeatherStoryboard.instantiateViewController(
            identifier: String(describing: TodayWeatherViewController.self))
            as? TodayWeatherViewController

        let index = cityPicker.selectedRow(inComponent: 0)
        todayWeatherViewController?.chosenCity = citiesArray[index]

        navigationController?.pushViewController(todayWeatherViewController ?? UIViewController(), animated: true)
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArray[row]
    }

}
