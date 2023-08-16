import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  String propertyId;
  String propertyName;
  List<AvailableSpace> availableSpaces;

  PropertyModel({
    required this.propertyId,
    required this.propertyName,
    required this.availableSpaces,
  });

  static PropertyModel get defaultProperty => PropertyModel(
        propertyId: '',
        propertyName: '',
        availableSpaces: [],
      );

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        propertyId: json["propertyId"],
        propertyName: json["propertyName"],
        availableSpaces: List<AvailableSpace>.from(
            json["availableSpaces"].map((x) => AvailableSpace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "propertyName": propertyName,
        "availableSpaces":
            List<dynamic>.from(availableSpaces.map((x) => x.toJson())),
      };
}

class AvailableSpace {
  String spaceId;
  String propertyName;
  String spaceTitle;
  String spaceDescription;
  double spaceRating;
  int spacePrice;
  List<String> spaceImages;
  int currentIndex = 0;

  AvailableSpace({
    required this.spaceId,
    required this.propertyName,
    required this.spaceTitle,
    required this.spaceDescription,
    required this.spaceRating,
    required this.spacePrice,
    required this.spaceImages,
  });

  factory AvailableSpace.fromJson(Map<String, dynamic> json) => AvailableSpace(
        spaceId: json["spaceId"],
        propertyName: json["propertyName"],
        spaceTitle: json["spaceTitle"],
        spaceDescription: json["spaceDescription"],
        spaceRating: json["spaceRating"],
        spacePrice: json["spacePrice"],
        spaceImages: List<String>.from(json["spaceImages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "spaceId": spaceId,
        "propertyName": propertyName,
        "spaceTitle": spaceTitle,
        "spaceDescription": spaceDescription,
        "spaceRating": spaceRating,
        "spacePrice": spacePrice,
        "spaceImages": List<dynamic>.from(spaceImages.map((x) => x)),
      };
}
