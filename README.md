# Nebula 🌌

Nebula is a high-performance productivity assistant built with Flutter. It leverages isolate-based PDF parsing and Google's Gemini AI to transform static documents into actionable insights, summaries, and structured data.

## 🚀 Features

- **Isolate-Based PDF Parsing**: Offloads heavy text extraction tasks to Dart isolates (background threads) to ensure a jank-free, 60 FPS UI experience.
- **AI-Powered Analysis**: Integrates with Gemini AI to generate concise summaries, identify key points, and extract structured insights from complex documents.
- **Advanced PDF Viewing**: High-fidelity PDF rendering and navigation using Syncfusion's PDF viewer.
- **Local Persistence**: Stores processed metadata and analysis results locally using Drift (SQLite) for offline access.
- **Generative UI**: Dynamic rendering of AI-generated insights for a seamless user experience.
- **Privacy-First**: Focuses on processing local files with secure API integration.

## 🏗️ Architecture Overview

Nebula follows a clean, feature-driven architecture to ensure scalability and maintainability:

`PDF File` ➡️ `Compute/Isolate (Extraction)` ➡️ `Gemini AI (Analysis)` ➡️ `Bloc (State Management)` ➡️ `UI (Rendering)`

1.  **Extraction Layer**: Uses `syncfusion_flutter_pdf` within a background isolate to parse raw text without blocking the main thread.
2.  **Intelligence Layer**: Sends structured text prompts to the Gemini API via `flutter_gemini` or `firebase_vertexai`.
3.  **State Management**: Utilizes `flutter_bloc` to handle asynchronous flows between the UI and data layers.
4.  **Storage Layer**: `Drift` provides a reactive local database for history and results management.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **PDF Engine**: [Syncfusion Flutter PDF](https://pub.dev/packages/syncfusion_flutter_pdf)
- **AI Integration**: [Google Gemini AI](https://pub.dev/packages/flutter_gemini)
- **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- **Local Database**: [Drift](https://drift.simonbinder.eu/) (SQLite)
- **Concurrency**: Dart Isolates (`compute` function)

## 📁 Project Structure

```text
lib/
├── app/                # Global app configuration and themes
├── core/               # Shared utilities, constants, and base classes
└── features/           # Feature-based modules
    ├── pdf_reader/      # PDF viewing and navigation components
    ├── pdf_analysis/    # Isolate-based parsing and AI logic
    ├── pdf_results/     # UI for displaying AI-generated insights
    └── pdf_management/  # File picking and local history management
```

## ⚙️ Setup & Installation

### Prerequisites
- Flutter SDK (latest stable version)
- A Gemini API Key from [Google AI Studio](https://aistudio.google.com/)

### Steps
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/nebula.git
    cd nebula
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure Environment**:
    Create a `.env` file in the root directory and add your API key:
    ```env
    API_KEY=your_gemini_api_key_here
    ```

4.  **Run the application**:
    ```bash
    flutter run
    ```

## 📖 Usage

1.  **Import**: Tap the "Plus" button or use the file picker to select a PDF document from your device.
2.  **Parse**: The app automatically triggers a background isolate to extract text from the file.
3.  **Analyze**: Select the type of analysis (Summary, Key Points, etc.) and let Gemini process the content.
4.  **Review**: View the structured insights in a clean, generative UI and save them to your local history.

## 🔮 Future Improvements

- [ ] **OCR Support**: Integration for image-based PDFs using ML Kit.
- [ ] **Multi-file Chat**: Ability to query across multiple uploaded documents.
- [ ] **Calendar Integration**: Automatically suggest and create calendar events based on document dates.
- [ ] **Export Options**: Export AI insights to PDF, Markdown, or Notion.

---
*Built with ❤️ using Flutter and Gemini.*
