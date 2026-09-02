---
trigger: model_decision
description: Use these rules when writing, updating, or designing tests (Unit Test, Widget Test, Integration Test) in the application.
---

# Testing Rules

The guidelines and strategy for writing tests in this application focus on effectiveness and scalability, avoiding
low-value tests.

## 1. Unit Test (Highest Priority)

Unit tests are the most crucial layer. Every core logic in the application must have unit tests with high coverage.

* **Focus:** Business logic, Notifiers/Controllers (like Riverpod), Repositories (mapping from row/DTO to domain model),
  calculations, data formatting.
* **Why:** They execute extremely fast, are easy to debug, and ensure the application's foundation won't easily break
  (regression).
* **Target:** Mandatory when developing new features involving data processing or state management.

## 2. Widget Test (Secondary Priority - Selective)

Not all widgets need to be tested. Avoid testing small or trivial widgets that only handle static layouts (such as
static `Card`, `Container`, text, padding).

* **When to test a Widget:**
    * **Complex / Stateful:** The widget contains branching logic (if/else), handles user interactions independently, or
      has state variations (e.g., loading, error, custom animations).
    * **Reusable Component:** Core components used massively throughout the application (e.g., `PokaPocketSelector`,
      `Keypad`, custom buttons, custom input forms). If one breaks, everything breaks.
    * **Main Pages / Screens:** To ensure all small components integrate well and the state connects correctly to the
      UI.
* **Why:** Writing widget tests for static components is a waste of time and only tests the Flutter framework itself,
  not the application logic. Focus on interactions.

## 3. Integration Test (End-to-End)

Reserved for core user journeys (critical paths) where the entire application runs together (often including a real or
fully mocked database).

* **Focus:** Navigating the application from a real user's perspective (e.g., launch app -> add expense transaction ->
  save -> verify balance changes on the dashboard).
* **Why:** To catch integration issues at the highest architectural level that might go undetected by separate Unit or
  Widget tests.