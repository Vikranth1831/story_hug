import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/internet_status/internet_status_bloc.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[
    // RepositoryProvider<RemoteDataSource>(
    //   create: (context) => RemoteDataSourceImpl(),
    // ),
    // RepositoryProvider<MentorRemoteDataSource>(
    //   create: (context) => MentorRemoteDataSourceImpl(),
    // ),

  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<InternetStatusBloc>(create: (context) => InternetStatusBloc()),

  ];
}
