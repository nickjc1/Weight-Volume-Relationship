//
//  DetailViewController.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/19/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Declare variables here
    var delegate: UIViewController?
    var resultDetail: ResultDetail?
    
    @IBOutlet weak var w: UILabel!
    @IBOutlet weak var r: UILabel!
    @IBOutlet weak var Gs: UILabel!
    @IBOutlet weak var rw: UILabel!
    @IBOutlet weak var rd: UILabel!
    @IBOutlet weak var e: UILabel!
    @IBOutlet weak var n: UILabel!
    @IBOutlet weak var S: UILabel!
    @IBOutlet weak var rsat: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Display the history result
        
        if let theResultDetail = resultDetail {
            w.text = String(theResultDetail.w)
            r.text = String(theResultDetail.r)
            Gs.text = String(theResultDetail.Gs)
            rw.text = String(theResultDetail.rw)
            rd.text = String(theResultDetail.rd)
            e.text = String(theResultDetail.e)
            n.text = String(theResultDetail.n)
            S.text = String(theResultDetail.S)
            rsat.text = String(theResultDetail.rsat)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
