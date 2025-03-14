build_development:
	flutter build ipa --flavor development -t lib/main_development.dart 

build_production:
	flutter build ipa --flavor production -t lib/main_production.dart 

build_staging:
	flutter build ipa --flavor staging -t lib/main_staging.dart 

build_prod_android:
	flutter build appbundle --flavor production -t lib/main_production.dart

build_stag_android:
	flutter build appbundle --flavor staging -t lib/main_staging.dart

build_stag_apk:
	flutter build apk --split-per-abi --flavor staging -t lib/main_staging.dart

auto_generate:
	dart run build_runner build --delete-conflicting-outputs

pub_get:
	fvm flutter pub get

flutter_gen:
	flutter gen-l10n --arb-dir="lib/l10n/arb"

