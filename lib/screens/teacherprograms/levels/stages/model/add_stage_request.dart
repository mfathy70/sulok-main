class AddStageRequest {
  String? name;
  String? info;
  String? levelID;

  AddStageRequest({this.info, this.name, this.levelID});

  factory AddStageRequest.fromJson(Map<String, dynamic> json) =>
      AddStageRequest(
        name: json["name"],
        levelID: json["level_id"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "level_id": levelID,
        "name": name,
      };
}
class UpdateStageRequest {
  String? name;
  String? info;
  String? levelID;
  String? id;

  UpdateStageRequest({this.info, this.name, this.levelID,this.id});

  factory UpdateStageRequest.fromJson(Map<String, dynamic> json) =>
      UpdateStageRequest(
        name: json["name"],
        id: json["id"],
        levelID: json["level_id"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
    "info": info,
    "level_id": levelID,
    "name": name,
    "id": id,
  };
}
