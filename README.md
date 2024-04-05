# QUIZZY

A trivia questions game, with interactive experiences

## How to Run the Project

### Running using Local Database

To run the project using the local database, simply execute inside the `quizzy` directory:  **flutter run**

### Generating QR Code

To generate the QR code, follow these steps:

1. Navigate to the `quizzy/lib/services` directory.
2. Run the QR code generator script with: **python3 qr_generator.py**

### Running using External MongoDB Database

To use an external MongoDB database, make sure your device is connected to the same network as your computer.

#### Running the API

1. Navigate to the `Flutter/backend` directory.
2. Start the API server by running: **uvicorn app:app --host 0.0.0.0 --port 8000**

#### Running the Flutter App

After you have the API server running, proceed to run the Flutter app:

1. Go to the `Flutter/quizzy` directory.
2. Execute: **flutter run** as before.


