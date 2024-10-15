class AddLevelRequest {
  String? name;
  String? info;
  String? programID;

  AddLevelRequest({this.info, this.name, this.programID});

  factory AddLevelRequest.fromJson(Map<String, dynamic> json) =>
      AddLevelRequest(
        name: json["name"],
        programID: json["program_id"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "program_id": programID,
        "name": name,
      };
}
class UpdateLevelRequest {
  String? name;
  String? info;
  String? id;
  String? programID;

  UpdateLevelRequest({this.info, this.name, this.programID,this.id});

  factory UpdateLevelRequest.fromJson(Map<String, dynamic> json) =>
      UpdateLevelRequest(
        name: json["name"],
        programID: json["program_id"],
        info: json["info"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "program_id": programID,
        "name": name,
        "id": id,
      };
}
