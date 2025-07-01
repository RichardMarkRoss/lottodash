# Lotto Dash 🎰

**Lotto Dash** is a South African Lotto ticket management and analytics system. It helps users scan, track, and receive results for their lotto tickets in a simple, streamlined way.

---

## 🧩 Key Features

- 📸 **Ticket Scanner**  
  Instantly scan your lotto tickets using your phone camera.

- 💾 **Ticket Storage**  
  All scanned tickets are saved locally or in the cloud for easy reference.

- 🔔 **Smart Notifications**  
  Get notified when the draw results are available, and find out if your ticket has won.

- 📊 **Analytics Dashboard** *(coming soon)*  
  Gain insights into your ticket history, numbers, and patterns.

---

## 📱 Tech Stack

- **Flutter** (Frontend app)
- **Google ML Kit** (OCR for ticket scanning)
- **Firebase / Supabase** *(optional)* for storage and notifications
- **shadcn_flutter** for beautiful, responsive UI components

---

## 🚀 Getting Started

### Prerequisites

- Flutter 3.22+
- Dart SDK
- Android Studio / Xcode / VS Code
- (Optional) Firebase account for backend support

### Installation

```bash
git clone https://github.com/your-username/lotto-dash.git
cd lotto-dash
flutter pub get
flutter run
```

---

## 🗂️ Project Structure

```
lib/
├── main.dart
├── features/
│   ├── scanner/           # Camera & OCR logic
│   ├── tickets/           # Ticket model, list, and storage
│   ├── notifications/     # Push/local notification handling
│   └── analytics/         # Win history, number stats (upcoming)
├── ui/
│   └── components/        # shadcn_flutter UI components
└── utils/
    └── helpers.dart       # Utility functions
```

---

## 📦 Packages Used

- `camera`
- `google_ml_kit`
- `flutter_local_notifications`
- `shadcn_flutter`
- `provider` or `riverpod` (for state management)

---

## 🛠️ Development Plans

- [ ] Implement number frequency analysis
- [ ] Add backup & sync (cloud storage)
- [ ] Support PowerBall and Daily Lotto
- [ ] Multi-ticket batch scanning
- [ ] Dark/light theme toggle

---

## 👥 Contributing

PRs are welcome! If you’d like to contribute:

1. Fork this repo
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -am 'Add feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a PR

---

## 📄 License

MIT License. See `LICENSE` file for details.

---

## ✨ Credits

Created by [Your Name] — inspired by the real frustrations of checking lotto results manually in South Africa.
