# Changelog

All notable changes to this chart are documented in this file.

## 1.5.1 - 2026-06-10

### Changed

- Updated chart and app version to `1.5.1`.
- Refreshed existing Gateway API CRD manifests to the latest upstream definitions.

### Added

- Added `ListenerSet` CRD manifest (`gateway.networking.k8s.io_listenersets.yaml`).
- Added `TLSRoute` CRD manifest (`gateway.networking.k8s.io_tlsroutes.yaml`).
- Added safe-upgrade VAP CRD manifest (`gateway.networking.k8s.io_vap_safeupgrades.yaml`).

## 1.4.1 - 2026-06-10

### Added

- Initial `gateway-api-crds` Helm chart release.
- Packaged core Gateway API CRDs for cluster installation via Helm.

