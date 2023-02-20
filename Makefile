.ONESHELL:
.DEFAULT_GOAL = help
.EXPORT_ALL_VARIABLES:

WEB_BASE_REF = /


help:
	@ # Print help commands
	echo "Welcome to 'HoneStorage' project!"
.PHONY: help

dependencies:
	@ # Install Flutter dependencies
	flutter pub get
.PHONY: dependencies

generate_code:
	@ # Generate dart code: JSON converter
	flutter pub run build_runner build
.PHONY: generate_code


run-web: dependencies generate_code
	@ # Run in web
	flutter build web --base-href $(WEB_BASE_REF) --dart-define BUILD_SECRET=$(echo $$RANDOM | md5sum | head -c 12)
.PHONY: run-web


lint: dependencies generate_code
	@ # TODO: add linting target
.PHONY: lint

test: dependencies generate_code
	@ # TODO: add testing target
.PHONY: test

clean:
	@ # Clean all build files, including: libraries, package manager configs, docker images and containers
	rm -rf .dart_tool
	rm -rf build
	rm -f .flutter-plugins
	rm -f .flutter-plugins-dependencies
	rm -f honestorage.iml
	rm -f pubspec.lock
.PHONY: clean
