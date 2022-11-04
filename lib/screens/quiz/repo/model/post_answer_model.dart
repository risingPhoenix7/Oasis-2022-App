import 'package:json_annotation/json_annotation.dart';

part 'post_answer_model.g.dart';

@JsonSerializable()
class PostAnswers {
  int? question_id;
  List<int?> answer_ids;

  PostAnswers({
    required this.question_id,
    required this.answer_ids,
  });

  factory PostAnswers.fromJson(Map<String, dynamic> json) =>
      _$PostAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$PostAnswersToJson(this);
}
