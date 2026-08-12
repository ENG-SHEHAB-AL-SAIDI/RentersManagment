# Renters Management — Short (Interview style)

## Purpose
A mobile-first renters and property management system: the Flutter client lets property managers track buildings, renters, rent payments, statements, and yearly reports while a server-side API provides authentication, data persistence and business logic.

## Key features (high level)
- Manage buildings and units, tenants and contact details
- Record and group rent payments, installments and payment history
- Generate and store financial statements and incomes/expenses per period
- Year-based operations (assign/remove year records to renters/buildings)
- Authentication and token-based session flow for mobile clients

## Technology highlights
- Frontend: Flutter (Dart) mobile app — GetX for state/routing, Dio for HTTP, local storage for credentials and tokens, PDF generation/printing and app icons/assets management
- Backend: Laravel PHP API — RESTful controllers and routes that expose auth endpoints and protected /user/* resources (builds, renters, rent_payments, statements, year operations)
- Auth: JWT-based tokens for mobile authentication and refresh flows
- Data & storage: standard relational database usage (MySQL/Postgres or SQLite for quick local setup) and filesystem-backed assets where needed
- Integrations & utilities: shared preferences on client, PDF/printing support, and common Laravel tooling (artisan, migrations) on server

## How it fits together
The mobile app calls the API for everything: users register/login, then make authenticated requests to list and mutate buildings, renters, payments and statements. The backend enforces business rules and persists data; the frontend stores tokens and presents UI for managing properties and finances.

## Repo layout (one line)
`renters_management_front_end/` (Flutter client) — `renters_management_back_end/` (Laravel API)

## Contact
Maintainer: ENG-SHEHAB-AL-SAIDI — open an issue or PR in the repository for follow-ups.
