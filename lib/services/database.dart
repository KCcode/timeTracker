import 'package:time_tracker_flutter/app/home/models/Job.dart';
import 'package:time_tracker_flutter/services/api_path.dart';
import 'package:time_tracker_flutter/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String? uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({required this.uid}) : assert(uid != null);

  //Get a Map of key value pairs that represents the fields we want to write in our document
  Future<void> createJob(Job job) =>
      _service.setData(path: APIPath.job(uid!, 'job_abc'), data: job.toMap());

  Stream<List<Job>> jobsStream() => _service.collectionStream(path: APIPath.jobs(uid!), builder: (data) => Job.fromMap(data));




}
