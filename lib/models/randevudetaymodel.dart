class randevudetay {
  bool? success;
  String? message;
  Data? data;

  randevudetay({this.success, this.message, this.data});

  randevudetay.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? branchId;
  int? appointmentFor;
  int? appointmentWith;
  int? treatmentGroupId;
  String? startAt;
  String? endAt;
  String? note;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Patient? patient;
  Doctor? doctor;

  Data(
      {this.id,
      this.branchId,
      this.appointmentFor,
      this.appointmentWith,
      this.treatmentGroupId,
      this.startAt,
      this.endAt,
      this.note,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.patient,
      this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    appointmentFor = json['appointment_for'];
    appointmentWith = json['appointment_with'];
    treatmentGroupId = json['treatment_group_id'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    note = json['note'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['appointment_for'] = this.appointmentFor;
    data['appointment_with'] = this.appointmentWith;
    data['treatment_group_id'] = this.treatmentGroupId;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['note'] = this.note;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Patient {
  int? id;
  int? tenantId;
  int? doctorId;
  Null? avatar;
  String? documentNo;
  String? identityNumber;
  Null? nationality;
  String? name;
  Null? email;
  String? phone;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? avatarPath;

  Patient(
      {this.id,
      this.tenantId,
      this.doctorId,
      this.avatar,
      this.documentNo,
      this.identityNumber,
      this.nationality,
      this.name,
      this.email,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.avatarPath});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    doctorId = json['doctor_id'];
    avatar = json['avatar'];
    documentNo = json['document_no'];
    identityNumber = json['identity_number'];
    nationality = json['nationality'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    avatarPath = json['avatar_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenant_id'] = this.tenantId;
    data['doctor_id'] = this.doctorId;
    data['avatar'] = this.avatar;
    data['document_no'] = this.documentNo;
    data['identity_number'] = this.identityNumber;
    data['nationality'] = this.nationality;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['avatar_path'] = this.avatarPath;
    return data;
  }
}

class Doctor {
  int? id;
  int? roleId;
  int? tenantId;
  String? name;
  String? email;
  String? phone;
  int? commissionRate;
  Null? emailVerifiedAt;
  Null? avatar;
  int? status;
  Null? openingTime;
  Null? closingTime;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Doctor(
      {this.id,
      this.roleId,
      this.tenantId,
      this.name,
      this.email,
      this.phone,
      this.commissionRate,
      this.emailVerifiedAt,
      this.avatar,
      this.status,
      this.openingTime,
      this.closingTime,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    tenantId = json['tenant_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    commissionRate = json['commission_rate'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    status = json['status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['commission_rate'] = this.commissionRate;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
