# WeatherApp
 It is an iOS application which shows Weather Details for tomorrow for cities i.e "Gothenburg","Stockholm","Mountain View","London","New York" and "Berlin".
 
 
 # Screenshots
<img width="358" alt="Screenshot 2021-01-23 at 23 45 22" src="https://user-images.githubusercontent.com/31967294/105610437-85d9e900-5dd5-11eb-923a-97965c6ba61a.png">
<img width="354" alt="Screenshot 2021-01-23 at 23 45 36" src="https://user-images.githubusercontent.com/31967294/105610439-8a060680-5dd5-11eb-8acb-b0a3aef10587.png">
<img width="368" alt="Screenshot 2021-01-23 at 23 45 51" src="https://user-images.githubusercontent.com/31967294/105610440-8e322400-5dd5-11eb-84bd-7780e6dac68e.png">


# Requirements

* Xcode 12.3, iOS 14.3 or later, OS X 10.15.5 or later.


# Installation

To run the project :
- a) Navigate to root folder of the project. 
- b) Open the terminal and cd to the directory containing the Podfile
- c) Delete the existing Podfile.lock, Pods, and Assignment.xcworkspace file if exists
- d) Run the "pod install" or "pod update"command
- e) Open xcworkspace and run the app 
- f) If there is any issue in installing Pods:
     Run
    1) pod deintegrate
    2) pod update




# Design Pattern
MVVM

What is MVVM ?
Model-View-ViewModel (MVVM) is a design pattern that’s gained traction in the iOS development community in recent years. It involves a new concept called a view model. In iOS apps, a view model is a companion object to a view controller.

-> Model: App data that the app operates on.
-> View: The user interface’s visual elements. In iOS, the view controller is inseparable from the concept of the view.
-> ViewModel: Updates the model from view inputs and updates views from model outputs.
These classes are following.

1) Model:
-> DATASOURCE:
- NetworkAdapter: It makes API calls using URLSession and fetch result or error and interacts with ViewModel.
-  Location & Weather: 
Contains plain model class.

2) View(UIView + Controller): 
 - > WeatherForecastViewController 
- >  SelectLocationViewController
-> WeatherDetailTableViewController
-> WeatherTableViewCell

Classes that has all the code to show the app interface of 5 cities,weather list and weather detail to the user and get their responses. 
Upon receiving a response it alerts the ViewModel.

3) ViewModel:
-> WeatherViewModel: It takes view/controller inputs and updates views from model outputs.

Common:
- Used for extensions,constants,Network check within app.
# Version

1.0

# Support Version

*  iOS 14.3 or later


# Language

* Swift 5.1


# Pods

* Alamofire
* Toast-Swift
* SDWebImage
* SwiftLint


# Assumptions        

1. The app is designed for iPhones and with portrait mode.     
2.  Supported mobile platforms are iOS (14.x)           
3.  iPhone app support would be limited to portrait mode.
