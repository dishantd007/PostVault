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
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 12 41](https://github.com/user-attachments/assets/ee72b7c4-2250-4ace-b315-bf2f8be69a49)

![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 13 30](https://github.com/user-attachments/assets/274b9788-7ff5-4de7-a7ff-92b8447ecef5)


![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 13 30](https://github.com/user-attachments/assets/dcc5
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 13 37](https://github.com/user-attachments/assets/2b58aaa8-b13e-4598-b40e-9e5729ab6e39)
c7cf-c
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 13 50](https://github.com/user-attachments/assets/09015655-93dc-4323-8c98-fa9b4e50bb8e)
5f0-4797-8695-8228a17b1a3b)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 13 58](https://github.com/user-attachments/assets/a8b00a55-9cbe-4f23-a0d3-78069ded1d20)
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 14 07](https://github.com/user-attachments/a
![Simulator Screenshot - iPhone 15 - 2025-02-16 at 20 14 23](https://github.com/user-attachments/assets/87c018e5-42ca-4979-a5eb-8d064d0b78dd)
ssets/17f5e359-06bb-49e2-950d-5a644809aa3c)

---

## How to Use
1. **Login:** Enter a valid email & password (8-15 characters) to proceed.
2. **View Posts:** Posts are fetched from the API and stored locally.
3. **Manage Favorites:** Tap a post to toggle favorite status.
4. **View Favorites:** All favorited posts are listed separately, with a swipe-to-delete option.
5. **Logout:** Clear cached login and return to the login screen.

---

