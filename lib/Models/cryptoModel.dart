// @dart=2.9
// To parse this JSON data, do
//
//     final cryptoModel = cryptoModelFromJson(jsonString);

import 'dart:convert';

CryptoModel cryptoModelFromJson(String str) =>
    CryptoModel.fromJson(json.decode(str));

String cryptoModelToJson(CryptoModel data) => json.encode(data.toJson());

class CryptoModel {
  CryptoModel({
    this.status,
    this.data,
  });

  Status status;
  List<Datum> data;

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status.toJson(),
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.rank,
    this.isActive,
    this.firstHistoricalData,
    this.lastHistoricalData,
    this.platform,
  });

  int id;
  String name;
  String symbol;
  String slug;
  int rank;
  int isActive;
  DateTime firstHistoricalData;
  DateTime lastHistoricalData;
  dynamic platform;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        slug: json["slug"] == null ? null : json["slug"],
        rank: json["rank"] == null ? null : json["rank"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        firstHistoricalData: json["first_historical_data"] == null
            ? null
            : DateTime.parse(json["first_historical_data"]),
        lastHistoricalData: json["last_historical_data"] == null
            ? null
            : DateTime.parse(json["last_historical_data"]),
        platform: json["platform"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "symbol": symbol == null ? null : symbol,
        "slug": slug == null ? null : slug,
        "rank": rank == null ? null : rank,
        "is_active": isActive == null ? null : isActive,
        "first_historical_data": firstHistoricalData == null
            ? null
            : firstHistoricalData.toIso8601String(),
        "last_historical_data": lastHistoricalData == null
            ? null
            : lastHistoricalData.toIso8601String(),
        "platform": platform,
      };
}

class Status {
  Status({
    this.timestamp,
    this.errorCode,
    this.errorMessage,
    this.elapsed,
    this.creditCount,
    this.notice,
  });

  DateTime timestamp;
  int errorCode;
  dynamic errorMessage;
  int elapsed;
  int creditCount;
  dynamic notice;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage: json["error_message"],
        elapsed: json["elapsed"] == null ? null : json["elapsed"],
        creditCount: json["credit_count"] == null ? null : json["credit_count"],
        notice: json["notice"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
        "error_code": errorCode == null ? null : errorCode,
        "error_message": errorMessage,
        "elapsed": elapsed == null ? null : elapsed,
        "credit_count": creditCount == null ? null : creditCount,
        "notice": notice,
      };
}
