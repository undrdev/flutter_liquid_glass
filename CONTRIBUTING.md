# Contributing to Flutter Liquid Glass

Thank you for your interest in contributing to Flutter Liquid Glass! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome new contributors
- Focus on constructive feedback
- Celebrate contributions of all types

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/undrdev/flutter_liquid_glass/issues)
2. If not, create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Environment details (OS, Flutter version, etc.)
   - Screenshots if applicable

### Suggesting Features

1. Check if the feature has already been suggested
2. Create a new issue with:
   - Clear description of the feature
   - Use cases and motivation
   - Potential implementation approach
   - Examples if applicable

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass: `flutter test`
6. Run analysis: `flutter analyze`
7. Format code: `dart format .`
8. Commit changes: `git commit -m "Add amazing feature"`
9. Push to your fork: `git push origin feature/amazing-feature`
10. Create a Pull Request

### Development Setup

1. Clone the repository:
```bash
git clone https://github.com/undrdev/flutter_liquid_glass.git
cd flutter_liquid_glass
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the example app:
```bash
cd example
flutter run
```

4. Run tests:
```bash
flutter test
```

5. Run analysis:
```bash
flutter analyze
```

### Coding Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use meaningful variable and function names
- Add comments for complex logic
- Write comprehensive tests
- Update documentation as needed
- Keep functions focused and small
- Use `late` sparingly and with good reason

### Testing Requirements

- All new features must include tests
- Maintain or improve test coverage
- Write both widget and unit tests as appropriate
- Include edge cases in tests
- Tests should be fast and independent

### Documentation

- Update README.md for significant changes
- Add JSDoc-style comments for public APIs
- Update CHANGELOG.md with your changes
- Keep code examples up to date
- Document breaking changes clearly

### Release Process

We follow semantic versioning:
- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (0.2.0): New features, backward compatible
- **PATCH** (0.1.1): Bug fixes, backward compatible

### Questions?

Feel free to open an issue or discussion for any questions about contributing.

Thank you for contributing to Flutter Liquid Glass! 🎉

