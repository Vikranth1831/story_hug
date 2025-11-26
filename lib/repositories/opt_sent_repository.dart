import 'package:story_hug/models/otp_sent_model.dart';

import '../data/remote_data_source.dart';

abstract class OtpSentRepository
{

Future<OTPSentModel?> sendotp();
}
class otpsentRepositoryImpl implements OtpSentRepository{
  RemoteDataSource remoteDataSource;
  otpsentRepositoryImpl({required this.remoteDataSource});


  @override
  Future<OTPSentModel?> sendotp() async {
    return await remoteDataSource.sendotp();
  }
}
