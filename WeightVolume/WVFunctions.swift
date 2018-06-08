//
//  WVFunctions.swift
//  WeightVolume
//
//  Created by CHAO JIANG on 6/7/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import Foundation

class WVFunctions {
    
    // MARK: - field:
    var w: Double
    var r: Double
    var Gs: Double
    var rw: Double
    var e: Double
    var n: Double
    var S: Double
    var rd: Double
    var rsat: Double
//    var list : [Double]
    
    // MARK: - init
    init(w: Double, r: Double, Gs: Double, rw: Double, e: Double, n: Double, S: Double, rd: Double, rsat: Double) {
        self.w = w
        self.r = r
        self.Gs = Gs
        self.rw = rw
        self.e = e
        self.n = n
        self.S = S
        self.rd = rd
        self.rsat = rsat
    }
    
    // MARK: - method
    func getW() -> Double {
        return w
    }
    
    func getR() -> Double {
        if r == -1 {
            return ((1 + w) * rw * Gs)/(1 + e)
        } else {
            return r
        }
    }
    
    //Gs is constant
    func getGs() -> Double {
        return Gs
    }
    
    //rw is constant
    func getRw() -> Double {
        return rw
    }
    
    func getE() -> Double {
        if e == -1 {
            return (rw * Gs / rd) - 1
        } else {
            return e
        }
    }
    
    func getN() -> Double {
        if n == -1 {
            return e / (1 + e)
        } else {
            return n
        }
    }
    
    func getS() -> Double {
        if S == -1 {
            return w * Gs / e
        } else {
            return S
        }
    }
    
    func getRd() -> Double {
        if rd == -1 {
            return r / (1 + w)
        } else {
            return rd
        }
    }
    
    func getRsat() -> Double {
        if rsat == -1 {
            return (Gs + e) * rw / (1 + e)
        } else {
            return rsat
        }
    }
    
    // MARK: - output calculating:
    func startCalculating() {
        if Gs != -1 && e != -1  {
            rsat = getRsat()
        }
        if r != -1 && w != -1 {
            rd = getRd()
        }
        if w != -1  && Gs != -1 && e != -1 {
            S = getS()
            r = getR()
        }
        if e != -1 {
            n = getN()
        }
        if Gs != -1 && rd != -1 {
            e = getE()
        }
    }
    
}
