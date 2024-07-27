part of 'order_all_cubit.dart';

class OrderAllState extends Equatable {
  final String? error;
  final AppStatus fetchStatus;

  const OrderAllState({
    this.error,
    this.fetchStatus = AppStatus.initial,
  });

  @override
  List<Object> get props => [
        {
          error,
          fetchStatus,
        }
      ];

  OrderAllState copyWith({
    String? error,
    AppStatus? fetchStatus,
  }) {
    return OrderAllState(
      error: error ?? this.error,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }
}
