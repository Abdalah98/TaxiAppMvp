//
//  CityWeatherVC.swift
//  Taxiapp MVP Task Alalmiya Alhura
//
//  Created by Abdallah on 2/17/22.
//

import UIKit

class CityWeatherVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var citeyNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameCountryLabe1: UILabel!
    @IBOutlet weak var tempLabe1: UILabel!
    @IBOutlet weak var tempMinLabe1: UILabel!
    @IBOutlet weak var tempMixLabe1: UILabel!
     @IBOutlet weak var pressureLabe1: UILabel!
    @IBOutlet weak var humidityLabe1: UILabel!
    @IBOutlet weak var windSpeedLabe1: UILabel!
    @IBOutlet weak var stackViewContry: UIStackView!
    
    var weatherElement = [WeatherElement]()

    let mf = MeasurementFormatter()
  
    let activity: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .large
        aiv.color = .label
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        citeyNameTextField.endEditing(true)
        citeyNameTextField.resignFirstResponder()
        fetchData(searchText: textField.text ?? "")
        stackViewContry.isHidden = false
        tableView.isHidden = false
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.delegate = self
        tableView.dataSource = self

        citeyNameTextField.delegate = self
        hideKeyboardWhenTappedAround()
     }
    
    // call api
    func fetchData(searchText:String){
        NetworkManger.shared.searchCountryWeather(searchText: searchText) {[weak self] (result) in
            guard let self = self else{return}
            self.showActivity()
            switch result {
            case .success(let response):
                self.weatherElement = response.weather

                DispatchQueue.main.async {
                    self.nameCountryLabe1.text = response.name
                    self.tempLabe1.text = String(self.convertTemp(temp: response.main.temp, from: .kelvin, to: .celsius))
                    self.tempMixLabe1.text = String(self.convertTemp(temp: response.main.tempMax, from: .kelvin, to: .celsius))
                    self.tempMinLabe1.text = String(self.convertTemp(temp: response.main.tempMin, from: .kelvin, to: .celsius))
                    self.pressureLabe1.text = "\(String(response.main.pressure / 1000))hPa"
                    self.humidityLabe1.text = "\(String(response.main.humidity / 100))%"
                    self.humidityLabe1.text = "\(String(response.wind.speed)) km/h"
                    self.tableView.reloadData()
                }
                self.stopActivity()

            case .failure(let error):
                self.stopActivity()
                self.showAlert(error.rawValue)
            }
        }
    }
    // to hide Activity when get data
    func stopActivity(){
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.hidesWhenStopped = true
        }
    }
    // to show Activity when get data

    func showActivity(){
        DispatchQueue.main.async {
            self.activity.startAnimating()
        }
    }
    //to convert temp
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }

}


extension CityWeatherVC : UITableViewDelegate , UITableViewDataSource{
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(weatherElement.count)
        return weatherElement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let weather = weatherElement[indexPath.row]
        cell.textLabel?.text = weather.weatherDescription

        return cell
    }
    
 
}
