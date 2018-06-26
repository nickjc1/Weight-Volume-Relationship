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
    var variableList : [Double]
    
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
        variableList = [self.w, self.r, self.Gs,self.rw, self.e, self.n, self.S, self.rd, self.rsat]
    }
    
    // MARK: - getW()
    func getW() -> Double {
        if w == -1 {
            print("get into getW()")
            //from r set
            if r != -1 && Gs != -1 && e != -1 {
                return ((1 + e)*r)/(Gs*rw) - 1
            }
            if r != -1 && Gs != -1 && S != -1 {
                return (Gs*rw - r)/((r*Gs/S) - Gs*rw)
            }
            if Gs != -1 && n != -1 && r != -1 {
                return r/(Gs*rw*(1 - n)) - 1
            }
            //from rd set
            if r != -1 && rd != -1 {
                return r/rd - 1
            }
            if Gs != -1 && S != -1 && rd != -1 {
                return S*(Gs*rw/rd - 1)/Gs
            }
            if e != -1 && S != -1 && rd != -1 {
                return (e*S*rw)/((1 + e)*rd)
            }
            
            print("no function works for getW()")
            return -1
        } else {
            return w
        }
    }
    
    // MARK: - getR()
    func getR() -> Double {
        if r == -1 {
            print("get in to getR()")
            //from r set
            if w != -1 && Gs != -1 && e != -1 {
                return ((1 + w)*Gs*rw)/(1 + e)
            }
            if S != -1 && Gs != -1 && e != -1{
                return ((Gs + S*e)*rw)/(1 + e)
            }
            if w != -1 && Gs != -1 && S != -1 {
                return ((1 + w)*Gs*rw)/(1 + w*Gs/S)
            }
            if w != -1 && Gs != -1 && n != -1{
                return Gs*rw*(1 - n)*(1 + w)
            }
            if S != -1 && Gs != -1 && n != -1{
                return Gs*rw*(1 - n) + n*S*rw
            }
            //from rd set
            if rd != -1 && w != -1 {
                return rd*(1 + w)
            }
                
            print("no function works for getR()")
            return -1
        } else {
            return r
        }
    }
    
    // MARK: - getGs()
    func getGs() -> Double {
        if Gs == -1 {
            print("get into getGs()")
            //from r set
            if r != -1 && w != -1 && e != -1 {
                return ((1 + e)*r)/((1 + w)*rw)
            }
            if r != -1 && S != -1 && e != -1 {
                return ((1 + e)*r)/rw - S*e
            }
            if r != -1 && w != -1 && S != -1 {
                return r/((1 + w)*rw - r*w/S)
            }
            if w != -1 && n != -1 && r != -1 {
                return r/(rw*(1 - n)*(1 + w))
            }
            if S != -1 && n != -1 && r != -1 {
                return (r - n*S*rw)/(rw*(1 - n))
            }
            //from rd set
            if rd != -1 && e != -1 {
                return (1 + e)*rd/rw
            }
            if n != -1 && rd != -1 {
                return rd/rw*(1 - n)
            }
            if w != -1 && S != -1 && rd != -1 {
                return rd/(rw - (rd*w/S))
            }
            if rsat != -1 && rd != -1 {
                return rd/(rd - rsat + rw)
            }
            //from rsat set
            if e != -1 && rsat != -1 {
                return ((1 + e)*rsat)/rw - e
            }
            if n != -1 && rsat != -1 {
                return (rsat/rw - n)/(1 - n)
            }
            print("no function works for getGs()")
            return -1
        } else {
            return Gs
        }
    }
    
    // MARK: - getRw()
    func getRw() -> Double {
        return rw
    }
    
    // MARK: - getE()
    func getE() -> Double {
        if e == -1 {
            print("get into getE()")
            //from r set
            if r != -1 && w != -1 && Gs != -1 {
                return (1 + w)*Gs*rw/r - 1
            }
            if r != -1 && S != -1 && Gs != -1 {
                return (Gs*rw - r)/(r - S*rw)
            }
            //from rd set
            if rd != -1 && Gs != -1 {
                return Gs*rw/rd - 1
            }
            if w != -1 && S != -1 && rd != -1 {
                return rd/(S*rw - w*rd)
            }
            if rsat != -1 && rd != -1 {
                return (rsat - rd)/(rd - rsat + w)
            }
            //from rsat set
            if Gs != -1 && rsat != -1 {
                return (Gs*rw - rsat)/(rsat - rw)
            }
            print("no function works for getE()")
            return -1
        } else {
            return e
        }
    }
    
    // MARK: - getN()
    func getN() -> Double {
        if n == -1 {
            print("get into getN()")
            //from r set
            if w != -1 && Gs != -1 && r != -1 {
                return 1 - r/Gs*rw*(1 + w)
            }
            if S != -1 && Gs != -1 && r != -1 {
                return (r - Gs*rw)/(S*rw - Gs*rw)
            }
            //from rd set
            if Gs != -1 && rd != -1 {
                return 1 - rd/Gs*rw
            }
            if rsat != -1 && rd != -1 {
                return (rsat - rd)/rw
            }
            //from rsat set
            if Gs != -1 && rsat != -1 {
                return (rsat/rw - Gs)/(1 - Gs)
            }
            
            print("no functions works for getN()")
            return -1
        } else {
            return n
        }
    }
    
    // MARK: - getS()
    func getS() -> Double {
        if S == -1 {
            print("get into getS()")
            //from r set
            if r != -1 && Gs != -1 && e != -1 {
                return ((1 + e)*r/rw - Gs)/e
            }
            if r != -1 && w != -1 && Gs != -1 {
                return (r*w*Gs)/((1 + w)*Gs*rw - r)
            }
            if Gs != -1 && n != -1 && r != -1 {
                return (r - Gs*rw*(1 - n))/n*rw
            }
            //from rd set
            if Gs != -1 && w != -1 && rd != -1 {
                return w*Gs/(Gs*rw/rd - 1)
            }
            if e != -1 && w != -1 && rd != -1 {
                return (rd*(1 + e)*w)/(e*rw)
            }
            
            print("no function works for getS()")
            return -1
        } else {
            return S
        }
    }
    
    // MARK: - getRd()
    func getRd() -> Double {
        if rd == -1 {
            print("get into getRd()")
            // from rd set
            if r != -1 && w != -1 {
                return r/(1 + w)
            }
            if Gs != -1 && e != -1 {
                return Gs*rw/(1 + e)
            }
            if Gs != -1 && n != -1 {
                return Gs*rw*(1 - n)
            }
            if Gs != -1 && w != -1 && S != -1 {
                return Gs*rw/(1 + w*Gs/S)
            }
            if e != -1 && w != -1 && S != -1 {
                return e*S*rw/(1 + e)*w
            }
            if rsat != -1 && e != -1 {
                return rsat - e*rw/(1 + e)
            }
            if rsat != -1 && n != -1 {
                return rsat - n*rw
            }
            if rsat != -1 && Gs != -1 {
                return (rsat - rw)*Gs/(Gs - 1)
            }
            
            print("no function works for getRd()")
            return -1
        } else {
            return rd
        }
    }
    
    // MARK: - getRsat()
    func getRsat() -> Double {
        if rsat == -1 {
            print("get into getRsat")
            //from rd set
            if e != -1 && rd != -1 {
                return rd + e*rw/(1 + e)
            }
            if n != -1 && rd != -1 {
                return rd + n*rw
            }
            if Gs != -1 && rd != -1 {
                return rd*(Gs - 1)/Gs + rw
            }
            //from rsat set
            if Gs != -1 && e != -1 {
                return (Gs + e)*rw/(1 + e)
            }
            if Gs != -1 && n != -1 {
                return ((1 - n)*Gs + n)*rw
            }
            print("no function works for getRsat()")
            return -1
        } else {
            return rsat
        }
    }
    
    // MARK: - calculating:
    func calculating() {
        w = getW()
        r = getR()
        Gs = getGs()
        rw = getRw()
        e = getE()
        n = getN()
        S = getS()
        rd = getRd()
        rsat = getRsat()
        variableList = [w, r, Gs, rw, e, n, S, rd, rsat]
    }
    
    // MARK: - check if all veriable solved
    func areAllSolved() -> Bool {
        var isSolved = true
        for varib in variableList {
            if varib == -1 {
                isSolved = isSolved && false
                break
            }
        }
        return isSolved
    }
    
    // MARK: - round a double to 2 digits precision and check if any isNaN()
    func roundTo2DigitalPrecisionAndCheckIsNaN() {
        variableList = [w, r, Gs, rw, rd, e, n, S, rsat]
        
        for i in 0..<variableList.count {
            if variableList[i].isNaN {
                variableList[i] = -1
            } else if variableList[i] != -1 {
                variableList[i] = Double(round(variableList[i]*100)/100)
            }
            
        }
        
        w = variableList[0]
        r = variableList[1]
        Gs = variableList[2]
        rw = variableList[3]
        rd = variableList[4]
        e = variableList[5]
        n = variableList[6]
        S = variableList[7]
        rsat = variableList[8]
    }
    
}
