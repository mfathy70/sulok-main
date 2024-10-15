class AddProgramRequest {
  String? name;
  String? info;

  AddProgramRequest({this.info, this.name});

  factory AddProgramRequest.fromJson(Map<String, dynamic> json) =>
      AddProgramRequest(
        name: json["name"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "name": name,
      };
}

class UpdateProgramRequest {
  String? name;
  String? info;
  String? id;

  UpdateProgramRequest({this.info, this.name, this.id});

  factory UpdateProgramRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProgramRequest(
        name: json["name"],
        id: json["id"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "id": id,
        "name": name,
      };
}
