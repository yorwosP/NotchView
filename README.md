# NotchView

This is a simple Swift Library that creates a UIView that matches the notch (dimensions and corner radius) of the specific iPhone model it runs on. This can be used to implement features similar to dynamic island of iPhone 14 Pro

An example using this package:





https://user-images.githubusercontent.com/67348182/205521361-6c290a72-555e-4108-a9e2-56fa85d6eb43.mov




A convenience getter and setters for corner radius (view.layer.cornerRadius) is also exposed

 Supported iPhone models:

- iPhone X
- iPhone Xʀ
- iPhone XS
- iPhone XS Max
- iPhone 11
- iPhone 11 Pro
- iPhone 11 Pro Max
- iPhone 12
- iPhone 12 mini
- iPhone 12 Pro
- iPhone 12 Pro Max
- iPhone 13
- iPhone 13 mini
- iPhone 13 Pro
- iPhone 13 Pro Max
- iPhone 14
- iPhone 14 Plus

## Usage:

```swift
import NotchView 
let notchView = Notch() //create the notch view
```
The created view has by default black background color
After creating the notch view, you can treat it as normal  UIView (add it to a view, add constraints to it, animate it, etc.) 

If the device is not supported, the returned view has zero size.

You can check if the current device is in the list of supported devices by using the isNotchAvailable static property:

```swift
if isNotchAvailable{
    // do something with the notch

} else{
    // fallback to an implemention that doesn't use notch view
}
``` 
