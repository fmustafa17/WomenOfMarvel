# Women of Marvel
Displays the Women of Marvel Comic book in a iOS application made with UIKit.
This also includes unit tests and a UI test that uses the [Builder Pattern](https://www.geeksforgeeks.org/builder-design-pattern/).

## Technical Notes
This application uses the free [Marvel Developer API](developer.marvel.com). The [Combine framework](https://developer.apple.com/documentation/combine) is used for data binding.

### Apple Libraries Used
[CommonCrypto](https://developer.apple.com/security/) is used in order to return a hash string that is required to be sent in the query parameters of the Marvel Developer API.

### Third Party Dependencies
[Cocoapods](https://cocoapods.org/) is used for integrating third party libraries.
- [Kingfisher](https://cocoapods.org/pods/Kingfisher)
    - Used for caching and retrieving images from the internet easily
- [SwiftKeychainWrapper](https://cocoapods.org/pods/SwiftKeychainWrapper)
    - Easily read and write data to the Keychain, used to store public and private API keys

### How to add your developer keys

In order to not expose our sensitive data, I've created a file called `Config.swift` that holds the values of my public and private API keys.
This config file is then added to the .gitignore file. If you do accidently commit and push sensitive data to your repo, consider it compromised and generate a new API key.

How to replicate the config file:

```swift
import Foundation

enum CONFIG {
    static let privateKey = "<YOUR PRIVATE KEY HERE>"
    static let publicKey = "<YOUR PUBLIC KEY HERE>"
}
```

## Screenshots
![Screenshot of the iOS Application showing Women of Marvel's book title, description and cover
image](https://res.cloudinary.com/farheezyx3/image/upload/v1651649691/WomenOfMarvel%20Repo/Simulator_Screen_Shot_-_iPhone_12_Pro_Max_-_2022-05-03_at_21.28.44.png)

## Improvement Opportunities 
- Add a scroll view to the root view to scroll through the content on smaller devices
- Test and update code to work as expected on when Larger Text is enabled
- Add Dark Mode support