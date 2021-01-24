import 'dart:convert';

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));

String countriesToJson(Countries data) => json.encode(data.toJson());

class Countries {
  Countries({
    this.status,
    this.statusCode,
    this.version,
    this.total,
    this.limit,
    this.offset,
    this.access,
    this.data,
  });

  String status;
  int statusCode;
  String version;
  int total;
  int limit;
  int offset;
  String access;
  Map<String, Datum> data;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        status: json["status"],
        statusCode: json["status-code"],
        version: json["version"],
        total: json["total"],
        limit: json["limit"],
        offset: json["offset"],
        access: json["access"],
        data: Map.from(json["data"])
            .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status-code": statusCode,
        "version": version,
        "total": total,
        "limit": limit,
        "offset": offset,
        "access": access,
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Datum {
  Datum({
    this.country,
    this.region,
  });

  String country;
  String region;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        country: json["country"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "region": region,
      };
}
