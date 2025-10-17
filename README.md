<div align="center">

# 🏋️‍♂️ **FitTrack**

### A Modern Flutter Fitness Tracker

**Your Personal Fitness Journey, Beautifully Crafted.**

<p>
<img src="https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter" alt="Flutter Version">
<img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green?style=for-the-badge&logo=android" alt="Platform">
<img src="https://img.shields.io/badge/License-MIT-purple?style=for-the-badge" alt="License">
</p>

</div>

---

## ✨ App Showcase

Experience the fluid UI, smooth animations, and seamless light/dark theme transitions.

---

## 🚀 Core Features

| Feature | Description | Status |
|---|---|---|
| 📊 **Modern Dashboard** | At-a-glance view of daily steps, weekly calories, and progress towards goals with animated charts. | ✅ Complete |
| ✍️ **Effortless Logging** | Manually add or edit activities with a refined, icon-based UI that's fast and intuitive. | ✅ Complete |
| 💾 **Dual Database** | Seamlessly switch between local SQLite for offline use, or Firebase for cloud backup. | ✅ Complete |
| ✨ **Polished UI/UX** | Built with Material 3, custom widgets, and a health-focused color palette for a stunning look. | ✅ Complete |
| ⚡ **Optimized Performance** | Architected for 120Hz displays, with efficient state management using Provider. | ✅ Complete |
| 🌓 **Light & Dark Theme** | Beautifully crafted light and dark modes that persist across app sessions. | ✅ Complete |

---

## ⚙️ Tech Highlights

- 🔄 Dual-database architecture (SQLite + Firebase)
- 🎨 Material 3 theming with custom components
- 📈 Animated charts and real-time stats
- 🧠 Provider-based state management
- 🌗 Persistent light/dark theme toggle
- 🪶 Smooth animations & 120Hz-ready UI
- 💡 Shared Preferences for theme persistence

---

## 🏛️ Architectural Philosophy

FitTrack is built with **clean architecture** principles, focusing on **Separation of Concerns** and **scalability**.

### 🧩 Layers Overview

-   **UI Layer (`screens/`, `widgets/`)**
    -   Handles user interface and interactions.
    -   Does not directly depend on data sources.

-   **State Management (`providers/`)**
    -   Managed via the **Provider** package.
    -   Acts as a bridge between UI and backend services.

-   **Service Layer (`api/`)**
    -   Abstract layer defining a `DatabaseService` interface.
    -   Enables switching between SQLite and Firestore without changing app logic.

-   **Data Layer (`api/sqlite_service.dart`, `api/firestore_service.dart`)**
    -   Implements actual database operations and synchronization.

This structure makes FitTrack **modular**, **testable**, and **easy to extend**.

---

## 🛠️ Tech Stack & Dependencies

| Category | Tool / Package |
|---|---|
| Framework | **Flutter** |
| State Management | **Provider** |
| Local Database | **SQFlite** |
| Cloud Database | **Cloud Firestore** |
| Charts | **fl_chart** |
| Typography | **Google Fonts (Poppins)** |
| Theme Persistence | **Shared Preferences** |

---

## 📂 Project Structure

```plaintext
lib/
├── api/                      # Database services and abstraction layer
│   ├── database_service.dart       # Abstract service definition
│   ├── firestore_service.dart      # Cloud Firestore implementation
│   └── sqlite_service.dart         # Local SQLite implementation
│
├── models/                   # Data models used across the app
│   └── activity.dart              # Activity data model
│
├── providers/                # State management using Provider
│   ├── fitness_provider.dart      # Handles fitness data and logic
│   └── theme_provider.dart        # Manages app theme state
│
├── screens/                  # Main UI screens of the app
│   ├── add_log_screen.dart        # Screen for adding/editing activities
│   ├── dashboard_screen.dart      # Displays stats and graphs
│   ├── home_screen.dart           # Main user navigation
│   ├── main_screen.dart           # Root app structure
│   └── settings_screen.dart       # Optional settings or profile screen
│
├── utils/                    # Helpers, constants, and theming
│   ├── app_theme.dart             # Light/Dark theme definitions
│   └── helpers.dart               # Utility functions and constants
│
├── widgets/                  # Reusable UI components
│   ├── activity_card.dart        # Custom card showing an activity
│   ├── stat_card.dart            # Statistic display widget
│   └── custom_button.dart        # Example reusable button
│
└── main.dart                  # App entry point and initial setup
