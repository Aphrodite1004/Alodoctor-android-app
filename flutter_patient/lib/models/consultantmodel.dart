class consultantmodel {
  int id;
  int doctorId;
  int patientId;
  String type;
  String status;
  int rate;
  String feedback;
  String source;
  String createdAt;
  String updatedAt;
  String unreadNum;
  String fname;
  String lname;

  consultantmodel();
  consultantmodel.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'];
      doctorId = json['doctor_id'];
      patientId = json['patient_id'];
      type = json['type'];
      status = json['status'];
      rate = json['rate'];
      feedback = json['feedback'];
      source = json['source'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      unreadNum = json['unread_num'];
      fname = json['fname'];
      lname = json['lname'];
    } catch (e) {
      print(e);
    }
  }
}