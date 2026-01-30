build_dev:
	flutter clean
	flutter pub get
	flutter pub run build_runner build -d
	flutter build apk --flavor dev -t lib/main.dart

build_prod:
	flutter clean
	flutter pub get
	flutter pub run build_runner build -d
	flutter build apk --flavor prod -t lib/main.dart