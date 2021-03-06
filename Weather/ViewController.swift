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

    var citiesArray: [String] = ["Minsk", "Gomel"]
//    var citiesArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "WEATHER"

        cityPicker.dataSource = self
        cityPicker.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        okButton.layer.cornerRadius = okButton.frame.height / 2

        if let urlCityList = Bundle.main.path(forResource: "city.list", ofType: ".json") {
            let url = URL(fileURLWithPath: urlCityList)
            do {
                let data = try Data(contentsOf: url)

                if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) {
                    let cityListDict = jsonData as? [[String: Any]]

                    for nameCity in cityListDict! {
                        // swiftlint:disable force_cast
                        citiesArray.append(nameCity["name"] as! String)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
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
