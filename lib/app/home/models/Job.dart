class Job{
  final String name;
  final int ratePerHour;

  Job({required this.name, required this.ratePerHour});

  static fromMap(Map<String, dynamic>? data){
    if(data == null){
      return null;
    }
    return Job(
      name: data['name'],
      ratePerHour: data['ratePerHour']
    );
  }

  /*
  factory Job.fromMap(Map<String, dynamic> data){
    return Job(
        name: data['name'],
        ratePerHour: data['ratePerHour']
    );
  }
 */

  Map<String, dynamic> toMap(){
    return{
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}