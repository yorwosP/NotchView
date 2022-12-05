import XCTest
@testable import NotchView

final class NotchViewTests: XCTestCase {
    var sut:Notch!
    
    override func setUpWithError() throws {
        sut = Notch()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    
    
    func testLayerCornerRadiusIsChangedWhenSettingObjectsRadius() {
       
        sut.radius = 30
        let setRadius = sut.layer.cornerRadius

        XCTAssertEqual(sut.radius, setRadius, "layer's corner radius is not equal to the object's set radius")
        
    }
    
    func testObjectsRadiusIsSameAsLayersCornerRadius() {
        let objectRadius = sut.radius
        let layerRadius = sut.layer.cornerRadius
        
        XCTAssertEqual(objectRadius, layerRadius, "object's radius is not the same as layer's corner radius")
        
    }
    
    func testReturnZeroSizeIfDeviceIsNotSupported() throws{

        let zeroSize = CGSize()
        
        if !Notch.isNotchAvailable{
            XCTAssertEqual(zeroSize, sut.bounds.size, "Notch for \(UIDevice.modelName) is not available. Initializer should return a zero size view")
            
        }else{
            throw XCTSkip("Notch is availabke for this device (\(UIDevice.modelName)")
        }

    }
    
    func testReturnNonZeroSizeIfDevideIsSupported() throws{

        let zeroSize = CGSize()
        if Notch.isNotchAvailable{

            XCTAssertNotEqual(zeroSize, sut.bounds.size, "Notch for \(UIDevice.modelName) is  available. Initializer should not return a zero size view")
        }else{
            throw XCTSkip("notch view not available in this device (\(UIDevice.modelName))")
        }
    }
    
    

    

}
