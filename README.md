# Vollmed

A medical appointment scheduling app built with SwiftUI that consumes a REST API.

## Overview

Vollmed is a project developed during an [Alura Course](https://unibb.alura.com.br/course/ios-swiftui-aplicacoes-interativas-crud-apis-rest), where the main focus was on learning how to interact with REST APIs. While the original course project focused primarily on teaching HTTP verbs and basic API consumption, I enhanced the implementation by applying Clean Architecture principles and MVVM pattern.

## Key Features

- User registration and authentication
- Medical appointment scheduling, viewing, and cancellation
- Secure password storage using Keychain
- Robust error handling

## Technical Enhancements

### Architecture

I restructured the entire project to follow Clean Architecture principles combined with MVVM pattern:

- **Domain Layer**: Contains business logic, models, and interfaces
- **Data Layer**: Implements data sources and repositories
- **Presentation Layer**: Includes ViewModels and Views using SwiftUI

### API Consumption

Created a generic system for API consumption that:

- Supports all HTTP verbs (GET, POST, PUT, DELETE)
- Features a generic service creation pattern for different APIs
- Implements proper request composition (URL, headers, body, etc.)
- Handles responses and error management systematically

### Security

- Implemented Keychain helpers for secure password storage

## Technologies Used

- SwiftUI
- Combine
- URLSession
- Keychain
- Codable for JSON parsing
- MVVM + Clean Architecture

## What I Learned

- Complete understanding of HTTP verbs and their proper usage
- Implementing Clean Architecture in SwiftUI projects
- Creating generic and reusable API service layers
- Proper error handling in network requests
- Secure credential storage using Keychain
- Building interactive user interfaces with SwiftUI

## Getting Started

1. Clone the repository
2. Open the project in Xcode
3. Run the application on a simulator or device


## Acknowledgements

- [Alura](https://unibb.alura.com.br/course/ios-swiftui-aplicacoes-interativas-crud-apis-rest) for providing the foundational course
- The REST API provided during the course for testing purposes
