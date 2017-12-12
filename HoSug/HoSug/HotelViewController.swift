//
//  HotelViewController.swift
//  HoSug
//
//  Created by Dempsy on 11/12/2017.
//  Copyright © 2017 Bocer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HotelViewController: UIViewController {

    internal var hotelId: String?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alamofire.request(
            URL(string: "http://ec2-18-216-85-1.us-east-2.compute.amazonaws.com:3000/hotels")!,
            method: .post,
            parameters: ["hotel_id":hotelId!])
            .validate()
            .responseJSON {response in
                let result = response.result.value
                var json = JSON(result!)
                if(result != nil){
                    if(json["content"] == "success"){
                        self.name.text = json["hotel_name"].string!
                        self.address.text = json["hotel_address"].string!
                        self.rating.text = json["hotel_rating"].string! + "/5.0"
                        self.availability.text = "Only " + String(json["hotel_availability"].int!) + " Rooms Left!"
                    }
                }
        }
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let params: [String:String] = ["hotel_id":hotelId!]
        Alamofire.request(
            URL(string: "http://ec2-18-216-85-1.us-east-2.compute.amazonaws.com:3000/checkin")!,
            method: .post,
            parameters: params)
            .validate()
            .responseJSON {response in
                let result = response.result.value
                var json = JSON(result!)
                if(result != nil){
                    if(json["content"] == "success"){
                        let sb = UIStoryboard(name: "Main", bundle: nil);
                        let vc = sb.instantiateViewController(withIdentifier: "Reserve") as! ReservationViewController
                        vc.hotelId = self.hotelId
                        vc.modalTransitionStyle = .flipHorizontal
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Alert", message: "There is no room left :(", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
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
