//
//  ViewController.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/2/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - declare variable here
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var unitWeightWaterPicker: UIPickerView!
    let unitWeightWater = [9.8, 62.4]
    @IBOutlet weak var unit: UILabel!
    let unitList = ["kN/m3", "lb/ft3"]
    @IBOutlet var messageTextFields: [UITextField]!
    
    // MARK: - viewDidLoad() and didReceiveMemoryWarning()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set yourself as delegate of all text fields
        for tf in messageTextFields{
            tf.delegate = self
            tf.text = ""
        }
        
        //set yourself as delegate of pickerview
        unitWeightWaterPicker.delegate = self
        unitWeightWaterPicker.dataSource = self
        
        //set gesture for stackview so that we can handle keyboard hidding problem:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        stackView.addGestureRecognizer(tapGesture)
        
        //default unit weight water data and unit and default picker is hidden:
        messageTextFields[3].text = String(unitWeightWater[0])
        unit.text = unitList[0]
        unitWeightWaterPicker.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tapping stackview to hide keyboard
    
    @objc func stackViewTapped() {
        for tf in messageTextFields{
            if tf.isEditing == true {
                tf.endEditing(true)
            }
        }
    }
    
    // MARK: - button pressed

    @IBAction func infoButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        for tf in messageTextFields {
            tf.text = ""
        }
        messageTextFields[3].text = String(unitWeightWater[0])
        unit.text = unitList[0]
    }
    
    // MARK: - calculating
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        //Convert String to double
        var data = [Double](repeating: 0, count: messageTextFields.count)
        for i in 0..<messageTextFields.count {
            if messageTextFields[i].text == "" {
                data[i] = -1
            } else {
                data[i] = Double(messageTextFields[i].text!)!
            }
        }
        
        let solvingProblem = WVFunctions(w: data[0], r: data[1], Gs: data[2], rw: data[3], e: data[5], n: data[6], S: data[7], rd: data[4], rsat: data[8])
        
        for _ in 1...10 {
            solvingProblem.startCalculating()
        }
        
        messageTextFields[0].text = String(solvingProblem.w)
        messageTextFields[1].text = String(solvingProblem.r)
        messageTextFields[2].text = String(solvingProblem.Gs)
        messageTextFields[3].text = String(solvingProblem.rw)
        messageTextFields[4].text = String(solvingProblem.rd)
        messageTextFields[5].text = String(solvingProblem.e)
        messageTextFields[6].text = String(solvingProblem.n)
        messageTextFields[7].text = String(solvingProblem.S)
        messageTextFields[8].text = String(solvingProblem.rsat)
        
    }
    
    
}

// MARK: - picker view delegate and datasource method

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
        unit.text = unitList[row]
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

