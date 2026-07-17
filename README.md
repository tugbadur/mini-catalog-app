# Mini Catalog App

Mini Catalog App is a Flutter-based mobile catalog application developed as the final project of a five-day introductory Flutter training program. The application retrieves products from a remote API and allows users to browse, search, filter, inspect, and add products to a simulated shopping cart.

The application interface is in English.

## Repository

[github.com/tugbadur/mini-catalog-app](https://github.com/tugbadur/mini-catalog-app)

## Features

- Dynamic product listing with `GridView.builder`
- Product data retrieved from the Fake Store API
- Loading, error, retry, and empty-result states
- Search by product title, category, or description
- Category filtering through a custom modal dialog
- Product detail page with route arguments
- Product quantity selector
- Add-to-cart functionality
- In-memory cart state management with `ValueNotifier`
- Combining quantities when the same product is added again
- Removing products from the cart
- Hiding checkout controls when the cart is empty
- Simulated checkout and payment confirmation dialog
- Automatic cart clearing after payment confirmation
- Local banner image with `Image.asset`
- Network image loading and error placeholders
- Responsive Material Design interface

## Technologies and Tools

- Flutter SDK 3.38.4 (stable)
- Dart SDK 3.10.3
- Material Design (`material.dart`)
- Visual Studio Code
- Android Studio / Android Emulator
- Fake Store API

No additional runtime packages are used. The project relies only on Flutter and Dart SDK libraries.

## Data Source

Product information is retrieved from:

- [Fake Store API](https://fakestoreapi.com/products)

The API is used for educational and demonstration purposes. It does not represent a real e-commerce infrastructure.

The following product fields are used in the application:

- `id`
- `title`
- `price`
- `description`
- `category`
- `image`
- `rating.rate`
- `rating.count`

## Project Structure

```text
mini_catalog_app/
├── assets/
│   └── images/
│       └── banner.png
├── lib/
│   ├── models/
│   │   └── product_model.dart
│   ├── services/
│   │   └── product_service.dart
│   ├── stores/
│   │   └── cart_store.dart
│   ├── widgets/
│   │   └── product_network_image.dart
│   ├── cart_page.dart
│   ├── home_page.dart
│   ├── main.dart
│   └── product_details_page.dart
└── pubspec.yaml
```

## Application Pages

### Home Page

Displays the local banner and products retrieved from the API. Users can search products, select a category filter, open product details, or navigate to the cart.

### Product Details Page

Receives the selected `ProductModel` through the page constructor. It displays the product image, price, title, category, and description. Users can choose a quantity and add the product to the cart.

### Cart Page

Displays products added to the cart with their quantities. Products can be removed, and checkout can be completed through a simulated payment confirmation dialog.

## Getting Started

### Requirements

Before running the project, install the following tools:

- Flutter SDK 3.38.4 or a compatible stable version
- Dart SDK 3.10.3 or a compatible version
- Android Studio with an Android Emulator, or a physical Android device
- Visual Studio Code or another Flutter-compatible IDE
- An active internet connection for loading products and product images

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/tugbadur/mini-catalog-app.git
   ```

2. Open the project directory:

   ```bash
   cd mini_catalog_app
   ```

3. Install project dependencies:

   ```bash
   flutter pub get
   ```

4. Check the Flutter environment:

   ```bash
   flutter doctor
   ```

5. Start an Android Emulator or connect a physical Android device.

6. Run the application:

   ```bash
   flutter run
   ```

## Screenshots

Application screenshots will be added before the final project submission.

## Educational Outcomes

This project demonstrates:

- Stateless and Stateful widget usage
- Flutter widget tree and layout fundamentals
- Collections and null safety in Dart
- Navigation with `Navigator.push`, `Navigator.pop`, and `MaterialPageRoute`
- Passing data between pages
- JSON parsing with `fromJson` and `toJson`
- Dynamic lists with `GridView.builder` and `ListView.builder`
- Local and network image usage
- Asynchronous API requests
- Basic search and filtering
- Simple state management and cart simulation
- Organized model, service, store, widget, and page structure

## Notes

- Cart data is stored in memory and resets when the application is restarted.
- Checkout is a simulation and does not process real payments.
- Product availability and content depend on the Fake Store API.
