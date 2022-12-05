//
//  ViewController.swift
//  NotchViewExample
//
//  Created by George Pallikaropoulos on 13/11/22.
//

import UIKit
import NotchView

class ViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var backgroundView: UIView!
    
    // MARK: private properties
    


    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var isExpansionCompleted = false{
        didSet{
            // we want to allow tapping only when expansion is completed
            // and panning when not
            panGestureRecognizer.isEnabled = !isExpansionCompleted
            tapGestureRecognizer.isEnabled = isExpansionCompleted

        }
    }
    private var currentSliderValue = Float()
    private var notch:Notch!
    private var test:String?
    private var slider:UISlider?
    private var initialTouchPosition:CGPoint?
    private var maxExpansion = CGFloat()
    private var initialRadius:CGFloat!
    private var notchInitialSize:CGSize!
    private var widthConstraint:NSLayoutConstraint!
    private var heightConstraint:NSLayoutConstraint!
    
    private var timer:Timer?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = UIApplication.shared.windows[0]
            print("window:\(window.safeAreaInsets.bottom) \(window.safeAreaInsets.top)")
        
        print("starting yp")
        setupRecognizers()
        setupView()
        setupSlider()

        

    }
    
    
    //MARK: - Setup methods
    
    
    private func setupView(){
        print("setting up view")
//        if Notch.isNotchAvailable == false{
//            print("cannot get notch for device:\(UIDevice.current.name)")
//        }else{
//            print("can create notch")
//        }
        notch = Notch()
        print("notch is :\(notch.frame)")
    
        notch.backgroundColor = .red
        notch.accessibilityIdentifier = "Notch View"
        view.addSubview(notch)
        initialRadius = notch.radius // radius changes as we expand so we keep initial radius for when we return back
        notchInitialSize = notch.bounds.size
        notch.translatesAutoresizingMaskIntoConstraints = false
        
        widthConstraint =  notch.widthAnchor.constraint(equalToConstant: notchInitialSize.width)
        widthConstraint.isActive = true
        heightConstraint = notch.heightAnchor.constraint(equalToConstant: notchInitialSize.height)
        heightConstraint.isActive = true
        notch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notch.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        view.layoutIfNeeded()
        
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(tapGestureRecognizer)
        maxExpansion = notch.bounds.height*1.2
        notch.addGestureRecognizer(panGestureRecognizer)

        
    }
    
    private func setupRecognizers(){
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(wasTapped(_:)))

        //since we are dragging from top we want to block the invokation of Control Center
        setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(wasPanned(_:)))
        
    }
    
    private func setupSlider(){

        slider = UISlider()
        slider!.tintColor = .white
        slider!.thumbTintColor = .gray
        slider!.minimumValue = 0.0
        slider!.maximumValue = 1.0
        slider?.value = currentSliderValue
        slider!.addTarget(self, action: #selector(wasSlided(_:)), for: .allTouchEvents)
        notch.addSubview(slider!)
        slider!.translatesAutoresizingMaskIntoConstraints = false
        slider!.widthAnchor.constraint(equalTo: notch.widthAnchor, multiplier: 0.8).isActive = true
        slider!.heightAnchor.constraint(equalTo: notch.heightAnchor, multiplier: 0.4).isActive = true
        slider!.bottomAnchor.constraint(lessThanOrEqualTo: notch.bottomAnchor, constant: -10).isActive = true
        slider!.centerXAnchor.constraint(equalTo: notch.centerXAnchor).isActive = true
        slider!.alpha = 0
        view.layoutIfNeeded()


        
    }
    
    
    // MARK: - hide the status bar and take precedence over the system gestures
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //block Control Center
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{
        return .top
    }
    
    
    
    
    
    
    //MARK: - Actions
    
    @objc func wasTapped(_ sender: UITapGestureRecognizer){
        animateBackToOriginalPosition()
    }
    

    
    @objc func wasPanned(_ sender: UIPanGestureRecognizer){
        let position = sender.translation(in: view)
        switch sender.state{
        case .began:
            isExpansionCompleted = false
            initialTouchPosition = position
        case .changed:
            if let initialY = initialTouchPosition?.y{
                let dy = position.y - initialY
                expand(by: dy)
            }
        case .ended, .cancelled:
            
            // if probably redundant (gesture should be disabled if expansion is completed
            if isExpansionCompleted == false{
                animateBackToOriginalPosition()
            }
            initialTouchPosition = nil

        default:
            return
        }

        
    }
    

    
    @objc func wasSlided(_ sender:UISlider){
        timer?.invalidate()
        backgroundView.alpha = CGFloat(sender.value)
        currentSliderValue = sender.value
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false){ timer in
            self.animateBackToOriginalPosition()
            
        }
        
    }
    
    // MARK: - expand function
    func expand(by points:CGFloat){
        
        if points > maxExpansion{
            
            //block any further dragging

            panGestureRecognizer.isEnabled = false
            // animate to the final size
            animateToCompleteExpansion()
        }else{
            // TODO: - maybe use constraints instead
            let yRatio = 1 + points/notchInitialSize.height
            let xRatio = 1 + 3*(points/notchInitialSize.width)/2
//            let transform = CGAffineTransform(scaleX: xRatio, y: yRatio)
//            notch.transform = transform
            widthConstraint.constant = notchInitialSize.width*xRatio
            heightConstraint.constant = notchInitialSize.height*yRatio
            view.layoutIfNeeded()

            // reduce the radius as we approach maximum expansion
            let percentageOfExpansion = points/maxExpansion
            notch.radius = (1 - percentageOfExpansion/2)*initialRadius
        }
        
    
        
    }
    
    
    
    
    
    //MARK: Animations
    
    /// Expands the notch the final size
    /// - called when panning threshold has passed
    func animateToCompleteExpansion(){
        
        timer?.invalidate()
        widthConstraint.constant = notchInitialSize.width*1.5
        heightConstraint.constant = notchInitialSize.height*2.5
        timer = Timer.scheduledTimer(withTimeInterval: 2.7, repeats: false){_ in
            self.animateBackToOriginalPosition()
        }


        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
//            self.notch.transform = CGAffineTransform(scaleX: 2.0, y: 3.8)
            self.view.layoutIfNeeded()
            self.notch.radius = 6.0
            self.slider?.alpha = 1.0
        }completion: { _ in
            self.isExpansionCompleted = true
      

        }
      
    }
    
    /// Contracts the notch to the original size
    /// - called when panning is stopped (or cancelled) and panning threshold has not yet been reached
    func animateBackToOriginalPosition(){
        //invalidate the timer in case it is running
        
        timer?.invalidate()
        widthConstraint.constant = notchInitialSize.width
        heightConstraint.constant = notchInitialSize.height
//        notch.widthAnchor.constraint(equalToConstant: notchInitialSize.width).isActive = true
//        notch.heightAnchor.constraint(equalToConstant: notchInitialSize.height).isActive = true

        UIView.animate(withDuration: 0.5, delay:0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
            self.notch.radius = self.initialRadius
            if let slider = self.slider{
                slider.alpha = 0
            }
        } completion: { _ in
            self.isExpansionCompleted = false
//            self.slider?.removeFromSuperview()
        }

    }
    
    
    
    


}

