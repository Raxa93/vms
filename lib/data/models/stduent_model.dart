

class StudentModel{

  String studentName;
  String phoneNumber;
  String imageUrl;
  String semester;
  String session;
  String section;
  String shift;

  StudentModel({required this.studentName,required this.phoneNumber,required this.imageUrl,required this.semester,required this.session,required this.section,required this.shift});


  factory StudentModel.fromJson(Map<String, dynamic> json) {
    print('I got data ${json['studentName']}');
    print('I got data ${json['section']}');
    return StudentModel(
      studentName: json['studentName'],
      section: json['section'],
      semester: json['semester'],
      shift: json['shift'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      session: json['session'],
    );
  }


}