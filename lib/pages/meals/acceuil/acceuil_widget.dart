import 'package:boxicons/boxicons.dart';

import '../../../backend/backend.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:text_search/text_search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'acceuil_model.dart';
export 'acceuil_model.dart';

class AcceuilWidget extends StatefulWidget {
  const AcceuilWidget({super.key});

  @override
  State<AcceuilWidget> createState() => _AcceuilWidgetState();
}

class _AcceuilWidgetState extends State<AcceuilWidget> {
  late AcceuilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AcceuilModel());
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Acceuil'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.sizeOf(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        
        preferredSize:  Size.fromHeight(mediaquery.height * 0.18),
        child: 
        Container(
        color: FlutterFlowTheme.of(context).primary,
          child: Column(
            children: [
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 40.0, 0.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Migouabo',
                        style: FlutterFlowTheme.of(context).displayLarge.override(
                              fontFamily: 'Plus Jakarta Sans',
                              // color: Colors.white,
                              fontSize: 30.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                        Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: FutureBuilder<int>(
                future: queryPanierRecordCount(),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  int badgeCount = snapshot.data!;
                  return 
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent('ACCEUIL_PAGE_Badge_infy4d0k_ON_TAP');
                      logFirebaseEvent('Badge_navigate_to');
                      context.pushNamed('Panier');
                    },
                    child: badges.Badge(
                      badgeContent: Text(
                        valueOrDefault<String>(
                          badgeCount.toString(),
                          '0',
                        ),
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              fontFamily: 'Inter',
                              fontSize: 8,
                              color: Colors.white,
                              letterSpacing: 0.0,
                            ),
                      ),
                      showBadge: true,
                      shape: badges.BadgeShape.circle,
                      elevation: 0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                      position: badges.BadgePosition.topEnd(),
                      animationType: badges.BadgeAnimationType.scale,
                      toAnimate: true,
                      child: Icon(
                        Icons.shopping_cart,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                    ),
                  );
                },
              ),
            ),
                    ],
                  ),
                ),
              ),
              Padding(
                 padding: const EdgeInsetsDirectional.fromSTEB(8.0, 20.0, 8.0, 20.0),
                child: Container(
                    width: 385.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius:  BorderRadius.circular(
                        8
                      ),
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.search,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            
                            Expanded(
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onChanged: (String? value) async {
                                  logFirebaseEvent(
                                    'ACCEUIL_PAGE_RECHERCHE_BTN_ON_TAP');
                                logFirebaseEvent('Button_simple_search');
                                await queryProduitsRecordOnce()
                                    .then(
                                      (value) => _model
                                          .simpleSearchResults = TextSearch(
                                        value
                                            .map(
                                              (value) =>
                                                  TextSearchItem.fromTerms(
                                                      value, [
                                                value.nomProduit,
                                                value.prix,
                                                value.provenance,
                                                value.categorie
                                              ]),
                                            )
                                            .toList(),
                                      )
                                          .search(_model.textController.text)
                                          .map((value) => value.object)
                                          .toList(),
                                    )
                                    .onError((_, __) =>
                                        _model.simpleSearchResults = [])
                                    .whenComplete(() => setState(() {}));
                                        
                                logFirebaseEvent('Button_update_page_state');
                                _model.search = false;
                                setState(() {});
                                },
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Rechercher un produit',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 8.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'ACCEUIL_PAGE_Icon_ud7qemiu_ON_TAP');
                                  logFirebaseEvent('Icon_reset_form_fields');
                                  setState(() {
                                    _model.textController?.clear();
                                  });
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),        
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          pauseAutoPlayOnTouch: true,
                          autoPlayCurve: Curves.easeInOut,
                          height: MediaQuery.of(context).size.height * 0.25,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          Container(
                 margin: EdgeInsets.symmetric(vertical: mediaquery.height * .015),
                            height: mediaquery.height * .06,
                          width: mediaquery.height ,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/images/Présentation 33.png'), fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(15),
                            color: FlutterFlowTheme.of(context).primary),
                        ),
                        Container(
                 margin: EdgeInsets.symmetric(vertical: mediaquery.height * .015),
                            height: mediaquery.height * .06,
                          width: mediaquery.height ,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/images/Présentation44.jpg'), fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(15),
                            color: FlutterFlowTheme.of(context).primary),
                        ),
                          Container(
                 margin: EdgeInsets.symmetric(vertical: mediaquery.height * .015),
                            height: mediaquery.height * .06,
                          width: mediaquery.height ,
                          decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/images/Présentation222.png'), fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(15),
                            color: FlutterFlowTheme.of(context).primary),
                        ),
                        
                        ],
                      ),

                          ////////////// section offres 
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
              Row(
                children: [Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                  'Offres',
                  style: theme
                      .bodyLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      )
                      ),
                ),],
              ),
              
              Builder(
                builder: (context) {
              if (_model.search) {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      9.0, 0.0, 9.0, 97.0),
                  child: StreamBuilder<List<ProduitsRecord>>(
                    stream: queryProduitsRecord(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 30.0,
                            height: 25.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context)
                                    .primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<ProduitsRecord>
                          gridViewProduitsRecordList =
                          snapshot.data!;
                      return SizedBox(
                        height: mediaquery.height * .42,
                        child: GridView.builder(
                          
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                         
                          itemCount:
                              gridViewProduitsRecordList.length,
                         
                          itemBuilder: (context, gridViewIndex) {
                            final gridViewProduitsRecord =
                                gridViewProduitsRecordList[
                                    gridViewIndex];
                            return Container(
                              // padding: EdgeInsets.all(10),
                              width: mediaquery.width,
                              height: mediaquery.height,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffffDAF7A6),
                                    blurRadius: 2,
                                    offset: Offset(2, 5)
                                  )

                                ],
                                    borderRadius: BorderRadius.circular(15),
                                    color:Color.fromARGB(255, 243, 241, 238)
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
                                    )
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
                                          margin:EdgeInsets.all(5),

                                          height:110,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:NetworkImage(
                                              gridViewProduitsRecord
                                                  .image,                                                  
                                            ), ),
                                            borderRadius:  BorderRadius.circular(15),
                                            color: FlutterFlowTheme.of(
                                                    context)
                                                .secondaryBackground,
                                          ),
                                         
                                        ),
                                       
                                       Padding(
                                         padding: const EdgeInsets.only(left: 10),
                                         child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Column(
                                              crossAxisAlignment:CrossAxisAlignment.start ,
                                              children: [
                                             Text(  gridViewProduitsRecord
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
                                                              fontWeight: FontWeight.bold
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
                                                                    FontWeight.w600,

                                                              ),
                                                        ),
                                                        const TextSpan(
                                                          text:
                                                              ' FCFA',
                                                          style:
                                                              TextStyle(fontWeight: FontWeight.bold),
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
                                             ],),
                                             SizedBox(
                                              width: 40,
                                             ),
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                   color: FlutterFlowTheme.of(context).primary,
                                                   borderRadius: BorderRadius.circular(10)

                                                ),
                                                child: Icon(Boxicons.bx_shopping_bag,size: 20,color: Colors.white,),)
                                           ],
                                          
                                         ),
                                       )
                                             
                                           
                                      ],
                                    ),
                                    
                             
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      9.0, 0.0, 9.0, 97.0),
                  child: Builder(
                    builder: (context) {
                      final afficheResultat =
                          _model.simpleSearchResults.toList();
                      return SizedBox(
                        height: mediaquery.height * .45,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: afficheResultat.length,
                          itemBuilder:
                              (context, afficheResultatIndex) {
                            final afficheResultatItem =
                                afficheResultat[afficheResultatIndex];
                            return Container(
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
                                      'ACCEUIL_PAGE_Column_0r4bvx74_ON_TAP');
                                  logFirebaseEvent(
                                      'Column_navigate_to');
                            
                                  context.pushNamed(
                                    'DetailProduit',
                                    queryParameters: {
                                      'fruits': serializeParam(
                                        afficheResultatItem,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'fruits': afficheResultatItem,
                                    },
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(
                                                context)
                                            .secondaryBackground,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(
                                                8.0),
                                        child: Image.network(
                                          afficheResultatItem.image,
                                          width: 300.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional
                                          .fromSTEB(
                                              8.0, 0.0, 8.0, 0.0),
                                      child: Row(
                                        mainAxisSize:
                                            MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  afficheResultatItem
                                                      .nomProduit,
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
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
                                                            afficheResultatItem
                                                                .prix,
                                                        style: FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
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
                                              ].divide(const SizedBox(
                                                  height: 2.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(const SizedBox(height: 7.0)),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
                            },
                          ),
             
                          
                            ],
                          ),
            ],
          ),
        ),
      ),
    );
  }
}

class Categorie extends StatelessWidget {
   const Categorie({
    super.key,
    required this.mediaquery,
    required this.imageUrl,
    required this.nomCat,
    required this.callback(),
  });

  final Size mediaquery;
  final String imageUrl;
  final String nomCat;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: mediaquery.width * .35,
          height: mediaquery.height * .2,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.black12),
            color: FlutterFlowTheme.of(context)
                .primaryBackground,
            borderRadius:  BorderRadius.circular(
             5
            ),
           
          ),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              callback();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                 
                  width: double.infinity,
                  height: mediaquery.height * .15,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(
                            context)
                        .secondaryBackground,
                    borderRadius:
                        const BorderRadius.only(
                      bottomLeft:
                          Radius.circular(5.0),
                      bottomRight:
                          Radius.circular(5.0),
                      topLeft:
                          Radius.circular(5.0),
                      topRight:
                          Radius.circular(5.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(
                      bottomLeft:
                          Radius.circular(5.0),
                      bottomRight:
                          Radius.circular(5.0),
                      topLeft:
                          Radius.circular(5.0),
                      topRight:
                          Radius.circular(5.0),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    nomCat,
                    style: FlutterFlowTheme.of(
                            context)
                        .bodyMedium
                        .override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ].divide(const SizedBox(height: 8.0)),
            ),
          ),
        ),
      ],
    );
  }
}
