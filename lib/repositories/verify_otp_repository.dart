

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/otp_verified_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class OtpVerifyRepository {
  Future<OTPVerifiedModel?> verifyotp(Map<String, dynamic> data);

}

class VerifyOtpRepositoryImpl implements OtpVerifyRepository{
  RemoteDataSource remoteDataSource;
  VerifyOtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<OTPVerifiedModel?> verifyotp(Map<String, dynamic> data) async {
    return await remoteDataSource.verifyOtp(data);
  }

}

