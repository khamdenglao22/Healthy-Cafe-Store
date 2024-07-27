part of 'order_all_list_cubit.dart';

class OrderAllListState extends Equatable {
  final String? error;
  final AppStatus fetchStatus;
  final OrderModel? orderModel;
  final List<OrderDetailModel> orderDetailModel;

  final AppStatus loadMoreStatus;
  final int page;
  final int limit;
  final bool showFloating;

  const OrderAllListState({
    this.orderModel,
    this.orderDetailModel = const [],
    this.error,
    this.fetchStatus = AppStatus.initial,
    this.loadMoreStatus = AppStatus.initial,
    this.page = 0,
    this.limit = 10,
    this.showFloating = false,
  });

  @override
  List<Object> get props => [
        {
          orderModel,
          orderDetailModel,
          error,
          fetchStatus,
          loadMoreStatus,
          page,
          limit,
          showFloating,
        }
      ];

  OrderAllListState copyWith({
    String? error,
    OrderModel? orderModel,
    List<OrderDetailModel>? orderDetailModel,
    AppStatus? fetchStatus,
    AppStatus? loadMoreStatus,
    int? page,
    int? limit,
    bool? showFloating,
  }) {
    return OrderAllListState(
      error: error ?? this.error,
      orderModel: orderModel ?? this.orderModel,
      orderDetailModel: orderDetailModel ?? this.orderDetailModel,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      showFloating: showFloating ?? this.showFloating,
    );
  }
}
