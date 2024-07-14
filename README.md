# Goals
- SwiftUI is used as the native development framework. (While I also like UIKit, this time I wanted to try some challenging new technology.)
- The Combine framework is utilized, along with async/await feature.
- The URLSession extension in the project accepts T.Type as a parameter to simplify data parsing. This approach is similar to the concept of DIManager.
- The project supports sorting all transactions by ID, date, credits, and debits.
- In both the list rows and detail views, credit amounts are displayed in green, while debit amounts are shown in red.
- In the transaction detail views, the GST amount is displayed below the credit amount.
- VoiceOver accessibility is supported.
- The Unit Test section verifies the ability to fetch data from the network.
- The UI Test section checks if tapping a list item successfully navigates to the detail view.