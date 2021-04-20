
import 'dart:convert';

ShowExperimentModel showExperimentModelFromJson(String str) => ShowExperimentModel.fromJson(json.decode(str));

String showExperimentModelToJson(ShowExperimentModel data) => json.encode(data.toJson());

class ShowExperimentModel {
    ShowExperimentModel({
        this.status,
        this.data,
    });

    String status;
    Experiment data;

    factory ShowExperimentModel.fromJson(Map<String, dynamic> json) => ShowExperimentModel(
        status: json["status"],
        data: Experiment.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Experiment {
    Experiment({
        this.id,
        this.title,
        this.content,
        this.lessonId,
    });

    String id;
    String title;
    String content;
    String lessonId;

    factory Experiment.fromJson(Map<String, dynamic> json) => Experiment(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        lessonId: json["lesson_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "lesson_id": lessonId,
    };
}
