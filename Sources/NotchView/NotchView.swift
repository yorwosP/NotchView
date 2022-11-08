//
//  NotchView.swift
//  Notch View Project
//
//  Created by George Pallikaropoulos on 6/11/22.
//

import UIKit

class NotchView:UIView {
    


// MARK: - properties
    public var name:Name = .iPhone14Plus{
        didSet{
            setupView()
        }
    }
    
    public var color:UIColor = UIColor.black{
        didSet{
            self.backgroundColor = color
        }
    }

    public var radius:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = radius
        }
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {

        super.init(frame: frame)
        print("super was called with frame:\(frame)")
      
        
        setupView()

        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    

    
    private func setupView(){
    //private func setupView(name:Name, nativeScale:CGFloat){
        guard let name = Name(rawValue: UIDevice.current.name) else { return }
        let nativeScale = UIScreen.main.nativeScale
        guard let  metric = Metrics(name: name, nativeScale: nativeScale) else {
            print("cannot find metric for \(name.rawValue)")
            
            return
            
        }

        self.backgroundColor = color
        self.layer.cornerRadius = metric.bottomRadius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner] // which corners will be rounded
        self.frame = CGRect(origin: CGPoint(), size: metric.size)
        
        print("frame is:\(self.frame)")
        
        
    }
    
    
    

    
    

}



