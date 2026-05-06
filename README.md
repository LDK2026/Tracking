# Tracking

Android programele, kuri seka ir zemelapyje rodo telefono buvimo vieta. Projektas naudoja Google Maps zemelapi ir Google Play Services Location API nuolatiniams vietos atnaujinimams.

## Ka programa daro

- Praso vietos leidimo.
- Paleidzia foreground service vietos sekimui.
- Gauna naujas koordinates per `FusedLocationProviderClient`.
- Siuncia vietos atnaujinimus i aktyvia veikla per broadcast.
- Google Maps zemelapyje braizo marsruta kaip polyline.
- Priartina zemelapi prie paskutines gautos vietos.

## Projekto struktura

- `app/src/main/java/com/example/tracker/MapsActivity.kt` - pagrindinis ekranas su Google Maps zemelapiu.
- `app/src/main/java/com/example/tracker/LocationService.kt` - foreground service, kuris gauna vietos atnaujinimus.
- `app/src/main/res/layout/activity_maps.xml` - zemelapio layout failas.
- `app/src/main/AndroidManifest.xml` - leidimai, Google Maps API raktas ir service deklaracija.

## Reikalavimai

- Android Studio.
- Android SDK su compile SDK 34 arba naujesniu.
- Telefonas arba emuliatorius su Google Play Services.
- Google Maps API raktas.

## Google Maps API raktas

`app/src/main/AndroidManifest.xml` faile pakeiskite reiksme `TAVO_API_KEY` i savo Google Maps API rakta:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="TAVO_API_KEY" />
```

Rakta galima susikurti Google Cloud Console, ijungus `Maps SDK for Android`.

## Paleidimas

1. Atsisiuskite arba klonuokite repo.
2. Atidarykite projekta su Android Studio.
3. Iveskite Google Maps API rakta `AndroidManifest.xml` faile.
4. Palaukite, kol Gradle sinchronizuos priklausomybes.
5. Paleiskite programa telefone arba emuliatoriuje.
6. Suteikite vietos leidima, kai Android jo paprasys.

## Leidimai

Programa naudoja siuos leidimus:

- `ACCESS_FINE_LOCATION` - tiksli GPS vieta.
- `ACCESS_COARSE_LOCATION` - apytiksle vieta.
- `ACCESS_BACKGROUND_LOCATION` - vietos sekimui fone.

Naujesnese Android versijose fono vietos leidima naudotojas gali tureti suteikti papildomai per programos nustatymus.

## Pastabos

- Foreground service turi rodyti pranesima, kad Android leistu vietos sekima fone.
- Realus sekimo tikslumas priklauso nuo telefono, GPS signalo, baterijos taupymo rezimo ir Android leidimu.
- Jei zemelapis tuscias, pirmiausia patikrinkite Google Maps API rakta ir interneto rysi.
