/// Pagination result model used across the app
class PaginationResult {
  int? currentPage;
  int? limit;
  int? numOfPage;

  PaginationResult({this.currentPage, this.limit, this.numOfPage});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    numOfPage = json['numOfPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['limit'] = limit;
    data['numOfPage'] = numOfPage;
    return data;
  }
}
