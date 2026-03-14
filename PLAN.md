# Audit & Improvement Plan

## PR 1 — Modernizacja CI
**Branch:** `ci/modernize-workflows`
**Commit:** `ci: modernize GitHub Actions workflows`

- `ContinuousIntegration.yml`: `checkout@v2` → `checkout@v4`, `macos-latest` → `macos-15`, dodać `swift test`
- `swiftlint.yml`: `checkout@v1` → `v4`, zaktualizować `norio-nomura/action-swiftlint`

---

## PR 2 — Naprawa SwiftLint
**Branch:** `fix/swiftlint-config`
**Commit:** `fix: repair SwiftLint configuration`

- Usunąć `Sources` z `excluded` (cały kod źródłowy jest wyciszony)
- Usunąć zduplikowany klucz `excluded:`
- Podnieść lub usunąć `line_length: 140`

---

## PR 3 — Aktualizacja wersji Swift
**Branch:** `chore/update-swift-version`
**Commit:** `chore: align Swift version across configuration files`

- `.swift-version`: `5.5` → `6.1`
- `Package.swift`: `swift-tools-version: 5.10.0` → `6.1`

---

## PR 4 — Migracja Preview API
**Branch:** `refactor/preview-macro`
**Commit:** `refactor: migrate previews from PreviewProvider to #Preview macro`

- `SlidableImage.swift`, `Arrows.swift`, `Triangle.swift`: zamienić przestarzałe `PreviewProvider` na `#Preview {}`

---

## PR 5 — Zastąpienie Jazzy przez DocC
**Branch:** `ci/replace-jazzy-with-docc`
**Commit:** `ci: replace Jazzy documentation with DocC`

- Usunąć `PublishDocumentation.yml`
- Dodać `docs.yml` (DocC + GitHub Pages via Actions)
- Zmienić Pages source na `workflow`

---

## PR 6 — Testy
**Branch:** `test/add-unit-tests`
**Commit:** `test: add test target and unit tests`

- Dodać `testTarget` do `Package.swift`
- Pokryć testami: obliczenia maski, boundary conditions, inicjalizacje

---

## PR 7 — README
**Branch:** `docs/improve-readme`
**Commit:** `docs: rewrite README with accurate content and examples`

- Naprawić literówkę `Instalation` → `Installation`
- Zaktualizować badge CI
- Dodać badge Swift Package Index
- Rozszerzyć przykłady użycia
- Dodać link do dokumentacji (po PR 5)

---

## Kolejność realizacji

```
PR 1, PR 2, PR 3  ← równolegle
        ↓
    PR 4, PR 6
        ↓
       PR 5
        ↓
       PR 7
```
