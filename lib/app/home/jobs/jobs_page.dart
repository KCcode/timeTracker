import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/home/jobs/add_job_page.dart';
import 'package:time_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/services/authBase.dart';
import 'package:time_tracker_flutter/services/database.dart';
import '../models/Job.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth
          .signOut(); //no longer have a reference to the firebase user after sign out
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to logout',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          TextButton(
            //FlatButton > TextButton
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => AddJobPage.show(context),//_createJob(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context){
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) => _toBuilder(context, snapshot),
    );
  }

  Widget _toBuilder(BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        final jobs = snapshot.data;
        final children = jobs!.map<Widget>((job) => Text(job.name)).toList();
        return ListView(children: children,);
      }
      if(snapshot.hasError){
        return Center(child: Text('Some error occurred'),);
      }
      return Center(child: CircularProgressIndicator());
  }


}
