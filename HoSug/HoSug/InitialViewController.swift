//
//  ViewController.swift
//  HoSug
//
//  Created by Dempsy on 10/12/2017.
//  Copyright © 2017 Bocer. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    var pickerData: [String] = [String]()
    var selectedCity: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        button.layer.cornerRadius = 10
        
        picker.dataSource = self
        picker.delegate = self
        pickerData = ["Nashville", "Los Angeles", "New York", "San Francisco", "Boston"]
        selectedCity = pickerData[2]
        picker.selectRow(2, inComponent: 0, animated: true)
        
        navigationItem.title = "Back"
        navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Chalkboard SE", size: 25.0)!]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonFired(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "City") as! CityViewController
        vc.city = selectedCity
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = pickerData[row]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

