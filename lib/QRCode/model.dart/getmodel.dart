class LeaveApproval {
  List<Data>? data;
  String? message;

  LeaveApproval({this.data, this.message});

  LeaveApproval.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Message'] = this.message;
    return data;
  }
}

class Data {
  int? leaveDetailId;
  Null empcode;
  Null employeeId;
  int? leaveRuleId;
  String? leaveFromDate;
  String? leaveToDate;
  String? status;
  String? leaveName;
  String? leaveType;
  Null halfDayType;
  String? reasonForLeave;
  Null addressForCorrespondence;
  Null contactNumber;
  String? name;
  Null remark;
  String? rejectionReason;
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  String? absentDays;
  String? validUptoDate;
  String? leaveAppliedDate;
  bool? isHrManager;

  Data({
    this.leaveDetailId,
    this.empcode,
    this.employeeId,
    this.leaveRuleId,
    this.leaveFromDate,
    this.leaveToDate,
    this.status,
    this.leaveName,
    this.leaveType,
    this.halfDayType,
    this.reasonForLeave,
    this.addressForCorrespondence,
    this.contactNumber,
    this.name,
    this.remark,
    this.rejectionReason,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.absentDays,
    this.validUptoDate,
    this.leaveAppliedDate,
    this.isHrManager,
  });

  Data.fromJson(Map<String, dynamic> json) {
    leaveDetailId = json['LeaveDetailId'];
    empcode = json['Empcode'];
    employeeId = json['EmployeeId'];
    leaveRuleId = json['LeaveRuleId'];
    leaveFromDate = json['LeaveFromDate'];
    leaveToDate = json['LeaveToDate'];
    status = json['Status'];
    leaveName = json['LeaveName'];
    leaveType = json['LeaveType'];
    halfDayType = json['HalfDayType'];
    reasonForLeave = json['ReasonForLeave'];
    addressForCorrespondence = json['AddressForCorrespondence'];
    contactNumber = json['ContactNumber'];
    name = json['Name'];
    remark = json['Remark'];
    rejectionReason = json['RejectionReason'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    absentDays = json['AbsentDays'];
    validUptoDate = json['ValidUptoDate'];
    leaveAppliedDate = json['LeaveAppliedDate'];
    isHrManager = json['IsHrManager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveDetailId'] = this.leaveDetailId;
    data['Empcode'] = this.empcode;
    data['EmployeeId'] = this.employeeId;
    data['LeaveRuleId'] = this.leaveRuleId;
    data['LeaveFromDate'] = this.leaveFromDate;
    data['LeaveToDate'] = this.leaveToDate;
    data['Status'] = this.status;
    data['LeaveName'] = this.leaveName;
    data['LeaveType'] = this.leaveType;
    data['HalfDayType'] = this.halfDayType;
    data['ReasonForLeave'] = this.reasonForLeave;
    data['AddressForCorrespondence'] = this.addressForCorrespondence;
    data['ContactNumber'] = this.contactNumber;
    data['Name'] = this.name;
    data['Remark'] = this.remark;
    data['RejectionReason'] = this.rejectionReason;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['FromTime'] = this.fromTime;
    data['ToTime'] = this.toTime;
    data['AbsentDays'] = this.absentDays;
    data['ValidUptoDate'] = this.validUptoDate;
    data['LeaveAppliedDate'] = this.leaveAppliedDate;
    data['IsHrManager'] = this.isHrManager;
    return data;
  }
}
