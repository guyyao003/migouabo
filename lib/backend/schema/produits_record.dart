import 'dart:async';

import 'package:collection/collection.dart';

import '../../backend/schema/util/firestore_util.dart';

import 'index.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class ProduitsRecord extends FirestoreRecord {
  ProduitsRecord._(
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

  // "provenance" field.
  String? _provenance;
  String get provenance => _provenance ?? '';
  bool hasProvenance() => _provenance != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "categorie" field.
  String? _categorie;
  String get categorie => _categorie ?? '';
  bool hasCategorie() => _categorie != null;

  void _initializeFields() {
    _nomProduit = snapshotData['nom_produit'] as String?;
    _prix = snapshotData['prix'] as String?;
    _provenance = snapshotData['provenance'] as String?;
    _description = snapshotData['description'] as String?;
    _image = snapshotData['image'] as String?;
    _categorie = snapshotData['categorie'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('produits');

  static Stream<ProduitsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProduitsRecord.fromSnapshot(s));

  static Future<ProduitsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProduitsRecord.fromSnapshot(s));

  static ProduitsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProduitsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProduitsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProduitsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProduitsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProduitsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProduitsRecordData({
  String? nomProduit,
  String? prix,
  String? provenance,
  String? description,
  String? image,
  String? categorie,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nom_produit': nomProduit,
      'prix': prix,
      'provenance': provenance,
      'description': description,
      'image': image,
      'categorie': categorie,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProduitsRecordDocumentEquality implements Equality<ProduitsRecord> {
  const ProduitsRecordDocumentEquality();

  @override
  bool equals(ProduitsRecord? e1, ProduitsRecord? e2) {
    return e1?.nomProduit == e2?.nomProduit &&
        e1?.prix == e2?.prix &&
        e1?.provenance == e2?.provenance &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image &&
        e1?.categorie == e2?.categorie;
  }

  @override
  int hash(ProduitsRecord? e) => const ListEquality().hash([
        e?.nomProduit,
        e?.prix,
        e?.provenance,
        e?.description,
        e?.image,
        e?.categorie
      ]);

  @override
  bool isValidKey(Object? o) => o is ProduitsRecord;
}
