// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_questions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questions _$QuestionsFromJson(Map<String, dynamic> json) => Questions(
      active_questions: (json['active_questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'active_questions': instance.active_questions,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      category: json['category'] as String?,
      question_id: json['question_id'] as int?,
      total_options: json['total_options'] as int?,
      image_link: json['image_link'] as String?,
      time_given: json['time_given'] as int?,
      question_no: json['question_no'] as int?,
      quiz_closed: json['quiz_closed'] as bool?,
      question_text: json['question_text'] as String?,
      option_ids:
          (json['option_ids'] as List<dynamic>).map((e) => e as int?).toList(),
      option_texts: (json['option_texts'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'question_no': instance.question_no,
      'question_id': instance.question_id,
      'total_options': instance.total_options,
      'time_given': instance.time_given,
      'option_ids': instance.option_ids,
      'option_texts': instance.option_texts,
      'quiz_closed': instance.quiz_closed,
      'category': instance.category,
      'question_text': instance.question_text,
      'image_link': instance.image_link,
    };
