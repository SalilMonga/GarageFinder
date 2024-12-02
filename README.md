# Garage Finder

Garage Finder is an app designed to help users locate, navigate, and manage parking spaces near schools, universities, and organizations. This repository contains both the **frontend (Flutter app)** and the **backend (Node.js API)** as a submodule.

---

## 🚀 Features

- Search for schools and organizations.
- View parking maps and manage favorite spots.
- Backend API integration for dynamic content.

---

## 📂 Project Structure

```
garagefinder/
├── frontend/                 # Flutter app
├── backend/                  # Backend API (submodule)
└── README.md                 # Documentation
```

---

## 🔧 Getting Started

### Prerequisites

- **Flutter SDK** installed ([Flutter Installation Guide](https://docs.flutter.dev/get-started/install)).
- **Node.js** installed ([Node.js Installation Guide](https://nodejs.org)).

---

### Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone --recurse-submodules <https://github.com/SalilMonga/GarageFinder/tree/main/garagefinder>
   cd garagefinder
   ```

2. **Initialize and Update Submodules**

   ```bash
   git submodule update --init --recursive
   ```

3. **Setup the Frontend**

   ```bash
   cd frontend
   flutter pub get
   ```

4. **Setup the Backend**

   ```bash
   cd ../backend
   npm install
   ```

5. **Run the Frontend**

   ```bash
   cd ../frontend
   flutter run
   ```

6. **Run the Backend**
   ```bash
   cd ../backend
   node server.js
   ```

---

## 🔧 Running the App Locally

- **Frontend**: Runs on the device or emulator.
- **Backend**: Available at `http://localhost:3000`.

---

## 🌟 Contributing

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request.

---

## 🛡️ License

This project is licensed under the MIT License.
