# Ponyonyo Cafe — Flutter Food Ordering App

A mobile food ordering application built with Flutter and Firebase Cloud Firestore, developed as a group project for a cafe ordering system with role-based access for guests and administrators.

Built for **IIB26603 - Mobile Ubiquitous, Mini Project** (UniKL MIIT).

**Group members:**
- Farrah Syahirah Syahmi binti Baharudin
- Nur Husna binti Mohamed Din
- Nur Nabilah binti Mohd Ruzi
- Siti Nurhidayah binti Abdullah
- Souzan Altahan

## The Problem

Traditional in-person food ordering is slow and doesn't scale well during peak hours. Ponyonyo Cafe needed a digital ordering system that lets customers browse the menu, place orders, and manage their profile from their phone, while giving staff a way to track and manage incoming orders in real time.

## Key Features

- Role-based authentication (Admin and Guest login)
- Drawer and bottom navigation with IndexedStack for state preservation across pages
- Interactive menu with category filtering (Cakes, Scones, Waffles, Hot Drinks, Cold Drinks)
- Multi-item order selection using FilterChips
- Real-time order management via Firebase Cloud Firestore
- Role-based Profile page (Admin view vs. Guest view with personal info)
- Full CRUD operations for Admins (Create, Read, Update, Delete orders)
- Form validation across login and order submission

## How It Works

1. User logs in as either Admin or Guest using predefined credentials
2. Guests browse the menu, filter by category, and place orders through a validated order form
3. Orders are submitted to Firebase Firestore with customer name, phone, items, notes, and timestamp
4. Admins access a real-time dashboard (via StreamBuilder) showing all orders, with the ability to edit or delete any record
5. Navigation between Home, Menu, Profile, and Order pages is handled through a Drawer and Bottom Navigation Bar, with IndexedStack preserving page state

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend/Database:** Firebase Cloud Firestore (NoSQL, real-time sync)
- **Typography:** Google Fonts (DM Serif Display for headings, Nunito for body text)

## Project Structure

lib/

├── main.dart # App entry point, Firebase init, theme configuration
├── column.dart # Main layout, drawer + bottom navigation
├── login.dart # Authentication page
├── home.dart # Home dashboard
├── menu.dart # Menu browsing with category filtering
├── profile.dart # Role-based profile page
└── form_page.dart # Order form + Firebase CRUD operations

## Authentication

| User Role | Username | Password |
|---|---|---|
| Administrator | admin | admin123 |
| Guest User | guest | 1234 |

## Database Schema

Orders are stored in a Firestore collection named `orders`, with each document containing:

| Field | Type | Description |
|---|---|---|
| name | String | Customer's full name |
| phone | String | Customer's contact number |
| item | String | Comma-separated list of selected items |
| notes | String | Special requests or dietary requirements |
| timestamp | Timestamp | Server-generated time (FieldValue.serverTimestamp()) |

## My Contribution

- **Profile Page** (`profile.dart`): Implemented role-based UI rendering for Admin and Guest users using a boolean `isAdmin` flag, including a reusable `_buildInfoRow()` widget for displaying user details and secure logout via `Navigator.pushAndRemoveUntil()`.
- **Database Integration** (`form_page.dart`): Integrated Firebase Cloud Firestore with full CRUD operations — order submission with form validation, real-time order display using `StreamBuilder`, and admin edit/delete functionality with confirmation dialogs.

## Demo

*(screenshots go here — see note below)*

## What I'd Improve

- Move admin credentials out of hardcoded values into proper Firebase Authentication
- Add order status tracking (pending, preparing, ready, completed) instead of a flat order list
- Add search/filter functionality to the admin order dashboard for larger order volumes

## Getting Started

1. Clone this repository
2. Run `flutter pub get`
3. Connect your Firebase project (add `google-services.json`)
4. Run `flutter run`
