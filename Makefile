fvm-cgg:
	@echo "==CLEAN THE REPOSITORY=="
	fvm flutter clean

	@echo ""
	@echo "==GETTING THE DEPENDENCIES=="
	fvm flutter pub get

	@echo ""
	@echo "==BUILD AND DELETE CONFLICTING OUTPUTS=="
	fvm flutter pub run build_runner build --delete-conflicting-outputs

fvm-run:
	@echo "==RUN APP=="
	fvm flutter run