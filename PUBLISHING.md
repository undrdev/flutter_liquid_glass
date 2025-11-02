# Publishing Guide

This guide will help you publish the Flutter Liquid Glass package to pub.dev.

## Prerequisites

- A [pub.dev](https://pub.dev) account
- A GitHub repository for the package (update URLs in `pubspec.yaml`)
- Flutter SDK installed and up to date

## Pre-Publishing Checklist

### 1. Update Repository URLs

Edit `pubspec.yaml` and replace placeholder URLs:
```yaml
homepage: https://github.com/YOUR_USERNAME/flutter_liquid_glass
repository: https://github.com/YOUR_USERNAME/flutter_liquid_glass
issue_tracker: https://github.com/YOUR_USERNAME/flutter_liquid_glass/issues
```

### 2. Verify Package Content

Ensure all required files are present:
- ✅ `pubspec.yaml` - Package configuration
- ✅ `README.md` - Package documentation
- ✅ `LICENSE` - MIT License (or your preferred license)
- ✅ `CHANGELOG.md` - Version history
- ✅ `lib/` - Source code
- ✅ `test/` - Tests
- ✅ `example/` - Demo application

### 3. Run Tests

```bash
flutter test
```

All tests should pass before publishing.

### 4. Run Analysis

```bash
flutter analyze
```

Fix any analysis issues before publishing.

### 5. Format Code

```bash
dart format .
```

### 6. Generate Documentation

```bash
dart doc
```

This generates API documentation in `doc/api/` (optional).

### 7. Test Example App

```bash
cd example
flutter run
```

Ensure the example app works correctly on your target platform.

### 8. Review Documentation

Check that:
- README is comprehensive and accurate
- All code examples work
- CHANGELOG is up to date
- License file is correct

## Publishing Process

### 1. Publish Dry-Run

First, test the publication process without actually publishing:

```bash
flutter pub publish --dry-run
```

Review the output carefully for any warnings or errors.

### 2. Publish Package

When ready to publish:

```bash
flutter pub publish
```

You'll be prompted to:
1. Confirm publication
2. Enter your pub.dev credentials (if not already logged in)
3. Review package details

### 3. Verify Publication

After publishing, verify on pub.dev:
- Package appears on https://pub.dev/packages/flutter_liquid_glass
- Documentation renders correctly
- Example app is accessible
- Installation instructions work

## Post-Publishing

### 1. Create Release Tags

```bash
git tag v0.1.0
git push origin v0.1.0
```

### 2. Update GitHub Repository

- Add repository description
- Link to pub.dev package
- Create a release on GitHub
- Add screenshots/GIFs to README

### 3. Monitor

- Watch for issues on pub.dev and GitHub
- Respond to questions and feedback
- Plan future releases

## Version Management

Follow semantic versioning:
- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (0.2.0): New features, backward compatible
- **PATCH** (0.1.1): Bug fixes, backward compatible

Update version in `pubspec.yaml`:
```yaml
version: 0.1.0  # Update as needed
```

## Continuous Publishing

For future releases:

1. Make changes
2. Update `CHANGELOG.md`
3. Update version in `pubspec.yaml`
4. Run tests: `flutter test`
5. Run analysis: `flutter analyze`
6. Dry-run: `flutter pub publish --dry-run`
7. Publish: `flutter pub publish`
8. Tag release: `git tag v0.2.0 && git push origin v0.2.0`

## Additional Resources

- [pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [Semantic Versioning](https://semver.org/)
- [Flutter Package Guidelines](https://dart.dev/guides/libraries/create-library-packages)

## Troubleshooting

### Common Issues

**Issue**: "Package version is already published"
- **Solution**: Increment version in `pubspec.yaml`

**Issue**: "Package name conflicts"
- **Solution**: Choose a different package name in `pubspec.yaml`

**Issue**: "LICENSE file is missing"
- **Solution**: Create a LICENSE file in package root

**Issue**: "pubspec.yaml contains invalid fields"
- **Solution**: Run `flutter pub publish --dry-run` to see specific errors

## Notes

- Once published, you cannot unpublish packages
- Be thorough in testing before publishing
- Keep documentation updated
- Maintain backward compatibility when possible

