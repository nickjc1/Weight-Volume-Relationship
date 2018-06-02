//
//  ViewController.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/2/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func infoButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    
}

