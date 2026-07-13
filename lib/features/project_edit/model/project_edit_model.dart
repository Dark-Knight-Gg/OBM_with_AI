class ProjectEditModel {
  final int? id;
  final String? name;
  final String? statusCode;
  final int? projectManagerId;
  final String? startDate;
  final String? endDate;
  final String? note;

  ProjectEditModel({
    this.id,
    this.name,
    this.statusCode,
    this.projectManagerId,
    this.startDate,
    this.endDate,
    this.note,
  });

  factory ProjectEditModel.fromJson(Map<String, dynamic> json) {
    return ProjectEditModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      statusCode: json['statusCode'] as String?,
      projectManagerId: json['projectManagerId'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (statusCode != null) 'statusCode': statusCode,
      if (projectManagerId != null) 'projectManagerId': projectManagerId,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (note != null) 'note': note,
    };
  }

  ProjectEditModel copyWith({
    int? id,
    String? name,
    String? statusCode,
    int? projectManagerId,
    String? startDate,
    String? endDate,
    String? note,
  }) {
    return ProjectEditModel(
      id: id ?? this.id,
      name: name ?? this.name,
      statusCode: statusCode ?? this.statusCode,
      projectManagerId: projectManagerId ?? this.projectManagerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      note: note ?? this.note,
    );
  }
}

class ProjectEditResponse {
  final int? id;
  final String? name;
  final String? statusCode;
  final int? projectManagerId;
  final int? status;
  final String? message;
  final String? startDate;
  final String? endDate;
  final String? note;

  ProjectEditResponse({
    this.id,
    this.name,
    this.statusCode,
    this.projectManagerId,
    this.status,
    this.message,
    this.startDate,
    this.endDate,
    this.note,
  });

  factory ProjectEditResponse.fromJson(Map<String, dynamic> json) {
    return ProjectEditResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      statusCode: json['statusCode'] as String?,
      projectManagerId: json['projectManagerId'] as int?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      note: json['note'] as String?,
    );
  }
}
