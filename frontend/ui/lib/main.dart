import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/cubits/data/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DataCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'flutter.py',
        home: DataScreen(),
      ),
    );
  }
}

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  void initState() {
    super.initState();

    DataCubit.cubit(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          // loading
          if (state is DataFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // success
          else if (state is DataFetchSuccess) {
            return ListView(
              children: state.data!.words
                  .map(
                    (word) => ListTile(
                      title: Text(word),
                    ),
                  )
                  .toList(),
            );
          }

          // failure
          else if (state is DataFetchFailed) {
            return Center(
              child: Text(state.message!),
            );
          }

          // something unexpected
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
