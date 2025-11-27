

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/models/sample_text_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class SampleTextRepository {

  Future<SampleTextModel?> getSampleText();
}

class SampleTextRepositoryImpl implements  SampleTextRepository{
  RemoteDataSource remoteDataSource;
  SampleTextRepositoryImpl({required this.remoteDataSource});


  @override
  Future<SampleTextModel?> getSampleText() async {
    return await remoteDataSource.getSampleText();
  }
}
