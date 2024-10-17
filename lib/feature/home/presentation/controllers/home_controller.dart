import 'package:rxdart/rxdart.dart';

class HomeController {
  final _exampleFileStatus = BehaviorSubject<Status?>();
  Stream<Status?> get getExampleFileStatus => _exampleFileStatus.stream;

  Future<void> downloadExampleFile() async {
    _exampleFileStatus.sink.add(Status.loading);
    await Future.delayed(const Duration(seconds: 1));
    _exampleFileStatus.sink.add(Status.success);
  }

  void dispose() {
    /// Dispose all the streams here
    _exampleFileStatus.close();
  }
}

enum Status { initial, loading, success, failed }