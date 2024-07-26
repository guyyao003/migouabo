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

  // Fields
  String? _nomProduit;
  String? _prix;
  String? _image;
  String? _categorie;
  int? _quantite;
  String? _description;
  int? _totalPrix;

  // Getters
  String get nomProduit => _nomProduit ?? '';
  String get prix => _prix ?? '';
  String get image => _image ?? '';
  String get categorie => _categorie ?? '';
  int get quantite => _quantite ?? 0;
  String get description => _description ?? '';
  int get totalPrix => _totalPrix ?? 0;

  // Checkers
  bool hasNomProduit() => _nomProduit != null;
  bool hasPrix() => _prix != null;
  bool hasImage() => _image != null;
  bool hasCategorie() => _categorie != null;
  bool hasQuantite() => _quantite != null;
  bool hasDescription() => _description != null;
  bool hasTotalPrix() => _totalPrix != null;

  // Conversion from string to int
  int prixToInt(String price) {
    return int.tryParse(price.replaceAll('F CFA', '').trim()) ?? 0;
  }

  void _initializeFields() {
    _nomProduit = snapshotData['nom_produit'] as String?;
    _prix = snapshotData['prix'] as String?;
    _image = snapshotData['image'] as String?;
    _categorie = snapshotData['categorie'] as String?;
    _quantite = snapshotData['quantite'] as int?;
    _description = snapshotData['description'] as String?;
    _totalPrix = prixToInt(prix) * quantite;
  }

  // Calculate the total for all items in the cart
  static int calculateTotaux(List<PanierRecord> panierRecords) {
    int total = 0;
    for (var record in panierRecords) {
      total += record.totalPrix;
    }
    return total;
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
        e1?.description == e2?.description &&
        e1?.totalPrix == e2?.totalPrix;
  }

  @override
  int hash(PanierRecord? e) => const ListEquality().hash([
        e?.nomProduit,
        e?.prix,
        e?.image,
        e?.categorie,
        e?.quantite,
        e?.description,
        e?.totalPrix,
      ]);

  @override
  bool isValidKey(Object? o) => o is PanierRecord;
}
