//
//  Name.swift
//  NotchView
//
//  Created by George Pallikaropoulos on 6/11/22.
//

import Foundation
public enum Name:String{
    case iPhoneX = "iPhone X"
    case iPhoneXR = "iPhone Xʀ"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhone12 = "iPhone 12"
    case iPhone12Mini = "iPhone 12 mini"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone13 = "iPhone 13"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhone14 = "iPhone 14"
    case iPhone14Plus = "iPhone 14 Plus"
    // MAYBE use these at a later version
//    case undefined
//    case uninitializedLoadedFromStoryboard
}


extension Name{
    
    // for simulator cases
    init? (_ value:String){
        var _name:String
        if value.contains("Simulator "){
            _name = value.replacingOccurrences(of: "Simulator ", with: "")
        
          
        }else{
            _name = value
        }
        print("name is:\(_name)")
        guard let name = Name.init(rawValue: _name) else{
            return nil
        }
        self = name

    }
}
