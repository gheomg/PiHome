enum NumberOfRecords {
  all,
  ten,
  twentyFive,
  fifty,
  hundred;
}

extension NumberOfRecordsExtension on NumberOfRecords {
  String getValue() {
    switch (this) {
      case NumberOfRecords.ten:
        return '10';
      case NumberOfRecords.twentyFive:
        return '25';
      case NumberOfRecords.fifty:
        return '50';
      case NumberOfRecords.hundred:
        return '100';
      default:
        return '';
    }
  }

  String getDescription() {
    if (this == NumberOfRecords.all) return name;
    return getValue().toString();
  }
}
