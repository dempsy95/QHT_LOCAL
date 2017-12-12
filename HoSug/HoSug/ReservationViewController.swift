//
//  ReservationViewController.swift
//  HoSug
//
//  Created by Dempsy on 11/12/2017.
//  Copyright © 2017 Bocer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReservationViewController: UIViewController {

    internal var hotelId: String?
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 10
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        let params: [String:String] = ["hotel_id":hotelId!]
        Alamofire.request(
            URL(string: "http://ec2-18-216-85-1.us-east-2.compute.amazonaws.com:3000/checkout")!,
            method: .post,
            parameters: params)
            .validate()
            .responseJSON {response in
                let result = response.result.value
                var json = JSON(result!)
                if(result != nil){
                    if(json["content"] == "success"){
                        self.dismiss(animated: true, completion: nil)
                    }
                }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
