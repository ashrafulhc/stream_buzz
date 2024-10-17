import 'package:flutter/material.dart';
import 'package:stream_buzz/feature/home/presentation/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getExampleFileStatus.listen((event) {
      if (event == Status.loading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showCustomDialog(context);
        });
      } else if (event != null && event != Status.loading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.downloadExampleFile();
                },
                child: const Text('Download Example.file'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: const SizedBox(
          width: 300, // Custom width
          height: 300, // Custom height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Loading', style: TextStyle(fontSize: 18)),
              LinearProgressIndicator(),
            ],
          ),
        ),
      );
    },
  );
}
