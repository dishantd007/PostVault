# PostVault
This is an iOS application built using Swift, following the MVVM architecture pattern. It demonstrates the use of Realm-Swift for local storage, Alamofire for networking, and RxSwift/RxCocoa for reactive programming, Unit Test Cases.

# iOS MVVM/RxSwift Assessment App

## Overview
This is an iOS application built using **Swift**, following the **MVVM architecture pattern**. It demonstrates the use of **Realm-Swift for local storage**, **Alamofire for networking**, and **RxSwift/RxCocoa for reactive programming**, **Unit Test cases**.

The app consists of two screens:
1. **Login Screen** – Implements form validation and login caching.
2. **Post List & Favorites** – Fetches and displays posts from an API, supports offline access, and allows users to mark/unmark posts as favorites.

---

## Tech Stack
- **Swift** (Primary language)
- **MVVM** (Design pattern)
- **Realm-Swift** (Local database for offline support & favorites management)
- **Alamofire** (Networking)
- **RxSwift / RxCocoa** (Reactive programming)

---

## Features

### Screen 1: Login
✔️ Email & password validation  
✔️ Submit button is enabled only when input is valid  
✔️ Login is cached to persist user sessions  
✔️ Logout option available on Screen 2  

### Screen 2: Posts & Favorites
✔️ Fetches posts from `https://jsonplaceholder.typicode.com/posts`  
✔️ Displays posts even when offline (caching with Realm)  
✔️ Users can toggle favorites by tapping on a post  
✔️ "Favorites" tab lists all saved posts  
✔️ Swipe to delete a favorite post  

---

## API Endpoints Used
- **Fetch posts:** `https://jsonplaceholder.typicode.com/posts`
- **Fetch comments for a post:** `https://jsonplaceholder.typicode.com/posts/{post_id}/comments`

---

## Installation & Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/PostVault.git
   cd PostVault
   ```
2. Install dependencies using CocoaPods:
   ```bash
   pod install
   ```
3. Open `PostVault.xcworkspace` in Xcode
4. Build & run on a simulator or device

---

## Screenshots
![Login](https://github.com/user-attachments/assets/96a62964-37a6-4743-a67d-ea250b9d7918)


![LoginFilled](https://github.com/user-attachments/assets/c11850f7-9a15-4025-9c5d-a087f945c6c3)


![Post](https://github.com/user-attachments/assets/00660911-2c27-4a23-bb70-989e3fc9a339)


![PostLiked](https://github.com/user-attachments/assets/44ff504a-b109-4e23-beb0-44cefc89289d)


![FavoritePost](https://github.com/user-attachments/assets/58adc660-7d80-407d-9f54-1b6aa67d1eea)


![Delete](https://github.com/user-attachments/assets/55fbe1a3-396b-4d72-980a-48efca8babb7)


![Comment](https://github.com/user-attachments/assets/e3a18ef2-cc63-453c-8c39-02d48358db06)




---

## How to Use
1. **Login:** Enter a valid email & password (8-15 characters) to proceed.
2. **View Posts:** Posts are fetched from the API and stored locally.
3. **Manage Favorites:** Tap a post to toggle favorite status.
4. **View Favorites:** All favorited posts are listed separately, with a swipe-to-delete option.
5. **Logout:** Clear cached login and return to the login screen.

---
