import 'dart:async';

import 'package:collection/collection.dart';

import '../../backend/schema/util/firestore_util.dart';

import 'index.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class PanierRecord extends FirestoreRecord {
  PanierRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "nom_produit" field.
  String? _nomProduit;
  String get nomProduit => _nomProduit ?? '';
  bool hasNomProduit() => _nomProduit != null;

  // "prix" field.
  String? _prix;
  String get prix => _prix ?? '';
  bool hasPrix() => _prix != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "categorie" field.
  String? _categorie;
  String get categorie => _categorie ?? '';
  bool hasCategorie() => _categorie != null;

  // "quantite" field.
  int? _quantite;
  int get quantite => _quantite ?? 0;
  bool hasQuantite() => _quantite != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _nomProduit = snapshotData['nom_produit'] as String?;
    _prix = snapshotData['prix'] as String?;
    _image = snapshotData['image'] as String?;
    _categorie = snapshotData['categorie'] as String?;
    _quantite = castToType<int>(snapshotData['quantite']);
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Panier');

  static Stream<PanierRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PanierRecord.fromSnapshot(s));

  static Future<PanierRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PanierRecord.fromSnapshot(s));

  static PanierRecord fromSnapshot(DocumentSnapshot snapshot) => PanierRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PanierRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PanierRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PanierRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PanierRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPanierRecordData({
  String? nomProduit,
  String? prix,
  String? image,
  String? categorie,
  int? quantite,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nom_produit': nomProduit,
      'prix': prix,
      'image': image,
      'categorie': categorie,
      'quantite': quantite,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class PanierRecordDocumentEquality implements Equality<PanierRecord> {
  const PanierRecordDocumentEquality();

  @override
  bool equals(PanierRecord? e1, PanierRecord? e2) {
    return e1?.nomProduit == e2?.nomProduit &&
        e1?.prix == e2?.prix &&
        e1?.image == e2?.image &&
        e1?.categorie == e2?.categorie &&
        e1?.quantite == e2?.quantite &&
        e1?.description == e2?.description;
  }

  @override
  int hash(PanierRecord? e) => const ListEquality().hash([
        e?.nomProduit,
        e?.prix,
        e?.image,
        e?.categorie,
        e?.quantite,
        e?.description
      ]);

  @override
  bool isValidKey(Object? o) => o is PanierRecord;
}
