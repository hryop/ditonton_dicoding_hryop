cgg:
	@echo "==MOVIE MODULE=="
	@echo ""
	@echo "==CLEAN THE REPOSITORY=="
	flutter clean

	@echo ""
	@echo "==GETTING THE DEPENDENCIES=="
	flutter pub get

	@echo ""
	@echo "==BUILD AND DELETE CONFLICTING OUTPUTS=="
	flutter pub run build_runner build --delete-conflicting-outputs

fvm-cgg:
	@echo "==CLEAN THE REPOSITORY=="
	fvm flutter clean

	@echo ""
	@echo "==GETTING THE DEPENDENCIES=="
	fvm flutter pub get

	@echo ""
	@echo "==BUILD AND DELETE CONFLICTING OUTPUTS=="
	fvm flutter pub run build_runner build --delete-conflicting-outputs

fvm-cgga:
	@echo "==CLEAN THE REPOSITORY=="
	fvm flutter clean

	@echo ""
	@echo "==GETTING THE DEPENDENCIES=="
	fvm flutter pub get

	@echo ""
	@echo "==BUILD AND DELETE CONFLICTING OUTPUTS=="
	fvm flutter pub run build_runner build --delete-conflicting-outputs

	@echo ""
	@echo "==ANALYZE MODULE=="
	fvm flutter analyze

fvm-lcov:
	@echo "==GENERATE LCOV INFO=="
	fvm flutter test --coverage

gen-lcov:
	@echo "==GENERATE CODE COVERAGE REPORT=="
	perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage\html coverage\lcov.info

	@echo ""
	@echo "==OPEN CODE COVERAGE REPORT=="
	start coverage\html\index.html