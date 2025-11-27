import '../data/remote_data_source.dart';
import '../models/CreatePaymentModel.dart';
import '../models/VerifyPaymentModel.dart';

abstract class PaymentRepository {
  Future<CreatePaymentModel?> createPayment(Map<String, dynamic> data);
  Future<VerifyPaymentModel?> verifyPayment(Map<String, dynamic> data);
}

class PaymentRepositoryImpl implements PaymentRepository {
  RemoteDataSource remoteDataSource;
  PaymentRepositoryImpl({required this.remoteDataSource});
  @override
  Future<CreatePaymentModel?> createPayment(Map<String, dynamic> data) async {
    return await remoteDataSource.createPayment(data);
  }

  @override
  Future<VerifyPaymentModel?> verifyPayment(Map<String, dynamic> data) async {
    return await remoteDataSource.verifyPayment(data);
  }
}
