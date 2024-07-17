import '../../../backend/backend.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import 'acceuil_widget.dart' show AcceuilWidget;
import 'package:flutter/material.dart';

class AcceuilModel extends FlutterFlowModel<AcceuilWidget> {
  ///  Local state fields for this page.

  bool search = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<ProduitsRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
