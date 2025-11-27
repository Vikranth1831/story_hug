import '../data/remote_data_source.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubScriptionModel.dart';
import '../models/SubSubOfCategoryModel.dart';

abstract class SubScriptionRepo {
  Future<SubScriptionModel?> fetchSubscriptionPlans();
}

class SubScriptionImpl implements SubScriptionRepo {
  RemoteDataSource remoteDataSource;
  SubScriptionImpl({required this.remoteDataSource});

  @override
  Future<SubScriptionModel?> fetchSubscriptionPlans() async {
    return await remoteDataSource.fetchSubscriptionPlans();
  }
}
