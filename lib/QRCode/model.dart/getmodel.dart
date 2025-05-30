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
    data['Message'] = message;
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
    data['LeaveDetailId'] = leaveDetailId;
    data['Empcode'] = empcode;
    data['EmployeeId'] = employeeId;
    data['LeaveRuleId'] = leaveRuleId;
    data['LeaveFromDate'] = leaveFromDate;
    data['LeaveToDate'] = leaveToDate;
    data['Status'] = status;
    data['LeaveName'] = leaveName;
    data['LeaveType'] = leaveType;
    data['HalfDayType'] = halfDayType;
    data['ReasonForLeave'] = reasonForLeave;
    data['AddressForCorrespondence'] = addressForCorrespondence;
    data['ContactNumber'] = contactNumber;
    data['Name'] = name;
    data['Remark'] = remark;
    data['RejectionReason'] = rejectionReason;
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    data['FromTime'] = fromTime;
    data['ToTime'] = toTime;
    data['AbsentDays'] = absentDays;
    data['ValidUptoDate'] = validUptoDate;
    data['LeaveAppliedDate'] = leaveAppliedDate;
    data['IsHrManager'] = isHrManager;
    return data;
  }
}
