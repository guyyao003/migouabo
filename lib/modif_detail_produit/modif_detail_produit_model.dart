import '../flutter_flow/flutter_flow_util.dart';
import 'modif_detail_produit_widget.dart' show ModifDetailProduitWidget;
import 'package:flutter/material.dart';

class ModifDetailProduitModel
    extends FlutterFlowModel<ModifDetailProduitWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CountController widget.
  int? countControllerValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
