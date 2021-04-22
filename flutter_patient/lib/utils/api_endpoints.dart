class APIEndPoints{

  // static final String kApiBase = 'http://10.10.10.192/api/';
  static final String kApiBase = 'http://104.248.81.101/api/';
  static final String mediaurl = 'http://104.248.81.101/upload/photo/';
  static final String chat_image_url = 'http://104.248.81.101/upload/chat/';
  static final String qrcode_image_url = 'http://104.248.81.101/upload/pcode/';

  static final String loginurl = kApiBase + 'patient_login';
  static final String loginsocialurl = kApiBase + 'patient_login_social';
  static final String consultanturl = kApiBase + 'patient_consultation';
  static final String offlineurl = kApiBase + 'doctor_offline';
  static final String onlineurl = kApiBase + 'doctor_online';
  static final String changepasswordurl = kApiBase + 'patient_password';
  static final String patient_startConsultant = kApiBase + 'patient_startConsultant';
  static final String patient_sendNotification = kApiBase + 'patient_sendNotification';
  static final String patient_menulist = kApiBase + 'patient_menulist';
  static final String patient_givefeedback = kApiBase + 'patient_givefeedback';
  static final String patient_addmoney = kApiBase + 'patient_addmoney';
  static final String patient_register = kApiBase + 'patient_register';
  static final String contactus = kApiBase + 'contactus';
  static final String patientgetlist = kApiBase + 'patientgetlist';
}