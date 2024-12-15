# TODO

A small cheatsheet to remember what to do when a new feature is added.

## Security fixes

See the Security section of the [Contributing guidelines](CONTRIBUTING.md).

## New features

1. Add a new page or a new section inside the "_docs"
2. Add a test to validate it works
3. Add an entry under the "Unreleased" section of the "CHANGELOG.md"

## Modification/fixes

1. If tests have been modified and this is a breaking change see [breaking changes](#breaking-changes)
2. Else
  1. Update the documentation inside "_docs"
  2. Update the tests
  3. Add an entry under the "Unreleased" section of the "CHANGELOG.md file

## Breaking change

1. Add some tests for the breaking fix/feature
2. Document how to upgrade inside the file "_docs/upgrade.md"
3. Add an entry under the "Unreleased" section of the "CHANGELOG.md file
