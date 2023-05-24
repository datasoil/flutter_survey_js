part of 'survey.dart';

@JsonSerializable(includeIfNull: false)
class Page extends PanelBase {
  static const $type = "page";

  String? get type => $type;
  //   "inherit",
  // "show",
  // "hide"
  String? navigationButtonsVisibility;
  //   "default",
  // "initial",
  // "random"
  String? questionsOrder;
  int? maxTimeToFinish;
  String? navigationTitle;
  String? navigationDescription;
  Page();
  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  List<Object?> get props => [
        navigationButtonsVisibility,
        questionsOrder,
        maxTimeToFinish,
        navigationTitle,
        navigationDescription,
      ];
}

abstract class PanelBase extends ElementBase {
  String? name;
  List<ElementBase>? elements;
  bool? visible;
  String? visibleIf;
  String? enableIf;
  String? requiredIf;
  bool? readOnly;
  //"default",    "top",   "bottom",         "left", "hidden"
  String? questionTitleLocation;
  //
  String? title;
  String? description;

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        elements,
        visible,
        visibleIf,
        enableIf,
        requiredIf,
        readOnly,
        questionTitleLocation,
        title,
        description,
      ];
}
