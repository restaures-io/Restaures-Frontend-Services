class WorkingDay {
  final List<String> days;
  final Map<String, dynamic> hours;

  WorkingDay({
    required this.days,
    required this.hours,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      days: List<String>.from(json['days']),
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'hours': hours,
    };
  }
}

