Project: WeatherApp

A SwiftUI-based iOS weather application. This repository contains the app entry, core utilities (networking, formatting, error types), domain entities and repositories, data layer implementations, feature modules (overview, hourly/daily forecasts, weather details), shared UI components and assets.

Build
- Open WeatherApp.xcodeproj in Xcode and run on a simulator or device.

Repository structure (top-level)
- App/: app entry, view model factory and container
- Core/: networking, config, formatters and errors
- Data/: API and repository implementations
- Domain/: entities, repository interfaces and use cases
- Features/: UI features and presentation layers
- Models/: plain models/value objects
- SharedUI/: reusable UI components and modifiers
- Assets.xcassets/: app assets

Recent work
- Multiple focused commits were created to organize existing files into logical commits (Core, App, Data, Features, SharedUI, Assets). See CHANGELOG.md for details.
