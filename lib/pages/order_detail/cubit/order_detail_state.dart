part of 'order_detail_cubit.dart';

class OrderDetailState extends Equatable {
  final String? error;
  final AppStatus fetchStatus;
  final OrderDetailModel? orderDetail;
  final bool? confirmStatus;

  const OrderDetailState({
    this.error,
    this.fetchStatus = AppStatus.initial,
    this.orderDetail,
    this.confirmStatus,
  });

  @override
  List<Object> get props => [
        {
          error,
          fetchStatus,
          orderDetail,
          confirmStatus,
        }
      ];

  OrderDetailState copyWith({
    String? error,
    OrderDetailModel? orderDetail,
    AppStatus? fetchStatus,
    bool? confirmStatus,
  }) {
    return OrderDetailState(
      error: error ?? this.error,
      orderDetail: orderDetail ?? this.orderDetail,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
    );
  }
}
