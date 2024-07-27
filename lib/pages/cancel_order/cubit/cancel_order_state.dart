part of 'cancel_order_cubit.dart';

class CancelOrderState extends Equatable {
  const CancelOrderState({
    this.cancelStatus,
    this.error,
    this.fetchStatus = AppStatus.initial, 
  });

  final bool? cancelStatus;
  final String? error;
  final AppStatus fetchStatus;

  @override
  List<Object> get props => [
        {
          cancelStatus,
          error,
          fetchStatus,
        }
      ];

  CancelOrderState copyWith({
    bool? cancelStatus,
    String? error,
    AppStatus? fetchStatus,
  }) {
    return CancelOrderState(
      cancelStatus: cancelStatus ?? this.cancelStatus,
      error: error ?? this.error,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }
}
