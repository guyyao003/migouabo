import 'package:flutter/material.dart';
import 'package:migouabo/backend/backend.dart';
import 'package:migouabo/backend/firebase_analytics/analytics.dart';
import 'package:migouabo/backend/schema/produits_record.dart';
import 'package:migouabo/flutter_flow/flutter_flow_model.dart';
import 'package:migouabo/flutter_flow/flutter_flow_theme.dart';
import 'package:migouabo/flutter_flow/flutter_flow_util.dart';
import 'acceuil_model.dart';

class OffreGridView extends StatefulWidget {
  const OffreGridView({super.key});

  @override
  State<OffreGridView> createState() => _OffreGridViewState();
}

class _OffreGridViewState extends State<OffreGridView> {
  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  late AcceuilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _model = createModel(context, () => AcceuilModel());
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Acceuil'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
          initializeSelection();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    super.initState();
  
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 0,
          centerTitle: true,
          title:  Text(
            'Offres',
            style: Theme.of(context).textTheme
                      .bodyLarge?.copyWith(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      )

          ),         
        ),
        body: 
            GridBuilder(
    isSelectionMode: isSelectionMode,
    selectedList: _selected,
    onSelectionChange: (bool x) {
      setState(() {
        isSelectionMode = x;
      });
    }   
              
)

           );
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final ValueChanged<bool>? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  @override
  Widget build(BuildContext context) {
     final mediaquery = MediaQuery.sizeOf(context);
    final theme = Theme.of(context).textTheme;
    return StreamBuilder<List<ProduitsRecord>>(
      stream: queryProduitsRecord(),
      builder: (context, snapshot) {
        List<ProduitsRecord>
                          gridViewProduitsRecordList =
                          snapshot.data!;
        return GridView.builder(
            itemCount: gridViewProduitsRecordList.length,
 padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                          childAspectRatio: 1.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
            itemBuilder: (_,  gridViewIndex) {
              final gridViewProduitsRecord =
                                  gridViewProduitsRecordList[
                                      gridViewIndex];
              return Container(
                            margin: const EdgeInsets.only(top: 5, left: 5, right:  5),
                            width: mediaquery.width,
                            height: mediaquery.height,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(8),
                                  color:const Color.fromARGB(82, 200, 230, 201),
                            ),
                            child: InkWell(                  
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'ACCEUIL_PAGE_Column_plqok034_ON_TAP');
                                logFirebaseEvent(
                                    'Column_navigate_to');
                                context.pushNamed(
                                  'DetailProduit',
                                  queryParameters: {
                                    'fruits': serializeParam(
                                      gridViewProduitsRecord,
                                      ParamType.Document,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'fruits':
                                        gridViewProduitsRecord,
                                  },
                                );
                              },
                              //////////////////
                              child:                                           
                                  Column(                    
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: mediaquery.height * .15,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:NetworkImage(
                                            gridViewProduitsRecord
                                                .image,                                                  
                                          ), ),
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                          color: FlutterFlowTheme.of(
                                                  context)
                                              .secondaryBackground,
                                        ),
                                        margin: EdgeInsets.only(top: mediaquery.height * .002, right:mediaquery.width* .01, left: mediaquery.width* .01  ),
                                       
                                      ),
                                     
                                     Column(
                                      children: [
                                     Text(gridViewProduitsRecord
                                                .nomProduit,
                                            maxLines: 1,
                                            style: theme
                                                .labelLarge?.copyWith()
                                                .override(
                                                  fontFamily:
                                                      'Inter',
                                                  fontSize:
                                                      14.0,
                                                  letterSpacing:
                                                      0.0,
                                                ),
                                          ),
                                          RichText(
                                            textScaler:
                                                MediaQuery.of(
                                                        context)
                                                    .textScaler,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      gridViewProduitsRecord
                                                          .prix,
                                                  style: theme
                                                      .labelLarge?.copyWith()
                                                      .override(
                                                        fontFamily:
                                                            'Inter',
                                                        letterSpacing:
                                                            0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                const TextSpan(
                                                  text:
                                                      ' F CFA',
                                                  style:
                                                      TextStyle(),
                                                )
                                              ],
                                              style: FlutterFlowTheme
                                                      .of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        'Inter',
                                                    letterSpacing:
                                                        0.0,
                                                    fontWeight:
                                                        FontWeight
                                                            .normal,
                                                  ),
                                            ),
                                          ),
                                     ],)    
                                    ],
                                  ),
                            ),
              );
            });
      }
    );
  }
}
