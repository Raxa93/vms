

// ignore_for_file: avoid_print

class BreweryModel {
  String? id;
  String? name;
  String? breweryType;
  String? street;
  String? address2;
  String? address3;
  String? city;
  String? state;
  String? countyProvince;
  String? postalCode;
  String? country;
  String? longitude;
  String? latitude;
  String? phone;
  String? websiteUrl;
  String? updatedAt;
  String? createdAt;

  BreweryModel(
      {this.id,
        this.name,
        this.breweryType,
        this.street,
        this.address2,
        this.address3,
        this.city,
        this.state,
        this.countyProvince,
        this.postalCode,
        this.country,
        this.longitude,
        this.latitude,
        this.phone,
        this.websiteUrl,
        this.updatedAt,
        this.createdAt});

  BreweryModel.fromJson(Map<String, dynamic> json) {
    print('Ahmad, i Got data ${json['name']}');
    id = json['id'];
    name = json['name'];
    breweryType = json['brewery_type'];
    street = json['street'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    city = json['city'];
    state = json['state'];
    countyProvince = json['county_province'];
    postalCode = json['postal_code'];
    country = json['country'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phone = json['phone'];
    websiteUrl = json['website_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }


}