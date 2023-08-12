# Marvel Universe

![Coverage](https://raw.githubusercontent.com/cjamcu/marvel_universe/main/coverage_badge.svg)
![Flutter Version](https://img.shields.io/badge/flutter-3.10.6-blue)

Step into the Marvel universe like never before with our one-of-a-kind app. When you choose a character, you'll dive
into their world through their photo, name, and a detailed description. What's more, we've added the feature to search
for characters by name, enhancing your experience even further. On the technical side, this project is built using
Flutter, leveraging the robust BLoC state management. We've embraced a clean architecture, following a layered
structure, and adhered to the SOLID principles to ensure a robust and scalable codebase.

## Installation

- Run `git clone https://github.com/cjamcu/marvel_universe.git` to clone the repository
- Run `cd marvel_universe` to enter the project directory
- Change name of .env.example to .env and add your public and private keys from marvel api to the file. (In this case
  the keys are already added for more easy testing. **This is not recommended in a real project**)
- Run `flutter pub get` to install dependencies
- Run `flutter run` to run the app

## Features

- [x] View all characters with infinite scrolling
- [x] Search for characters by name
- [x] View character details



## Architecture Proposal

The architecture of the project is based on the Clean Architecture. This architectural pattern promotes separation of concerns and maintainability by dividing the project into distinct layers: presentation, domain, and data.

### Presentation Layer
In the presentation layer, we handle the user interface, application logic, and state management using the BLoC pattern. Each screen corresponds to a Bloc which manages the state and interactions of the UI components.

### Domain Layer
The domain layer contains the core business logic of the application. It includes use cases that encapsulate the interactions between the presentation and data layers. The entities in this layer represent the core data structures, while the repositories define the contract for data retrieval.

### Data Layer
The data layer is responsible for interacting with external data sources, such as APIs or databases. It includes the implementation of the repositories defined in the domain layer, as well as data models that map to the external data structures.

Using this architecture has several benefits, including:

- **Modularity:** Each layer is independent, making it easier to replace or modify components without affecting the entire system.
- **Testability:** The separation of concerns allows for easier unit testing of individual components.
- **Scalability:** The architecture is designed to accommodate growth and new features without compromising the existing codebase.

![Architecture Proposal](https://raw.githubusercontent.com/cjamcu/marvel_universe/main/images/clean-architecture.webp)


## Dependencies

We've leveraged a range of external dependencies to enhance the functionality and performance of the app. Each
dependency serves a specific purpose, contributing to the overall experience:

- flutter_bloc: ^8.1.3
- get_it: ^7.6.0
- equatable: ^2.0.5
- cached_network_image: ^3.2.3
- http: ^1.1.0
- flutter_dotenv: ^5.1.0
- crypto: ^3.0.3
- bloc: ^8.1.2
- url_launcher: ^6.1.12
- mocktail: ^1.0.0
- bloc_test: ^9.1.4
- responsive_grid: ^2.4.2
- device_preview: ^1.1.0

