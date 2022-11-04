// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAnswers _$PostAnswersFromJson(Map<String, dynamic> json) => PostAnswers(
      question_id: json['question_id'] as int?,
      answer_ids:
          (json['answer_ids'] as List<dynamic>).map((e) => e as int?).toList(),
    );

Map<String, dynamic> _$PostAnswersToJson(PostAnswers instance) =>
    <String, dynamic>{
      'question_id': instance.question_id,
      'answer_ids': instance.answer_ids,
    };
