# 🦸 marvel-dex 

📱 iOS application that lists Marvel characters using the [Marvel API](https://developer.marvel.com).

To run the app:
1. Download this repository and open it in Xcode.
2. Create a MyDisney account.
3. Obtain both your public and private keys for the MarvelAPI by accessing your Developer Portal.
4. Open the api_keys.json file inside the Utils folder of the project and add both keys.
(🚨 Do not push your private key to any public repositories.)
7. Build and run the application.


The app's minimum target is iOS 16.

## 💻 Project details


* This project was implemented using the MVVM architectural pattern.
* The Model layer contains any necessary data or business logic required to retrieve all the characters and their information.
* Views are built in SwiftUI and are responsible for displaying all the data to the user.
* View Models handle all interactions and update the view with the requested information.

Current features (some were left out due to time constraints):
- [x] List of characters
- [x] Search by name
- [x] Characters details
- [x] Bookmarked characters
- [x] FaceID authentication
- [ ] PIN Authentication
- [x] Unit Testing
- [ ] UI Testing


### 📝 Observations
* The whole project was developed only using the main branch, git flow was not considered for simplicity purposes.

* User authentication for the Bookmarks view was implemented, checking whether the user device supports biometric authentication and prompting as an option.

* The Bookmarks feature was built using Realm database. This choice was made because I found adding CoreData to SwiftUI a bit too complex for a simple project (way easier with UIKit), and as SwiftData is a fairly recent feature, Realm was the practical solution.

* The project also contains SwiftLint to ensure code styling, conventions and good practices

* The service unit testing was made by creating a mock API manager. By avoiding using the API manager as a singleton, we ensure its testability and by making the service depend on the protocol, we ensure the D in Solid, which stands for dependency inversion, where instead of depending on the higher level, we depend on abstractions.

* With the help of an AI assistant, some doubts and code snippets were addressed with the following prompts:
  - How to use ShareLink to share an Image from URL in SwiftUI?
  - What is the simplest way to implement pagination on my iOS app given the following JSON return?
  - How can I get a string timestamp for the current date in Swift without special characters, going far as the second?




