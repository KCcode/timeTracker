import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  _AddJobPageState createState() => _AddJobPageState();

  static void show(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJobPage(),
        fullscreenDialog: true,
      ),
    );
  }
}


class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  late int _ratePerHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Job'),
        actions: [
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void _submit(){
    //TODO validate and save form and send data fire store
    if(_validateAndSaveForm()){
      print("name: $_name rate: $_ratePerHour");
    }
  }


  Widget _buildContents() {
    return SingleChildScrollView(
      //uses the fallbakc height of the palceholder in this case
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildFormChildren()),
    );
  }

  int saveRate(String? value){
    int? result;
    if(value != null){
     result = int.tryParse(value);
     return ((result == null) ? 0: result);
    }
    return 0;
  }

  String? _validateName(String? value){
    if(value == null || value.isEmpty){
      return 'Please enter name';
    }
    return null;
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job name'),
        onSaved: (value) => _name = value ?? null,
        validator: (value) => _validateName(value),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'rate per hour'),
        keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
        onSaved: (value) => _ratePerHour = saveRate(value),
      ),
    ];
  }
}
