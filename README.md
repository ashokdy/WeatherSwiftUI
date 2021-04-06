# WeatherSwiftUI

Weather app is an iOS application used with Open Weather API which will forecast the 7 days weather report of the current location.

# Installation

This can be easily insatlled in 2 ways

1. Clone the link
2. Download the project directly
Once downloaded or cloned one can directly run the application by selecting any available simulator. 
If any problem persists, 
    Please Simulate location if it won’t auto update in simulator
    please install pods and try
    if still issue deintegrate pod and install and try again
    issues still exist? please raise it as issue

# Project Details

This project is developed in **SwiftUI** using MVVM pattern, API client with POP(Protocol Oriented Programming) used for making server calls are native and using the URLSession. Used today's best practices like generics, Codable, Extensions, MVVM, Computed properties and also OOPS concepts for ENDPoint class, which ever new client is required it can be easily created by overriding the required properties.

Constants are created for the application for the easy localization or any content change. SwiftUI views are used to display the results, details and few settings actions, Computed properties are used in the model which will give the leverage to keep the codable keys as it is and access the user required data with ease. **Reachabiliy** class for network change **LocationManager** class for the location request and authorization change observation. **BGAPIHelpers** are added just to show the other way with swift client to use

**Unit test cases** are being added for the possible places and the code coverage has been done as much as possible, ofcourse the 100% coverage is not possible in the real world but tried to cover as much as possible due to the time constraint.

# Contributing

Pull requests are welcome. For major changes, please raise an issue, we can discuss and have a issue fixed 😉

Please make sure to update tests as appropriate.

# License

MIT

# Screenshot

![Simulator Screen Shot - iPhone 8 Plus - 2021-04-06 at 23 46 51](https://user-images.githubusercontent.com/1999592/113773233-d0150a00-9736-11eb-8b08-758896f8d62d.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-04-06 at 23 46 12](https://user-images.githubusercontent.com/1999592/113773247-d73c1800-9736-11eb-865a-0092ef50016d.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-04-06 at 23 46 15](https://user-images.githubusercontent.com/1999592/113773253-d99e7200-9736-11eb-98bd-99453a6e53be.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-04-06 at 23 46 24](https://user-images.githubusercontent.com/1999592/113773264-dc996280-9736-11eb-8808-f17c71684434.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-04-07 at 00 07 07](https://user-images.githubusercontent.com/1999592/113773279-e3c07080-9736-11eb-862f-0e9cfcebddfe.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-04-07 at 00 07 27](https://user-images.githubusercontent.com/1999592/113773287-e58a3400-9736-11eb-8b39-33bc355fed7d.png)
