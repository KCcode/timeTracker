import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  //making this a singleton
  FirestoreService._(); //private constructor cannot be create outside of this file
  static final instance = FirestoreService._();

  Stream<List<T>> collectionStream<T>(
      {required String path,
        required T Function(Map<String, dynamic> data) builder}) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots(); // returns a stream of snapshots of the database (firestore collection)
    return snapshots.map(
          (event) => (event.docs.map(//map will make each event into a stream
              (e) {
            final data = e.data();
            return builder(
                data); //Job(name: data['name'], ratePerHour: data['ratePerHour']);
          })).toList(),
    );
  }

  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('path: $path data: $data');
    await reference.set(data);
  }
}