part of 'rider_cubit.dart';

class RiderState extends Equatable {
  final String? error;
  final AppStatus fetchStatus;
  final List<RiderModel> riderList;
  final int selectedRider;
  final bool? setRiderStatus;

  const RiderState({
    this.error,
    this.fetchStatus = AppStatus.initial,
    this.riderList = const [],
    this.selectedRider = 0,
    this.setRiderStatus,
  });

  @override
  List<Object> get props => [
        {
          error,
          fetchStatus,
          riderList,
          selectedRider,
          setRiderStatus,
        }
      ];

  RiderState copyWith({
    String? error,
    List<RiderModel>? riderList,
    AppStatus? fetchStatus,
    int? selectedRider,
    bool? setRiderStatus,
  }) {
    return RiderState(
      error: error ?? this.error,
      riderList: riderList ?? this.riderList,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      selectedRider: selectedRider ?? this.selectedRider,
      setRiderStatus: setRiderStatus ?? this.setRiderStatus,
    );
  }
}
