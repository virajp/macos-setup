---
name: google-maps
description:
  Google Maps SDK patterns for the 95octane backend. Use when writing or
  modifying code in packages/common/src/maps/ that calls @googlemaps/places or
  @googlemaps/routing.
version: 2.0.0
---

# Google Maps SDK Patterns

Precise reference for `@googlemaps/places@2.4.0` and `@googlemaps/routing@2.2.0`
as used in `packages/common/src/maps/`.

All SDK calls are wrapped in Effect and live in `packages/common`. The service
only imports from `@95octane/common/maps/*` — never directly from the SDK.

---

## SDK Clients

Each function instantiates a fresh client per call. Auth via ADC automatically.

```typescript
import { PlacesClient } from "@googlemaps/places";
import { RoutesClient } from "@googlemaps/routing";
```

---

## Places API — `searchText`

Method: `client.searchText(request, callOptions)`

**Request type: `ISearchTextRequest`**

```typescript
{
  textQuery: string;                  // Required
  languageCode?: string;
  regionCode?: string;
  rankPreference?: 0 | 1 | 2;        // 0=UNSPECIFIED, 1=DISTANCE, 2=RELEVANCE
  includedType?: string;              // Only ONE type (not an array)
  openNow?: boolean;
  minRating?: number;                 // 0–5 in 0.5 increments
  maxResultCount?: number;            // 1–20, default 20
  priceLevels?: PriceLevel[];
  strictTypeFiltering?: boolean;
  locationBias?: ILocationBias;       // See below — cannot use with locationRestriction
  locationRestriction?: ILocationRestriction; // Rectangle ONLY (no circle!)
  includePureServiceAreaBusinesses?: boolean;
  includeFutureOpeningBusinesses?: boolean;
}
```

**`ILocationBias`** — oneof `rectangle` | `circle`:

```typescript
{
  circle?: {
    center: { latitude: number; longitude: number };  // google.type.ILatLng
    radius: number;                                    // meters
  };
  rectangle?: IViewport;  // { low: ILatLng, high: ILatLng }
}
```

**`ILocationRestriction`** (searchText) — rectangle ONLY:

```typescript
{
  rectangle: IViewport;
} // No circle support for searchText restriction!
```

**Response: `response[0].places`** — array of `IPlace`

**Field mask** (sent via `X-Goog-FieldMask` header, keys prefixed `places.`):

```typescript
const fieldMasks = [
  "places.businessStatus",
  "places.displayName",
  "places.formattedAddress",
  "places.googleMapsUri",
  "places.id",
  "places.location",
  "places.name",
  "places.photos",
  "places.types",
];
const callOptions = {
  timeout: 4_000,
  otherArgs: { headers: { "X-Goog-FieldMask": fieldMasks.join(",") } },
};
```

**Location bias wiring** — both fields required to activate:

```typescript
const request: ISearchTextRequest = {
  textQuery: options.text,
  regionCode: options.regionCode,
  languageCode: options.languageCode,
};
if (options.currentLocation && options.radius) {
  request.locationBias = {
    circle: {
      center: {
        latitude: options.currentLocation.lat,
        longitude: options.currentLocation.lng,
      },
      radius: options.radius,
    },
  };
}
```

---

## Places API — `getPlace`

Method: `client.getPlace(request, callOptions)`

**Request type: `IGetPlaceRequest`**

```typescript
{
  name: string;         // Required — "places/{place_id}" format
  languageCode?: string;
  regionCode?: string;
  sessionToken?: string; // Only for billing grouping after autocompletePlaces
}
```

**Response: `response[0]`** — single `IPlace` object

**Field mask** — keys have NO `places.` prefix (unlike searchText):

```typescript
const fieldMasks = [
  "businessStatus",
  "displayName",
  "formattedAddress",
  "googleMapsUri",
  "id",
  "location",
  "name",
  "photos",
  "types",
];
```

---

## Places API — `getPhotoMedia`

Method: `client.getPhotoMedia(request, callOptions)`

**Request type: `IGetPhotoMediaRequest`**

```typescript
{
  name: string;          // Required — "places/{id}/photos/{ref}/media" (append /media)
  maxWidthPx?: number;   // 1–4800 px (NOT 1024 — that's just our app default)
  maxHeightPx?: number;  // 1–4800 px
  skipHttpRedirect?: boolean;
  // At least one of maxWidthPx or maxHeightPx MUST be specified
}
```

**Response: `response[0]`** — `IPhotoMedia { name: string; photoUri: string }`

**No field mask needed** — `callOptions` has no `X-Goog-FieldMask` header:

```typescript
const callOptions = { timeout: 4_000 };
```

**Name format**: the photo name returned by `getPlace`/`searchText` is
`places/{id}/photos/{ref}` — append `/media` to get the media resource:

```typescript
name: `${options.name}/media`;
```

---

## Places API — `searchNearby`

Method: `client.searchNearby(request, callOptions)`

**Request type: `ISearchNearbyRequest`**

```typescript
{
  locationRestriction: {   // REQUIRED — uses circle (not rectangle!)
    circle: {
      center: { latitude: number; longitude: number };
      radius: number;  // meters
    };
  };
  languageCode?: string;
  regionCode?: string;
  includedTypes?: string[];        // up to 50 from Table A
  excludedTypes?: string[];        // up to 50
  includedPrimaryTypes?: string[]; // up to 50
  excludedPrimaryTypes?: string[]; // up to 50
  maxResultCount?: number;         // 1–20, default 20
  rankPreference?: 0 | 1 | 2;     // 0=UNSPECIFIED, 1=DISTANCE, 2=POPULARITY
  routingParameters?: IRoutingParameters;
  includeFutureOpeningBusinesses?: boolean;
}
```

**Response: `response[0].places`** — array of `IPlace`

**Key differences from searchText:**

- No `textQuery` — location-only search
- `locationRestriction` uses a **circle** (searchText restriction uses
  rectangle)
- `locationBias` not available — restriction is always required

**Field mask** — same `places.*` prefix as searchText.

---

## Places API — `autocompletePlaces`

Method: `client.autocompletePlaces(request, callOptions)`

**Request type: `IAutocompletePlacesRequest`**

```typescript
{
  input: string;            // Required — the partial text typed by the user
  languageCode?: string;
  regionCode?: string;
  locationBias?: {          // oneof rectangle | circle
    rectangle?: IViewport;
    circle?: ICircle;
  };
  locationRestriction?: {   // oneof rectangle | circle (both supported unlike searchText!)
    rectangle?: IViewport;
    circle?: ICircle;
  };
  includedPrimaryTypes?: string[];  // up to 5 types (not 50!)
  includedRegionCodes?: string[];   // up to 15 CLDR 2-char codes
  origin?: { latitude: number; longitude: number };  // for distanceMeters in response
  inputOffset?: number;      // cursor position in input string
  includeQueryPredictions?: boolean;
  sessionToken?: string;     // IMPORTANT for billing — generate UUID per session
  includePureServiceAreaBusinesses?: boolean;
  includeFutureOpeningBusinesses?: boolean;
}
```

**Response: `response[0].suggestions`** — array of `ISuggestion`:

```typescript
// Each suggestion is oneof:
{
  placePrediction?: {
    place: string;          // "places/{place_id}" resource name
    placeId: string;        // raw place ID — use this for getPlace
    text: IFormattableText; // full text of the prediction
    structuredFormat: {
      mainText: IFormattableText;       // place name
      secondaryText: IFormattableText;  // address / disambiguator
    };
    types: string[];
    distanceMeters: number; // only if origin was set in request
  };
  queryPrediction?: {
    text: IFormattableText;
    structuredFormat: { mainText, secondaryText };
  };
}
```

**No field mask required** — per SDK docs (same as getPhotoMedia).

**Session token billing**: group all autocomplete calls + the subsequent
`getPlace` call under one UUID session token. New token for each new search
session.

---

## Routes API — `computeRoutes`

Method: `client.computeRoutes(request, callOptions)`

**Request type: `IComputeRoutesRequest`**

```typescript
{
  origin: IWaypoint;           // Required
  destination: IWaypoint;      // Required
  intermediates?: IWaypoint[]; // up to 25
  travelMode?: RouteTravelMode;
  routingPreference?: RoutingPreference;  // DRIVE/TWO_WHEELER only
  polylineQuality?: PolylineQuality;
  polylineEncoding?: PolylineEncoding;
  departureTime?: Timestamp;
  arrivalTime?: Timestamp;
  computeAlternativeRoutes?: boolean;
  routeModifiers?: IRouteModifiers;
  languageCode?: string;
  regionCode?: string;
  units?: Units;
  optimizeWaypointOrder?: boolean;
  requestedReferenceRoutes?: ReferenceRoute[];
  extraComputations?: ExtraComputation[];
  trafficModel?: TrafficModel;
  transitPreferences?: ITransitPreferences;
}
```

**Enum values (actual integer constants):**

```typescript
// RouteTravelMode
TRAVEL_MODE_UNSPECIFIED = 0;
DRIVE = 1; // currently the only supported mode in this app
BICYCLE = 2;
WALK = 3;
TWO_WHEELER = 4;
TRANSIT = 7;

// PolylineQuality
POLYLINE_QUALITY_UNSPECIFIED = 0;
HIGH_QUALITY = 1; // our highQuality=true
OVERVIEW = 2; // our highQuality=false (was "LOW" in old docs — actual value is OVERVIEW)

// PolylineEncoding
POLYLINE_ENCODING_UNSPECIFIED = 0;
ENCODED_POLYLINE = 1;
GEO_JSON_LINESTRING = 2;

// Units
UNITS_UNSPECIFIED = 0;
METRIC = 1;
IMPERIAL = 2;
```

**`IWaypoint`** — locationType is oneof:

```typescript
{
  // Choose ONE of these location types:
  location?: { latLng: { latitude: number; longitude: number } };
  placeId?: string;       // raw place ID (no "places/" prefix)
  address?: string;       // text address (geocoded by Google)
  navigationPointToken?: string;

  // Optional modifiers:
  via?: boolean;          // pass-through waypoint (no stop, no turn-by-turn)
  vehicleStopover?: boolean;
  sideOfRoad?: boolean;
}
```

**Response**: `response[0]` is `IComputeRoutesResponse`. The routes array is at
`response[0].routes` — validated with
`schemaParserEither(ComputeRoutesResponseSchema, ...)`.

**Field mask** (required — via `X-Goog-FieldMask` header):

```typescript
const fieldMasks = [
  "routes.description",
  "routes.distanceMeters",
  "routes.polylineDetails",
  "routes.routeLabels",
  "routes.staticDuration",
  "routes.warnings",
  "routes.viewport",
  "routes.legs.distanceMeters",
  "routes.legs.endLocation",
  "routes.legs.startLocation",
  "routes.legs.staticDuration",
  "routes.legs.steps.distanceMeters",
  "routes.legs.steps.endLocation",
  "routes.legs.steps.navigationInstruction",
  "routes.legs.steps.polyline",
  "routes.legs.steps.startLocation",
  "routes.legs.steps.staticDuration",
  "routes.legs.steps.travelMode",
];
```

---

## Routes API — `computeRouteMatrix`

Returns a stream (not a promise) of `RouteMatrixElement` for multiple
origin/destination combinations.

```typescript
const stream = client.computeRouteMatrix(request, callOptions);
// request.origins: RouteMatrixOrigin[]
// request.destinations: RouteMatrixDestination[]
// Limits: sum(origins + destinations) ≤ 50; product ≤ 625 (100 with TRAFFIC_AWARE_OPTIMAL)
```

Not currently implemented in this codebase. Use for future distance-matrix
features.

---

## `IPlace` Response Fields

Key fields returned by `searchText`/`searchNearby`/`getPlace`:

```typescript
{
  name: string;              // resource name: "places/{id}"
  id: string;                // raw place ID
  displayName: { text: string; languageCode: string };  // ILocalizedText
  types: string[];           // Google place types list
  primaryType: string;       // single primary type
  formattedAddress: string;
  shortFormattedAddress: string;
  location: { latitude: number; longitude: number };  // google.type.ILatLng
  viewport: IViewport;
  rating: number;            // 1.0–5.0
  googleMapsUri: string;
  websiteUri: string;
  photos: IPhoto[];          // each has `.name` for photo resource
  businessStatus: BusinessStatus;  // "OPERATIONAL" | "CLOSED_PERMANENTLY" | etc.
  priceLevel: PriceLevel;
  utcOffsetMinutes: number;
  regularOpeningHours: IOpeningHours;
  fuelOptions: IFuelOptions;        // for gas stations
  evChargeOptions: IEVChargeOptions; // for EV charging stations
  // Amenity booleans: takeout, delivery, dineIn, reservable, servesBreakfast,
  //   servesLunch, servesDinner, servesBeer, servesWine, outdoorSeating,
  //   liveMusic, goodForChildren, allowsDogs, goodForGroups, restroom, ...
}
```

---

## Transform Pattern

All SDK responses are `any`. Extract and normalize in a private
`transformResponse`:

```typescript
function transformResponse(response: any): Effect.Effect<Place[], MyError> {
  return Effect.gen(function* () {
    const places = response[0].places;  // searchText / searchNearby
    // const place = response[0];        // getPlace (single object)
    if (!places) throw new Error("Invalid data");
    return places.map((p: any) => ({
      id: nullSafe(p.id, null),
      name: nullSafe(p.name, null),
      displayName: nullSafe(p.displayName?.text, null),
      location: p.location?.latitude
        ? { lat: p.location.latitude, lng: p.location.longitude }
        : null,
      type: getBreakpointType(p.types ?? []),
      photosName: nullSafe(
        p.photos?.map((ph: any) => nullSafe(ph.name, null)),
        [] as string[],
      ),
      // ...
    }));
  }).pipe(
    Effect.catchAll(error => Effect.fail(new MyError({ code: "PLACES_TRANSFORM_FAILED", ... }))),
    withSpan("transformResponse", "...", {}),
  );
}
```

Always use `nullSafe(value, fallback)` — never `??` — for branch coverage.

---

## Place Type Categorization

`getBreakpointType(placeTypes: string[]): BreakpointType`:

| Google type              | App type        |
| ------------------------ | --------------- |
| `"restaurant"`, `"cafe"` | `"restaurant"`  |
| `"gas_station"`          | `"fuelStation"` |
| anything else            | `"other"`       |

Note: `primaryType` (single string) is more reliable than `types[]` for
categorization. Future enhancement: use `primaryType` instead of checking
`types[]`.

---

## Error Codes

| Operation                          | Code                              |
| ---------------------------------- | --------------------------------- |
| `searchText` call fails            | `PLACES_SEARCH_FAILED`            |
| `searchText` transform fails       | `PLACES_TRANSFORM_FAILED`         |
| `getPlace` call or transform fails | `PLACES_SEARCH_FAILED`            |
| `getPlace` transform fails         | `PLACE_TRANSFORM_FAILED`          |
| `getPhotoMedia` call fails         | `PLACES_PHOTO_FAILED`             |
| `getPhotoMedia` transform fails    | `PLACES_TRANSFORM_FAILED`         |
| `computeRoutes` call fails         | `ROUTES_COMPUTE_FAILED`           |
| `computeRoutes` empty response     | `ROUTES_COMPUTE_NO_RESPONSE`      |
| `computeRoutes` schema invalid     | `ROUTES_COMPUTE_RESPONSE_INVALID` |

---

## OTel Spans

```typescript
withSpan("functionName", "@95octane/common/maps/places/search", {
  "app.text": options.text,
  "app.regionCode": options.regionCode,
  "app.languageCode": options.languageCode,
  "app.locationBias": !!(options.currentLocation && options.radius), // boolean
});
```

---

## Important SDK Quirks

- `searchText.locationRestriction` supports **rectangle only** — no circle
- `searchNearby.locationRestriction` uses **circle** (required, not optional)
- `autocompletePlaces.locationRestriction` supports both circle and rectangle
- `getPhotoMedia` max size is **4800px** per side (our app default is 1024px)
- `getPhotoMedia` requires at least one of `maxWidthPx` / `maxHeightPx`
- `autocompletePlaces` does **not** need a field mask (unlike
  searchText/getPlace)
- `computeRouteMatrix` returns a **stream**, not a Promise
- `PolylineQuality` value `2` is named `OVERVIEW`, not `LOW` (common confusion)
- Waypoints support `address: string` (text geocoding) in addition to
  latLng/placeId

---

## File Locations

```
packages/common/src/maps/
  places/
    search.ts    — searchText (text + optional location bias)
    get.ts       — getPlace (details by resource name)
    photos.ts    — getPhotoMedia
    utils.ts     — getBreakpointType
    index.ts     — re-exports
  routing/
    route.ts     — computeRoutes
    index.ts     — re-exports

packages/common/src/schemas/
  place/place.schema.ts    — PlaceSchema, PlacesSearchBodySchema, etc.
  route/route.schema.ts    — RouteSchema, WaypointSchema, etc.
```

Service imports only from package exports:

```typescript
import {
  searchPlace,
  getPlaceByName,
  getPhotoMedia,
} from "@95octane/common/maps/places";
import { computeRoutes } from "@95octane/common/maps/routing";
```
