class DashboardModel {
  final int ongoingTrips;
  final int assignedTrips;
  final bool inspectionPending;
  final int issuesReported;

  DashboardModel(
    this.ongoingTrips,
    this.assignedTrips,
    this.inspectionPending,
    this.issuesReported,
  );

  factory DashboardModel.fromJson(dynamic json) => DashboardModel(
        json['ongoingTrips'] as int,
        json['assignedTrips'] as int,
        json['inspectionPending'] as bool,
        json['issuesReported'] as int,
      );
}
