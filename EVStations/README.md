EVStations

EVStations is an iOS app built with SwiftUI, Combine, and async/await networking.  
It displays nearby electric vehicle (EV) charging stations using the [Open Charge Map API](https://openchargemap.org/).  
Users can browse a list of chargers and view station details, including map location and connector information.

---

Architecture

This app follows the MVVM (Model-View-ViewModel) pattern:

- Model
  - `Station`, `EVStation`, `AddressInfo`, `Connection`, etc.
  - Represent EV charger data fetched from the API.
- ViewModel
  - `StationsListViewModel`  
    - Handles fetching stations via `StationServiceProtocol`.  
    - Publishes `ViewState` (`loading`, `loaded`, `error`) to update the UI.
- Views
  - `StationListView` – Displays a list of stations or a loading/error state.  
  - `StationDetailView` – Shows station details and an embedded map.  
- Service Layer
  - `StationService` (concrete implementation of `StationServiceProtocol`)  
    - Uses `NetworkManagerActions` to make API requests.  
  - `NetworkManager` – Generic HTTP client using `URLSession`.

This separation of concerns makes the app testable, maintainable, and scalable.

---

Unit Testing

We focused testing on the ViewModel layer, since UI rendering is handled by SwiftUI and data models are largely passive.

Testing Focus Areas
- Mocked Service:  
  - Created `MockStationService` to simulate `StationServiceProtocol` behavior.
- State Transitions:  
  - Verifies that `StationsListViewModel` correctly updates `viewState` to:
    - `.loading` initially
    - `.loaded([Station])` when data is returned
    - `.error(String)` when an error occurs
- Edge Cases:  
  - Empty station list.
  - API failure with error message.

By mocking dependencies, we avoid making network calls and ensure tests are fast, deterministic, and isolated.
