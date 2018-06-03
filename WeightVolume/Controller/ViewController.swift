//
//  ViewController.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/2/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //declare variable here:
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet var messageTextFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set yourself as delegate of all text fields
        for tf in messageTextFields{
            tf.delegate = self
        }
        
        //set gesture:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        stackView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func stackViewTapped() {
        for tf in messageTextFields{
            if tf.isEditing == true {
                tf.endEditing(true)
            }
        }
    }

    @IBAction func infoButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        for tf in messageTextFields {
            tf.text = ""
        }
    }
    
}

