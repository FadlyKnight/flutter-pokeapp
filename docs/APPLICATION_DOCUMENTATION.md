# PokeShop - Flutter Pokemon Store Application
## Complete Application Documentation

**Version:** 1.0.0  
**Project Name:** fluter_numiii_app  
**Platform:** Flutter (Cross-platform)  
**Last Updated:** 2026-06-01

---

## Table of Contents
1. [Application Overview](#application-overview)
2. [Project Structure](#project-structure)
3. [Dependencies](#dependencies)
4. [Architecture](#architecture)
5. [Features](#features)
6. [Page Documentation](#page-documentation)
7. [State Management](#state-management)
8. [Firebase Integration](#firebase-integration)
9. [API Integration](#api-integration)
10. [UI/UX Components](#uiux-components)
11. [User Flow](#user-flow)
12. [Development Setup](#development-setup)
13. [Future Enhancements](#future-enhancements)

---

## Application Overview

**PokeShop** is a Flutter-based mobile e-commerce application for buying and selling Pokémon merchandise. The application provides users with a seamless shopping experience, including:

- Pokemon browsing and discovery
- User authentication (Login/Register)
- Shopping cart functionality
- Search and filtering capabilities
- User profile management

### Key Characteristics
- **Theme Color:** Red (Primary), Material Design
- **Font Family:** Poppins
- **Debug Mode:** Disabled
- **Target Platforms:** iOS, Android, and Web

---

## Project Structure

```
flutter-numiii-app/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── firebase_options.dart     # Firebase configuration
│   ├── layouts/
│   │   └── base.dart            # Base layout with bottom navigation
│   └── pages/
│       ├── login.dart           # Login page with Firebase Auth
│       ├── register.dart        # User registration page
│       ├── store.dart           # Store/Home page with Pokemon display
│       ├── listSearch.dart      # Search page with API integration
│       └── cart.dart            # Shopping cart page (WIP)
├── test/
│   └── widget_test.dart         # Widget tests
├── pubspec.yaml                 # Project dependencies
├── pubspec.lock                 # Locked dependency versions
├── .env                         # Environment variables (using flutter_dotenv)
└── docs/
    └── APPLICATION_DOCUMENTATION.md  # This file
```

---

## Dependencies

### Core Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| flutter | SDK | Core Flutter framework |
| cupertino_icons | ^1.0.8 | iOS-style icon font |
| http | ^1.4.0 | HTTP client for API requests |
| firebase_core | ^3.15.1 | Firebase initialization |
| firebase_auth | ^5.6.2 | Firebase authentication |
| cloud_firestore | ^5.6.11 | Cloud database for user data |
| flutter_dotenv | ^6.0.1 | Environment variable management |

### Dev Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| flutter_test | SDK | Testing framework |
| flutter_lints | ^5.0.0 | Code linting and analysis |

### Target Environment
- **Dart SDK:** ^3.7.2
- **Build Number:** 1.0.0+1

---

## Architecture

### Architecture Pattern: MVVM-like with Stateful Widgets

The application uses Flutter's built-in state management with a combination of StatefulWidget and StatelessWidget patterns:

```
App Entry (main.dart)
    ↓
MyApp (MaterialApp Configuration)
    ↓
BaseLayout (StatefulWidget - Main Navigation Hub)
    ├── Stateful Pages (Local State Management)
    │   ├── HomePage (store.dart)
    │   ├── ListSearchPage (listSearch.dart)
    │   ├── CartPage (cart.dart)
    │   └── ProfilePage (Built-in with Login/Register)
    │
    └── Bottom Navigation (4 Tabs)
        ├── Home (Beranda)
        ├── Search (Pencarian)
        ├── Cart (Pesanan)
        └── Profile (Profil)
```

---

## Features

### 1. **Home/Store Page** (`store.dart`)
- **Featured Products:** Display featured Pokémon with details
- **Search Functionality:** Search Pokémon by name (local filter)
- **Category Filtering:** Filter by type (Api, Air, Listrik, Rumput, Psikis)
- **Product Display:** Show price, rating, description, and type
- **Quick Add:** Add items to cart with quantity selector
- **Quantity Management:** Increment/decrement quantity before purchase

**Key Components:**
- `HomePage`: Main stateful widget
- `PokemonCategory`: Category selection widget with callbacks
- `FeaturedPokemon`: Featured product card with quantity controls
- `PokemonItem`: Individual product card display

### 2. **Search Page** (`listSearch.dart`)
- **API Integration:** Fetch Pokémon list from PokeAPI
- **Dynamic Data Loading:** Fetch 100 Pokémon entries from external API
- **List Display:** Show Pokémon with images and names
- **Loading State:** Display spinner during data fetch
- **Error Handling:** Handle API failures gracefully

**API Used:** `https://pokeapi.co/api/v2/pokemon?limit=100`

### 3. **Authentication Pages**

#### Login Page (`login.dart`)
- **Firebase Authentication:** Sign in with email/password
- **Session Persistence:** Check if user is already logged in
- **Error Handling:** Display specific error messages
  - User not found
  - Wrong password
  - Invalid email format
- **User State Display:** Show logged-in user's email
- **Logout Functionality:** Sign out and clear session
- **Navigation:** Navigate to registration page

**Features:**
- Email and password input fields
- Loading indicator during login
- "Forgot Password?" placeholder
- Signup navigation link
- Display user info when logged in

#### Register Page (`register.dart`)
- **Form Validation:** Validate all input fields
- **Firebase Auth:** Create new user account
- **Firestore Integration:** Store user profile data
- **Password Confirmation:** Ensure password match
- **Email Validation:** Check email format
- **Password Requirements:** Minimum 6 characters
- **Error Messages:** Display validation and auth errors

**Validation Rules:**
- Name: Required, non-empty
- Email: Required, valid format (regex validation)
- Password: Required, minimum 6 characters
- Confirm Password: Must match password

### 4. **Profile/Account Page** (Built-in to BaseLayout)
- **Tabbed Interface:** 3 tabs (Profil, Login, Daftar)
- **Profile Tab:** Display user icon (placeholder)
- **Login Tab:** Integrated login form with navigation
- **Register Tab:** Integrated registration form with navigation
- **Quick Navigation:** Buttons to switch between tabs

### 5. **Shopping Cart Page** (`cart.dart`)
- **Status:** Currently Work-in-Progress (WIP)
- **Placeholder:** Shows "Cart Page" message
- **Future Implementation:** Will display cart items and checkout

---

## Page Documentation

### Main Application Entry (`main.dart`)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

**Purpose:**
- Initialize Flutter bindings
- Initialize Firebase with platform-specific options
- Launch the application

**MyApp Widget:**
- **Theme:** Red primary color with Poppins font family
- **Home:** BaseLayout (root widget)
- **Debug Banner:** Disabled

---

### Base Layout (`layouts/base.dart`)

**Type:** StatefulWidget

**Key Features:**
- **Bottom Navigation Bar:** 4-tab navigation system
- **Page Stacking:** Uses IndexedStack to maintain state
- **AppBar Actions:**
  - Shopping cart icon (navigates to cart tab)
  - Notification bell icon (shows snackbar)
- **Current Pages List:**
  1. HomePage - Store/Home
  2. ListSearchPage - Pokémon search
  3. CartPage - Shopping cart
  4. Profile Page (TabController with Login/Register)

**State Management:**
```dart
int _currentIndex = 0;  // Current active tab
late final List<Widget> _pages;  // List of pages

void _onTabTapped(int index) {
  setState(() {
    _currentIndex = index;
  });
}
```

**AppBar Configuration:**
```dart
AppBar(
  title: 'PokeShop',
  elevation: 0,
  actions: [
    Shopping cart icon button,
    Notification bell icon button
  ]
)
```

---

## State Management

The application uses Flutter's built-in state management through:

1. **StatefulWidget Pattern:** Local state management for individual pages
2. **setState():** Update UI when state changes
3. **TextEditingController:** Manage text input fields
4. **Callbacks:** Pass data between widgets (onCategorySelected, onNavigateToRegister)

### Example: Category Selection Flow
```
PokemonCategory (button click)
    ↓
_updateKategori() in _PokemonCategoryState
    ↓
setState() + callback to parent
    ↓
HomePage updates _selectedData
    ↓
FeaturedPokemon rebuilds with new data
```

---

## Firebase Integration

### Services Used:
1. **Firebase Authentication**
   - Email/password authentication
   - Session persistence checking
   - Sign out functionality

2. **Cloud Firestore**
   - Store user profiles during registration
   - Collection: `users`
   - Document ID: User UID
   - Fields: name, email, createdAt

### Configuration:
- Initialized in `main.dart`
- Platform-specific options in `firebase_options.dart`
- Uses Flutter Dotenv for sensitive configuration

### Authentication Flow:

**Login Flow:**
```
1. User enters email & password
2. Firebase.signInWithEmailAndPassword()
3. If success: Update state (_isLoggedIn = true)
4. If error: Display specific error message
5. Show SnackBar with welcome message
```

**Register Flow:**
```
1. Validate all form fields
2. Firebase.createUserWithEmailAndPassword()
3. If success:
   - Save to Firestore (users/{uid})
   - Navigate to login tab
4. If error: Display error message
```

### Data Schema (Firestore):
```json
users/{uid}
├── name: String
├── email: String
└── createdAt: Timestamp (server-generated)
```

---

## API Integration

### PokeAPI Integration (`listSearch.dart`)

**Endpoint:** `https://pokeapi.co/api/v2/pokemon?limit=100`

**Purpose:** Fetch list of Pokémon for the search page

**Implementation:**
```dart
Future<void> fetchPokemonList() async {
  final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100');
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data['results'] as List;
    
    setState(() {
      pokemonList = results
          .map((pokemon) => pokemon['name'] as String)
          .toList();
      isLoading = false;
    });
  }
}
```

**Data Handling:**
- Converts JSON response to List<String> of Pokémon names
- Handles loading state with spinner
- Failed requests show silent error (no exception thrown)

**Image Display:**
- Uses raw GitHub sprites: `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/{index}.png`
- Displays Pokémon sprite next to each name in list

---

## UI/UX Components

### Color Scheme
- **Primary Color:** Red (Colors.red)
- **Secondary Colors:** 
  - Red Accent (RedAccent)
  - Blue Accent (Water type)
  - Yellow Accent (Electric type)
  - Green Accent (Grass type)
  - Purple Accent (Psychic type)
- **Neutral:** Grey (for secondary text and borders)

### Typography
- **Font Family:** Poppins (throughout app)
- **Heading Size:** 24-25 px, Bold
- **Subheading:** 18 px, Bold
- **Body Text:** 14-16 px, Regular
- **Small Text:** 12 px, Regular/Light

### Common Widgets Used
1. **Material Widgets:**
   - Scaffold, AppBar, BottomNavigationBar
   - ElevatedButton, TextButton, IconButton
   - TextField, TextFormField, Form
   - Card, Container, Column, Row
   - ListView, GridView

2. **Custom Layouts:**
   - IndexedStack (for page switching)
   - SingleChildScrollView (for scrollable content)
   - DefaultTabController (for profile tabs)

3. **Input Components:**
   - TextField with decorations
   - TextFormField with validators
   - Controllers for text management

### Responsive Design
- Uses `MediaQuery` for screen size detection in login page
- Responsive padding and sizing
- Flexible widgets for adaptive layouts

---

## User Flow

### First-Time User Journey

```
Launch App
    ↓
MyApp (Theme Setup)
    ↓
BaseLayout (Navigation Hub)
    ↓
┌─────────────────────────────┐
│ Explore Store (Home Tab)    │
│ - Browse featured Pokémon   │
│ - Browse by category        │
│ - Search Pokémon            │
└─────────────────────────────┘
    ↓
Click Profile → Login Tab
    ↓
┌─────────────────────────────┐
│ Not Logged In State         │
│ - Show login form           │
│ - Option: Click signup link │
└─────────────────────────────┘
    ↓ (if signup)
Register Tab
    ↓
Fill registration form & submit
    ↓
Account created, navigate to login
    ↓
Login with credentials
    ↓
Login success - Show user email
    ↓
Browse & add items to cart
    ↓
Checkout (future feature)
```

### Returning User Journey

```
Launch App
    ↓
BaseLayout (Navigation Hub)
    ↓
User can:
- Browse store immediately
- Search Pokémon
- View profile (already logged in)
- Add to cart
- Checkout (future)
```

---

## Development Setup

### Prerequisites
- Flutter SDK (^3.7.2)
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for emulators)
- Firebase account and project setup

### Installation Steps

1. **Clone Repository**
   ```bash
   git clone [repository-url]
   cd flutter-numiii-app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Firebase**
   - Create Firebase project in Firebase Console
   - Download `google-services.json` (Android)
   - Download `GoogleService-Info.plist` (iOS)
   - Place files in appropriate directories

4. **Environment Configuration**
   - Create `.env` file in project root
   - Add Firebase configuration variables

5. **Run Application**
   ```bash
   flutter run
   ```

6. **Build Release**
   ```bash
   # Android
   flutter build apk
   
   # iOS
   flutter build ios
   
   # Web
   flutter build web
   ```

---

## Future Enhancements

### Planned Features (Based on Memory/Roadmap)

1. **Shopping Cart Implementation**
   - Complete cart.dart page
   - Add item quantity management
   - Implement cart persistence
   - Calculate total price

2. **Checkout Flow**
   - Payment integration
   - Order summary
   - Shipping details
   - Order confirmation

3. **Product Details Page**
   - Expanded Pokémon information
   - Full description and stats
   - Customer reviews/ratings
   - Related products

4. **Transaction History**
   - Display past purchases
   - Order tracking
   - Reorder functionality

5. **Form Validation Enhancements**
   - Better validation messages
   - Real-time validation feedback
   - Field-level error handling

6. **Error Handling Improvements**
   - Global error handling
   - Network error recovery
   - Offline mode support

7. **Responsive UI**
   - Tablet/Desktop layout optimization
   - Landscape mode support
   - Different screen size handling

8. **User Experience**
   - Favorite items feature
   - Wishlist functionality
   - Product recommendations
   - Search autocomplete

9. **Dynamic Data**
   - Connect store to Firestore
   - Real inventory management
   - Dynamic pricing
   - Product images from storage

10. **Performance Optimizations**
    - Image caching
    - Lazy loading
    - State management refactor (Provider/Riverpod)
    - Code splitting

---

## Important Notes

### Current Limitations

1. **Hard-coded Data:** Product data is hard-coded in store.dart
2. **Cart Functionality:** Cart page is not implemented yet
3. **Persistence:** Cart items not persisted between sessions
4. **Search:** Home page search is local-only filter
5. **Images:** Uses external URLs (imagekit.io, GitHub, PokeAPI)
6. **User Profile:** Limited profile information stored

### Security Considerations

1. **Firebase Rules:** Ensure proper Firestore security rules are set
2. **API Keys:** Don't commit Firebase config to version control
3. **Password Security:** Firebase handles password encryption
4. **Session Management:** Automatic Firebase session handling

### Performance Tips

1. Image caching for network images
2. Use `const` constructors where possible (many are used)
3. Avoid rebuilding entire widgets
4. Lazy load data when needed
5. Use IndexedStack to maintain page state

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Firebase initialization error | Verify google-services.json in correct location |
| Network timeout on API call | Check internet connection, API endpoint availability |
| Login always shows loading | Check Firebase configuration and connectivity |
| Images not loading | Verify network availability and image URLs |
| Hot reload issues | Use `flutter clean && flutter pub get` |

---

## References

- [Flutter Documentation](https://flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [PokeAPI Documentation](https://pokeapi.co/docs/v2)
- [Material Design Guidelines](https://material.io/design)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-06-01 | Initial application with auth and basic store |

---

**Last Updated:** June 1, 2026  
**Maintained By:** Development Team  
**Status:** Active Development
