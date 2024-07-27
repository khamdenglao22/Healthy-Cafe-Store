part of 'order_cubit.dart';

class OrderState extends Equatable {
  final String? error;
  final AppStatus fetchStatus;
  final OrderModel? orderModel;
  final List<OrderDetailModel> orderDetailModel;


  final AppStatus loadMoreStatus;
  final int page;
  final int limit;
  final bool showFloating;

  const OrderState({
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

  OrderState copyWith({
    String? error,
    OrderModel? orderModel,
    List<OrderDetailModel>? orderDetailModel,
    AppStatus? fetchStatus,
    AppStatus? loadMoreStatus,
    int? page,
    int? limit,
    bool? showFloating,
  }) {
    return OrderState(
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
