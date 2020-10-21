//
//  DetailsVC.swift
//  Task
//
//  Created by Rohini Deo on 21/10/20.
//  Copyright © 2020 Taxgenie. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    //Mark:IBOutlets:
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var formatedAddress: UILabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var address: UILabel!
    
    //Mark:Properties:
    var strName = ""
    var strAddress = ""
    var strPhone = ""
    var strFormatedAddrs = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = self.strName
        self.formatedAddress.text = self.strFormatedAddrs
        self.phoneNo.text = self.strPhone
        self.address.text = self.strAddress
    }
    

}
