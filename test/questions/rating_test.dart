import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_survey_js/survey.dart';
import 'package:flutter_survey_js/survey.dart' as s;
import 'package:flutter_test/flutter_test.dart';

import '../test_data.dart';

void main() {
  // 单一的测试
  const json = {
    "questions": [
      {
        "type": "rating",
        "name": "satisfaction",
        "title": "How satisfied are you with the Product?",
        "mininumRateDescription": "Not Satisfied",
        "maximumRateDescription": "Completely satisfied"
      }
    ]
  };
  test("Serialize Deserialize Survey", () {
    final s = Survey.fromJson(json);
  });

  group('ratingBuilder', () {
    testWidgets(
      'reflects non-null default values',
      (widgetTester) async {
        final int defaultValue = 3;
        final String elementName = 'some rating';
        await widgetTester.pumpWidget(
          MaterialApp(
            localizationsDelegates: [
              s.MultiAppLocalizationsDelegate(),
            ],
            home: Material(
              child: SurveyWidget(
                survey: TestData.survey(questions: [
                  Rating()
                    ..defaultValue = defaultValue
                    ..name = elementName
                ]),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();
        final s.SurveyProvider surveyProvider = widgetTester
            .widget(find.byType(SurveyProvider)) as s.SurveyProvider;
        expect(surveyProvider.formGroup.value, {elementName: defaultValue});
      },
    );

    testWidgets(
      'reflects null default values',
      (widgetTester) async {
        final String elementName = 'some rating';
        await widgetTester.pumpWidget(
          MaterialApp(
            localizationsDelegates: [
              s.MultiAppLocalizationsDelegate(),
            ],
            home: Material(
              child: SurveyWidget(
                survey:
                    TestData.survey(questions: [Rating()..name = elementName]),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();
        final s.SurveyProvider surveyProvider = widgetTester
            .widget(find.byType(SurveyProvider)) as s.SurveyProvider;
        expect(surveyProvider.formGroup.value, {elementName: null});
      },
    );
  });
}
