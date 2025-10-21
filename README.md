# native-iOS-inbox-app

A native iOS productivity app built with Flutter that displays and manages memos, events, and tasks in an elegant inbox-style interface.

## Screenshots

<p align="center">
  <img src="images/Simulator Screenshot - iPhone 17 Pro - 2025-10-21 at 17.42.26.png" width="250" alt="Inbox View"/>
  <img src="images/Simulator Screenshot - iPhone 17 Pro - 2025-10-21 at 17.42.48.png" width="250" alt="Task Detail"/>
</p>
<p align="center">
  <img src="images/Simulator Screenshot - iPhone 17 Pro - 2025-10-21 at 17.42.35.png" width="500" alt="Landscape View"/>
  <img src="images/Simulator Screenshot - iPhone 17 Pro - 2025-10-21 at 17.42.39.png" width="500" alt="Landscape Split View"/>
</p>

## Features

- **Unified Inbox** - View memos, events, and tasks in one place
- **Category Icons** - Visual distinction between message types
- **Responsive Design** - Optimized for both portrait and landscape orientations
- **Adaptive Layouts** - Split-view in landscape, full-screen in portrait
- **Native iOS Feel** - Built entirely with Cupertino widgets

## Architecture

This project implements the **MVVM (Model-View-ViewModel)** design pattern with clean separation of concerns:

```
┌─────────────────────────────────────────────┐
│               View Layer                     │
│  (UI Components - Cupertino Widgets)        │
│  • inbox_view.dart                          │
│  • message_detail_view.dart                 │
│  • Widget Components                        │
└─────────────┬───────────────────────────────┘
              │ Observes State
              │ Calls Commands
┌─────────────▼───────────────────────────────┐
│            ViewModel Layer                   │
│  (Business Logic & State Management)        │
│  • inbox_viewmodel.dart                     │
│  • ChangeNotifier for reactivity            │
└─────────────┬───────────────────────────────┘
              │ Uses
┌─────────────▼───────────────────────────────┐
│            Service Layer                     │
│  (Data Access Abstraction)                  │
│  • message_service.dart                     │
│  • JSON parsing & data fetching             │
└─────────────┬───────────────────────────────┘
              │ Returns
┌─────────────▼───────────────────────────────┐
│             Model Layer                      │
│  (Data Structures)                          │
│  • Message (abstract)                       │
│  • Memo, Event, Task                        │
└─────────────────────────────────────────────┘
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Xcode (for iOS development)
- macOS (required for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mofetaiwo/native-iOS-inbox-app
   cd native-iOS-inbox-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for iOS

```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```
