import '../../../flutter_flow/flutter_flow_model.dart';
import 'categorie_widget.dart' show CategorieWidget;
import 'package:flutter/material.dart';

class CategorieModel extends FlutterFlowModel<CategorieWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
