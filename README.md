# iOSArchitecture-MVVMwithCombine
Mini Spotify - examining MVVM architecture using the Combine Framework and the Repository pattern.

## My Solution

I have completed the 4 compulsory deliverables with a catch...

The `Songs` section comes before the `Albums`, which is meant to be the other way around.

Thank you.

## Dark Mode

<img src="https://user-images.githubusercontent.com/22558674/177774367-6f4fe870-3d14-42ee-890b-b66d8a67e8e4.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177774389-0a19125d-48c2-450f-9088-1516c86f3dd7.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177774391-096e2b92-3a41-4757-bbf3-eadee6d6ca16.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177774401-841ae004-e499-48ed-b9fe-177baa83bdd6.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177774407-7766f402-9e8a-42ed-be9d-ad4b6031114c.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177774410-bf54313c-e08f-4df0-8d99-c2f8f5c64f77.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177798383-abb7c770-061c-468d-8c39-413e119e5017.png" width="250">

## Light Mode

<img src="https://user-images.githubusercontent.com/22558674/177798529-9601287c-be38-4ea8-a54f-c01ab9a3b051.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177798534-dd8ef97b-cccd-4f3b-910e-6490e320ad9a.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177798542-2b50283a-e7ac-40ce-a9fa-c3220e55351c.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177798551-4225ac89-20c9-48a1-b8a5-d33fefd6ff31.png" width="250"> <img src="https://user-images.githubusercontent.com/22558674/177798562-d9000744-d3dc-4a8b-89d8-49de33c30b18.png" width="250">

This README file contains the instructions to complete the challenge for the iOS Architecture Bootcamp.

## Main Deliverables
- **Add a logout button to the search window**
  - You can use the top left or right (navigation bar) to display the button
  
- **Modify the Search window, so that if the search belongs to an artist, the first 5 albums of that artist are shown in a different section**
  - Section 0: albums (only if the search was by artist)
  
  - Section 1: Songs
  
  - There should be no action on albums, if the user selects an album an alert can be displayed with the message "Working with mvvm is great!*

  > \**Hint:** The iTunes API is limited, but since we are engineers we can play around with it. When searching for a song the result shows different artists but when searching for an artist the result shows the same artist. If the search result shows the first 5 elements with the same artist (artistId) it means that the artist was searched, therefore the albums can be displayed.
  
- **Implement save option by tapping button with three dots in cell**
  - There should be a popup saying add to favorites
  
  - Searchs don't persist, but adding the same item over and over again shouldn't be allowed

- **Implement a Favorite module**
  - Create a respository, a view, and a viewmodel
  
  - You can use a `UITabBarController` to manage two windows, search and favorites, but you can also use the navigation bar to display a favorites button in addition to the logout button
  
  - Items in favorites can be deleted
  
  - **Extra**: Allow sorting alphabetically or by creation date
  
## Extra
- **Modify the UI for the song cell, it would look nice to show an image on the left side or if you want it is also valid to completely modify the UI with the colors**
  - In case of displaying song image, existing caching mechanism like [KingFisher](https://github.com/onevcat/Kingfisher) can be implemented
  
- **As the application is a simulation of Spotify, the information per user is not saved. 4 users can be hardcoded, so information is saved and displayed per user**
  - Implement a Users module that contains 4 usernames with their passwords to login
  
  - Save songs together with a user attribute (the active user in the application)

## About the iTunes API
[Documentation](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html#//apple_ref/doc/uid/TP40017632-CH3-SW1)

### Search examples:
**Simple Plan** -> https://itunes.apple.com/search?term=Simpleplan&media=music&entity=song

**Song (Dakiti)** -> https://itunes.apple.com/search?media=music&term=Dakiti&entity=song

**Search by Simple Plan ID** -> https://itunes.apple.com/lookup?id=150861&entity=album

> **Note:** The first 5 results for the Simple Plan search contain the same artistId, but the first 5 results for the Dakiti song search show a different artistId.
