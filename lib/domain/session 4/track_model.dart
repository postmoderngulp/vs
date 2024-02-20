import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vs1/entity/my_package.dart';
import 'package:vs1/entity/origin_locate.dart';
import 'package:vs1/entity/stage.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class TrackModel extends ChangeNotifier {
  final mapController = Completer<YandexMapController>();
  bool isTrack = false;
  String uuid = '';
  List<PlacemarkMapObject> placemarks = [];
  Stream<List<Stage>>? stream;
  MyPackage? packageInfo;

  TrackModel() {
    _setup();
  }

  void _setup() {
    getPackage();
  }

  void getPackage() async {
    SupaBaseService service = SupaBaseService();
    try {
      packageInfo = await service.getPackage();
      stream = getStream();
      notifyListeners();
      if (packageInfo == null) {
        return;
      }
      uuid = packageInfo!.uuid;
      isTrack = true;
      _setupMap();
    } catch (e) {
      _setupCash();
    }
  }

  Stream<List<Stage>> getStream() {
    SupaBaseService service = SupaBaseService();
    return service.getLastPackage();
  }

  void _setupCash() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final listLocations = sharedPreferences.getStringList('locations');
    List<OriginLocate> listOriginLocate = [];
    if (listLocations != null) {
      for (int i = 0; i < listLocations.length; i++) {
        listOriginLocate.add(OriginLocate.fromJson(listLocations[i]));
      }
      for (int i = 0; i < listOriginLocate.length; i++) {
        placemarks.add(
          PlacemarkMapObject(
              opacity: 1.0,
              zIndex: 1,
              isDraggable: true,
              mapId: MapObjectId("${listOriginLocate[i].lat}}"),
              point: Point(
                latitude: listOriginLocate[i].lat,
                longitude: listOriginLocate[i].long,
              ),
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/image/placemark.png")))),
        );
      }
      isTrack = true;
    }
    notifyListeners();
  }

  void _setupMap() async {
    List<OriginLocate> listOriginLocate = [];
    List<String> stringsCoordinate = [];
    listOriginLocate.add(packageInfo!.coordinat.location);
    for (int i = 0; i < packageInfo!.coordinat.locations.length; i++) {
      listOriginLocate.add(packageInfo!.coordinat.locations[i]);
    }
    for (int i = 0; i < listOriginLocate.length; i++) {
      stringsCoordinate.add(listOriginLocate[i].toJson());
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('locations', stringsCoordinate);
    placemarks.add(
      PlacemarkMapObject(
          opacity: 1.0,
          zIndex: 1,
          isDraggable: true,
          mapId: MapObjectId("${packageInfo!.coordinat.location.lat}"),
          point: Point(
            latitude: packageInfo!.coordinat.location.lat,
            longitude: packageInfo!.coordinat.location.long,
          ),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                  "assets/image/placemark.png")))),
    );
    for (int i = 0; i < packageInfo!.destination_details.length; i++) {
      placemarks.add(
        PlacemarkMapObject(
            opacity: 1.0,
            zIndex: 1,
            isDraggable: true,
            mapId: MapObjectId("${packageInfo!.coordinat.locations[i].lat}"),
            point: Point(
              latitude: packageInfo!.coordinat.locations[i].lat,
              longitude: packageInfo!.coordinat.locations[i].long,
            ),
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    "assets/image/placemark.png")))),
      );
    }

    notifyListeners();
  }

  void goToCheckInfo(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.checkInfo);
  }
}
