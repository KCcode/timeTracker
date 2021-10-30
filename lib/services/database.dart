import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_flutter/app/home/models/Job.dart';
import 'package:time_tracker_flutter/services/api_path.dart';

abstract class Database{
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database{
  final String? uid;

  FirestoreDatabase({required this.uid}) : assert(uid != null);

  //Get a Map of key value pairs that represents the fields we want to write in our document
  Future<void> createJob(Job job) => _setData(path: APIPath.job(uid!, 'job_abc'), data: job.toMap());


  Stream<List<Job>> jobsStream(){
    final path = APIPath.jobs(uid!);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots(); // returns a stream of snapshots of the database (firestore collection)
    return snapshots.map((event) => List<Job>.of(event.docs.map((e) { //map will make each event into a stream
      final data = e.data();
      return Job(name: data['name'], ratePerHour: data['ratePerHour']);
    })));
  }

  Future<void> _setData({required String path, required Map<String, dynamic> data})  async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('path: $path data: $data');
    await reference.set(data);
  }
}