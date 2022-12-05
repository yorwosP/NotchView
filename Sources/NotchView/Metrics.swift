//
//  Metrics.swift
//  Notch View Project
//
//  Created by George Pallikaropoulos on 6/11/22.
//

import Foundation


struct Metrics{
    internal let name:Name
    internal let PPI: CGFloat
    internal let notchWidthInMM: CGFloat
    internal let notchHeightInMM: CGFloat
    internal let notchBottomRadiusInMM: CGFloat
    internal let nativeScale:CGFloat
    
    private (set) var size:CGSize = CGSize()
    private (set) var bottomRadius:CGFloat = CGFloat()
    //TODO: - add top radius as well
    
//    init(name: Name,
//         PPI: CGFloat,
//         notchWidthInMM: CGFloat,
//         notchHeightInMM: CGFloat,
//         notchBottomRadiusInMM: CGFloat,
//         nativeScale: CGFloat) {
//
//
//        self.name = name
//        self.PPI = PPI
//        self.notchWidthInMM = notchWidthInMM
//        self.notchHeightInMM = notchHeightInMM
//        self.notchBottomRadiusInMM = notchBottomRadiusInMM
//        self.nativeScale = nativeScale
//    }
    
    
    init?(name: Name, nativeScale:CGFloat) {
        self.name = name
        // TODO: add the option to use a notch different from the current model
//        self.nativeScale = UIScreen.main.nativeScale
        self.nativeScale = nativeScale
        
        switch name{
        
        case .iPhoneX:
            self.PPI = 458
            self.notchWidthInMM = 34.0
            self.notchHeightInMM = 4.99
            self.notchBottomRadiusInMM = 3.22
        
        case .iPhoneXR:
            self.PPI = 326
            self.notchWidthInMM = 35.96
            self.notchHeightInMM = 5.15
            self.notchBottomRadiusInMM = 3.90
        
        case .iPhoneXS:
            self.PPI = 458
            self.notchWidthInMM = 34.03
            self.notchHeightInMM = 4.99
            self.notchBottomRadiusInMM = 3.19
        
        case .iPhoneXSMax:
            self.PPI = 458
            self.notchWidthInMM = 34.0
            self.notchHeightInMM = 4.99
            self.notchBottomRadiusInMM = 3.19
        
        case .iPhone11:
            self.PPI = 326
            self.notchWidthInMM = 35.96
            self.notchHeightInMM = 5.57
            self.notchBottomRadiusInMM = 3.90
        
        case .iPhone11Pro:
            self.PPI = 458
            self.notchWidthInMM = 34.80
            self.notchHeightInMM = 4.99
            self.notchBottomRadiusInMM = 3.59
        
        case .iPhone11ProMax:
            self.PPI = 458
            self.notchWidthInMM = 34.80
            self.notchHeightInMM = 4.99
            self.notchBottomRadiusInMM = 3.59
        
        case .iPhone12:
            self.PPI = 460
            self.notchWidthInMM = 34.83
            self.notchHeightInMM = 5.30
            self.notchBottomRadiusInMM = 3.80
        
        case .iPhone12Mini:
            self.PPI = 476
            self.notchWidthInMM = 34.83
            self.notchHeightInMM = 5.30
            self.notchBottomRadiusInMM = 3.80
        
        case .iPhone12Pro:
            self.PPI = 460
            self.notchWidthInMM = 34.83
            self.notchHeightInMM = 5.30
            self.notchBottomRadiusInMM = 3.80
        
        case .iPhone12ProMax:
            self.PPI = 458
            self.notchWidthInMM = 34.83
            self.notchHeightInMM = 5.32
            self.notchBottomRadiusInMM = 3.80
        
        case .iPhone13:
            self.PPI = 460
            self.notchWidthInMM = 26.79
            self.notchHeightInMM = 5.58
            self.notchBottomRadiusInMM = 3.80
        case .iPhone13Mini:
            self.PPI = 476
            self.notchWidthInMM = 26.78
            self.notchHeightInMM =  5.7
            self.notchBottomRadiusInMM = 3.57
        
        case .iPhone13Pro:
            self.PPI = 460
            self.notchWidthInMM = 26.79
            self.notchHeightInMM = 5.58
            self.notchBottomRadiusInMM = 3.80
        
        case .iPhone13ProMax:
            self.PPI = 458
            self.notchWidthInMM = 26.83
            self.notchHeightInMM = 5.60
            self.notchBottomRadiusInMM = 3.80
        
        case .iPhone14:
            self.PPI = 460
            self.notchWidthInMM = 26.79
            self.notchHeightInMM = 5.58
            self.notchBottomRadiusInMM = 3.72
        case .iPhone14Plus:
            self.PPI = 458
            self.notchWidthInMM = 26.83
            self.notchHeightInMM = 5.60
            self.notchBottomRadiusInMM = 3.71

        }
        
        self.size = CGSize(width: pointsFrom(milimeters: notchWidthInMM), height: pointsFrom(milimeters: notchHeightInMM))
        self.bottomRadius = pointsFrom(milimeters: notchBottomRadiusInMM)
        
        
        
        
        
        

    }
                      
                      
  //MARK: - helper functions
    private func inchesFrom(milimeters:Double) -> Double{
        return milimeters/25.4
    }
    
    private func pointsFrom(milimeters: CGFloat) -> CGFloat{
        // convert to inches
        
        let inches = inchesFrom(milimeters: milimeters)
        // convert inches to point based on PPI
        let pixels = inches * PPI
        print("received :\(milimeters) mm -> \(inches) inches -> \(pixels):pixels, \(pixels/nativeScale) points")

        return pixels/nativeScale
        
    }

    

        

    
    
}
