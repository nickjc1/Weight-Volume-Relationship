//
//  ViewController.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/2/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - declare variable here
    let realm = try! Realm()
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var unitWeightWaterPicker: UIPickerView!
    let unitWeightWater = [62.4, 9.8]
    @IBOutlet weak var unit: UILabel!
    let unitList = ["lb/ft3", "kN/m3"]
    @IBOutlet var messageTextFields: [UITextField]!
    
    // MARK: - viewDidLoad()
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
    
    // MARK: - tapping stackview to hide keyboard
    @objc func stackViewTapped() {
        for tf in messageTextFields{
            if tf.isEditing == true {
                tf.endEditing(true)
            }
        }
    }
    
    // MARK: - button pressed
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToInfo", sender: self)
    }
    
    @IBAction func historyButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToHistory", sender: self)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        for tf in messageTextFields {
            tf.text = ""
            tf.backgroundColor = UIColor.white
        }
        messageTextFields[3].text = String(unitWeightWater[0])
        unit.text = unitList[0]
    }
    
    // MARK: - textFieldDidBeginEditing() to reset the background color of the textfield to white
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for tf in messageTextFields {
            tf.backgroundColor = UIColor.white
        }
    }
}

// MARK: - calculating

extension ViewController {
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        //first check if all textfields are blank.
        //second check if input is valid.
        //if so, nothing will happen, else start calculating and save results
        var textFieldsAreEmpty = true
        for i in 0..<messageTextFields.count {
            if messageTextFields[i].text?.isEmpty == false && i != 3 {
                textFieldsAreEmpty = textFieldsAreEmpty && false
                break
            }
        }
        if !textFieldsAreEmpty {
            //Convert String to double
            var data = [Double](repeating: 0, count: messageTextFields.count)
            for i in 0..<messageTextFields.count {
                
                if messageTextFields[i].text == "" {
                    data[i] = -1
                    continue
                }
                guard let mydata = Double(messageTextFields[i].text!) else {
                    return
                }
                data[i] = mydata
            }
            
            //create a instance of WVFunctions and start calculating:
            let solvingProblem = WVFunctions(w: data[0], r: data[1], Gs: data[2], rw: data[3], e: data[5], n: data[6], S: data[7], rd: data[4], rsat: data[8])
            
            var count = 0
            
            while count < 100 && !solvingProblem.areAllSolved() {
                solvingProblem.calculating()
                count += 1
            }
            
            //make precision of 2 digits after float point
            solvingProblem.roundTo2DigitalPrecisionAndCheckIsNaN()
            
            messageTextFields[0].text = String(solvingProblem.w)
            messageTextFields[1].text = String(solvingProblem.r)
            messageTextFields[2].text = String(solvingProblem.Gs)
            messageTextFields[3].text = String(solvingProblem.rw)
            messageTextFields[4].text = String(solvingProblem.rd)
            messageTextFields[5].text = String(solvingProblem.e)
            messageTextFields[6].text = String(solvingProblem.n)
            messageTextFields[7].text = String(solvingProblem.S)
            messageTextFields[8].text = String(solvingProblem.rsat)
            
            // MARK: - if all solved, create an instance of the Realm database object and save data by summit button pressed; else mark unsolved variables textfield into yellow
            if solvingProblem.areAllSolved() {
                let result = ResultDetail()
                result.e = solvingProblem.e
                result.Gs = solvingProblem.Gs
                result.n = solvingProblem.n
                result.r = solvingProblem.r
                result.rd = solvingProblem.rd
                result.rsat = solvingProblem.rsat
                result.rw = solvingProblem.rw
                result.S = solvingProblem.S
                result.w = solvingProblem.w
                
                result.createdTime = Date()
                
                do {
                    try realm.write {
                        realm.add(result)
                    }
                } catch {
                    print("error saving result into database \(error)")
                }
            } else {
                //if any field did not get the result, turns it to yellow
                for tf in messageTextFields {
                    if tf.text == "-1.0" {
                        tf.backgroundColor = UIColor.flatSand()
                        tf.text = ""
                    }
                }
            }
        }
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

