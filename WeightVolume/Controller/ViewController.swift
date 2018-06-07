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
    
    @IBOutlet weak var unitWeightWaterPicker: UIPickerView!
    let unitWeightWater = [9.8, 62.4]
    
    @IBOutlet var messageTextFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set yourself as delegate of all text fields
        for tf in messageTextFields{
            tf.delegate = self
        }
        
        //set yourself as delegate of pickerview
        unitWeightWaterPicker.delegate = self
        unitWeightWaterPicker.dataSource = self
        
        //set gesture for stackview so that we can handle keyboard hidding problem:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        stackView.addGestureRecognizer(tapGesture)
        
        //default unit weight water data and default picker is hidden:
        messageTextFields[3].text = String(unitWeightWater[0])
        unitWeightWaterPicker.isHidden = true
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
    
    
    
    // MARK: - submit and reset button pressed:

    @IBAction func infoButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        for tf in messageTextFields {
            tf.text = ""
        }
    }
    
}

// MARK: - picker view delegate and datasource method:

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    //set number of components in picker view:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //set number of rows in each components:
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitWeightWater.count
    }
    //set each title of each rows to be displayed:
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(unitWeightWater[row])
    }
    //row is selected:
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        messageTextFields[3].text = String(unitWeightWater[row])
        unitWeightWaterPicker.isHidden = true
    }
    //hiding picker view when not using:
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == messageTextFields[3] {
            unitWeightWaterPicker.isHidden = false
            return false
        }
        return true
    }
}

