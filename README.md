# 🌸 Ponyonyo Cafe — Flutter Food Ordering App

A cute and modern mobile food ordering application built with Flutter 
and Firebase, developed as a university group project.

## ✨ Features
- 🔐 Role-Based Authentication (Admin & Guest login)
- 🍰 Interactive Menu with category filtering
- 🛒 Multi-item order selection using FilterChips
- ☁️ Real-time order management via Firebase Cloud Firestore
- 👤 Dynamic Profile page based on user role
- 🔄 Full CRUD operations for Admin (Create, Read, Update, Delete)

## 📱 Screenshots
<!-- Add your screenshots here -->

## 🛠️ Tech Stack
| Technology | Purpose |
|---|---|
| Flutter (Dart) | Frontend UI Framework |
| Firebase Firestore | Cloud NoSQL Database |
| Google Fonts | Typography |

## 🗂️ Project Structure
lib/ ├── main.dart # App entry point & theme ├── column.dart # Navigation layout ├── login.dart # Authentication page ├── home.dart # Homepage ├── menu.dart # Menu browsing page ├── profile.dart # User profile (role-based) └── form_page.dart # Order form + Firebase CRUD


## 👩‍💻 My Contribution
- **Profile Page** (`profile.dart`): Implemented role-based UI 
  rendering for Admin and Guest users, including secure logout 
  using Navigator stack clearing.
- **Database Integration** (`form_page.dart`): Integrated Firebase 
  Cloud Firestore with full CRUD operations. Built real-time order 
  streaming using StreamBuilder and implemented admin order 
  management (edit & delete).

## 🚀 Getting Started
1. Clone this repository
2. Run `flutter pub get`
3. Connect your Firebase project (add `google-services.json`)
4. Run `flutter run`

## 📱 Screenshots
<img src="screenshots/guest_profile.png" width="250"> 
<img src="screenshots/admin_profile.png" width="250">
<img src="screenshots/order_form.png" width="250">

## 👥 Team
| Member | Section |
|---|---|
| Bel | main.dart, column.dart |
| Fara | login.dart, home.dart |
| Suzan | menu.dart |
| [Your Name] | profile.dart, Firebase Database |
| Dayah | form_page.dart (UI) |

