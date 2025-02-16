# PostVault
This is an iOS application built using Swift, following the MVVM architecture pattern. It demonstrates the use of Realm-Swift for local storage, Alamofire for networking, and RxSwift/RxCocoa for reactive programming, Unit Test Cases.

# iOS MVVM Assessment App

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
   git clone https://github.com/your-username/repository-name.git
   cd repository-name
   ```
2. Install dependencies using CocoaPods:
   ```bash
   pod install
   ```
3. Open `PostVault.xcworkspace` in Xcode
4. Build & run on a simulator or device

---

## Screenshots
_(Add screenshots here to showcase the UI)_

---

## How to Use
1. **Login:** Enter a valid email & password (8-15 characters) to proceed.
2. **View Posts:** Posts are fetched from the API and stored locally.
3. **Manage Favorites:** Tap a post to toggle favorite status.
4. **View Favorites:** All favorited posts are listed separately, with a swipe-to-delete option.
5. **Logout:** Clear cached login and return to the login screen.

---

