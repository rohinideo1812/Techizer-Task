//
//  ViewController.swift
//  Task
//
//  Created by Rohini Deo on 21/10/20.
//  Copyright © 2020 Taxgenie. All rights reserved.
//

import UIKit

struct JsonStruct:Decodable {
    var result : PlaceDetails
}

struct PlaceDetails : Decodable{
    let adr_address : String?
    let formatted_phone_number : String?
    let formatted_address : String?
    let place_id : String?
}

class ViewController: UIViewController,UITextFieldDelegate {
    
    //Mark:IBOutlets:
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var placeTxtField: UITextField!
    @IBOutlet weak var dobTxtField: UITextField!
    @IBOutlet weak var mobileNoTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var submtBtn: UIButton!
    
    var placeData : JsonStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeTxtField.delegate = self
        addLayer()
    }
    
    private func addLayer() {
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 125, startAngle: 0, endAngle: .pi, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.75
        let path1 = UIBezierPath(arcCenter: CGPoint(x: 0, y: self.view.frame.height), radius: 125, startAngle: 0, endAngle: .pi, clockwise: false)
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.blue.cgColor
        shapeLayer1.shadowColor = UIColor.black.cgColor
        shapeLayer1.shadowOpacity = 0.75
        view.layer.addSublayer(shapeLayer)
        view.layer.addSublayer(shapeLayer1)
        self.baseView.layer.shadowColor = UIColor.black.cgColor
        self.baseView.layer.shadowOpacity = 0.20
        self.imgView.layer.shadowColor = UIColor.black.cgColor
        self.imgView.layer.shadowOpacity = 0.20
        self.nameTxtField.layer.shadowColor = UIColor.black.cgColor
        self.nameTxtField.layer.shadowOpacity = 0.10
        self.dobTxtField.layer.shadowColor = UIColor.black.cgColor
        self.dobTxtField.layer.shadowOpacity = 0.10
        self.mobileNoTxtField.layer.shadowColor = UIColor.black.cgColor
        self.mobileNoTxtField.layer.shadowOpacity = 0.10
        self.placeTxtField.layer.shadowColor = UIColor.black.cgColor
        self.placeTxtField.layer.shadowOpacity = 0.10
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        if nameTxtField.text!.isEmpty || placeTxtField.text!.isEmpty || dobTxtField.text!.isEmpty || mobileNoTxtField.text!.isEmpty{
            let alert = UIAlertController(title: title, message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {handler in
              
            }))
            self.present(alert, animated: true)
        }else{
        let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailsVC") as! DetailsVC
        detailVC.strName = self.nameTxtField.text!
        detailVC.strAddress = self.placeData?.result.adr_address as! String
        detailVC.strFormatedAddrs = self.placeData?.result.formatted_address as! String
        detailVC.strPhone = self.placeData?.result.formatted_phone_number as! String
        self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPlaceFromGoogle(place:textField.text!)
        return true
    }
    
    func searchPlaceFromGoogle(place:String){
        var strGoogleAPI = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?name=\(place)&key=AIzaSyAii5vsLzAuGAqfX8vC7TQwB1wqvmZmYww"
        strGoogleAPI = strGoogleAPI.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var url = URLRequest(url: URL(string: strGoogleAPI)!)
        url.httpMethod = "GET"
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            do{
                if error == nil{
                    let arrData = try JSONDecoder().decode(JsonStruct.self, from: data!)
                    self.placeData = arrData
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//{
//   "html_attributions" : [],
//   "result" : {
//      "address_components" : [
//         {
//            "long_name" : "5",
//            "short_name" : "5",
//            "types" : [ "floor" ]
//         },
//         {
//            "long_name" : "48",
//            "short_name" : "48",
//            "types" : [ "street_number" ]
//         },
//         {
//            "long_name" : "Pirrama Road",
//            "short_name" : "Pirrama Rd",
//            "types" : [ "route" ]
//         },
//         {
//            "long_name" : "Pyrmont",
//            "short_name" : "Pyrmont",
//            "types" : [ "locality", "political" ]
//         },
//         {
//            "long_name" : "Council of the City of Sydney",
//            "short_name" : "Sydney",
//            "types" : [ "administrative_area_level_2", "political" ]
//         },
//         {
//            "long_name" : "New South Wales",
//            "short_name" : "NSW",
//            "types" : [ "administrative_area_level_1", "political" ]
//         },
//         {
//            "long_name" : "Australia",
//            "short_name" : "AU",
//            "types" : [ "country", "political" ]
//         },
//         {
//            "long_name" : "2009",
//            "short_name" : "2009",
//            "types" : [ "postal_code" ]
//         }
//      ],
//      "adr_address" : "5, \u003cspan class=\"street-address\"\u003e48 Pirrama Rd\u003c/span\u003e, \u003cspan class=\"locality\"\u003ePyrmont\u003c/span\u003e \u003cspan class=\"region\"\u003eNSW\u003c/span\u003e \u003cspan class=\"postal-code\"\u003e2009\u003c/span\u003e, \u003cspan class=\"country-name\"\u003eAustralia\u003c/span\u003e",
//      "formatted_address" : "5, 48 Pirrama Rd, Pyrmont NSW 2009, Australia",
//      "formatted_phone_number" : "(02) 9374 4000",
//      "geometry" : {
//         "location" : {
//            "lat" : -33.866651,
//            "lng" : 151.195827
//         },
//         "viewport" : {
//            "northeast" : {
//               "lat" : -33.8653881697085,
//               "lng" : 151.1969739802915
//            },
//            "southwest" : {
//               "lat" : -33.86808613029149,
//               "lng" : 151.1942760197085
//            }
//         }
//      },
//      "icon" : "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
//      "id" : "4f89212bf76dde31f092cfc14d7506555d85b5c7",
//      "international_phone_number" : "+61 2 9374 4000",
//      "name" : "Google",
//      "place_id" : "ChIJN1t_tDeuEmsRUsoyG83frY4",
//      "rating" : 4.5,
//      "reference" : "CmRSAAAAjiEr2_A4yI-DyqGcfsceTv-IBJXHB5-W3ckmGk9QAYk4USgeV8ihBcGBEK5Z1w4ajRZNVAfSbROiKbbuniq0c9rIq_xqkrf_3HpZzX-pFJuJY3cBtG68LSAHzWXB8UzwEhAx04rgN0_WieYLfVp4K0duGhTU58LFaqwcaex73Kcyy0ghYOQTkg",
//      "reviews" : [
//         {
//            "author_name" : "Robert Ardill",
//            "author_url" : "https://www.google.com/maps/contrib/106422854611155436041/reviews",
//            "language" : "en",
//            "profile_photo_url" : "https://lh3.googleusercontent.com/-T47KxWuAoJU/AAAAAAAAAAI/AAAAAAAAAZo/BDmyI12BZAs/s128-c0x00000000-cc-rp-mo-ba1/photo.jpg",
//            "rating" : 5,
//            "relative_time_description" : "a month ago",
//            "text" : "Awesome offices. Great facilities, location and views. Staff are great hosts",
//            "time" : 1491144016
//         }
//      ],
//      "types" : [ "point_of_interest", "establishment" ],
//      "url" : "https://maps.google.com/?cid=10281119596374313554",
//      "utc_offset" : 600,
//      "vicinity" : "5, 48 Pirrama Road, Pyrmont",
//      "website" : "https://www.google.com.au/about/careers/locations/sydney/"
//   },
//   "status" : "OK"
//}
      
