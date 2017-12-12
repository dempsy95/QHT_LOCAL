//
//  CityViewController.swift
//  HoSug
//
//  Created by Dempsy on 10/12/2017.
//  Copyright © 2017 Bocer. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    internal var city : String?
    private var tableData: [Hotel] = [Hotel]()
    var search_result:[Dictionary<String, String>] = []

    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = city!
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let params: [String:String] = ["hotel_city":city!]
        Alamofire.request(
            URL(string: "http://ec2-18-216-85-1.us-east-2.compute.amazonaws.com:3000/cities")!,
            method: .post,
            parameters: ["hotel_city":city!])
            .validate()
            .responseJSON {response in
                let result = response.result.value
                var json = JSON(result!)
                if(result != nil){
                    if(json["content"] != "fail"){
                        self.search_result.removeAll()
                        for item in json["content"].array! {
                            var temp = [String:String]()
                            temp["name"] = item["name"].string!
                            temp["id"] = item["id"].string!
                            if(item["address"] == JSON.null){
                                temp["address"] = "no address for this hotel"
                            }
                            else{
                                temp["address"] = item["address"].string!
                            }
                            self.search_result.append(temp)
                        }
                        self.cityTableView.reloadData()
                    }
                }
        }
        
        // TODO: Delete it after server is on
//        for _ in [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18] {
//            var temp = [String:String]()
//            temp["name"] = "Marriott"
//            temp["id"] = "1"
//            temp["address"] = "2301 Vanderbilt Place, PMB 357133"
//            self.search_result.append(temp)
//        }
        self.cityTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //cancel button is fired, go back to initial view controller
    @objc private func onCancel(){
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.search_result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify: String = "city"
        let cell = tableView.dequeueReusableCell(withIdentifier: identify)

        cell?.detailTextLabel?.text = self.search_result[indexPath.row]["address"]
        cell?.textLabel?.text = self.search_result[indexPath.row]["name"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "Hotel") as! HotelViewController
        vc.hotelId = self.search_result[indexPath.row]["id"]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
