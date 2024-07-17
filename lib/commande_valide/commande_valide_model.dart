import '../flutter_flow/flutter_flow_model.dart';
import 'commande_valide_widget.dart' show CommandeValideWidget;
import 'package:flutter/material.dart';

class CommandeValideModel extends FlutterFlowModel<CommandeValideWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
