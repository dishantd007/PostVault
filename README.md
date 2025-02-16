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
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 17 17 52](https://github.com/user-attachments/assets/b9c7340e-e6fe-4b17-be5f-2a7ef07d1369)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 17 17 43](https://github.com/user-attachments/assets/b51a89ef-9a09-4623-bb89-76fd111768e8)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 17 17 29](https://github.com/user-attachments/assets/d3b75ede-d218-4dc9-9bb5-69c071e20c96)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 16 14 33](https://github.com/user-attachments/assets/cc50e89b-6acd-4eea-999d-12a794f7c747)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 16 14 01](https://github.com/user-attachments/assets/f27cd7cc-0f42-411e-9cd1-2ead1106a6cb)
![Simulator Screenshot - iPhone 15 - 2025-02-15 at 07 57 40](https://github.com/user-attachments/assets/57b6e0a2-536f-42d6-9488-bd2ce6069dc1)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 17 18 19](https://github.com/user-attachments/assets/75607f9f-5862-45f6-965e-7b9ffb46293c)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 17 18 03](https://github.com/user-attachments/assets/d1cb1366-a8b5-4ca8-918b-c37ae7c7b6b0)

---

## How to Use
1. **Login:** Enter a valid email & password (8-15 characters) to proceed.
2. **View Posts:** Posts are fetched from the API and stored locally.
3. **Manage Favorites:** Tap a post to toggle favorite status.
4. **View Favorites:** All favorited posts are listed separately, with a swipe-to-delete option.
5. **Logout:** Clear cached login and return to the login screen.

---

