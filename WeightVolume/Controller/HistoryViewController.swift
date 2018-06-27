//
//  HistoryViewController.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/18/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class HistoryViewController: UIViewController {

    //declare variable:
    @IBOutlet weak var historyTableView: UITableView!
    let realm = try! Realm()
    var rowOfSelectedCell: Int = -1
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        //set delegate and dataSource
        historyTableView.delegate = self;
        historyTableView.dataSource = self;
        
        //increase cell height
        historyTableView.rowHeight = 80
        
        //set tableview background transparent
        historyTableView.backgroundColor = UIColor.clear
    }

}

// MARK: - tableView delegate, datasource

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return realm.objects(ResultDetail.self).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "relationshipCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.backgroundColor = UIColor.clear
        
        let date = realm.objects(ResultDetail.self)[realm.objects(ResultDetail.self).count - 1 - indexPath.row].createdTime
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.textLabel?.text = formatter.string(from: date!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowOfSelectedCell = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.delegate = self
            
            let numOfDatas = realm.objects(ResultDetail.self).count
            destinationVC.resultDetail = realm.objects(ResultDetail.self)[numOfDatas - 1 - rowOfSelectedCell]
        }
    }
}

// MARK: - delete data by swipe tableview cell delegate

extension HistoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "delete") {
            (action, indexPath) in
            self.deleteResult(indexPath: indexPath)
        }
        deleteAction.image = UIImage(named: "Trash-Icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var option = SwipeTableOptions()
        option.expansionStyle = .destructive
        option.transitionStyle = .border
        
        return option
    }
    
    func deleteResult(indexPath: IndexPath) {
        let result = realm.objects(ResultDetail.self)[indexPath.row]
        do {
            try realm.write {
                realm.delete(result)
            }
        } catch {
            print("error deleting data \(error)")
        }
    }
}
