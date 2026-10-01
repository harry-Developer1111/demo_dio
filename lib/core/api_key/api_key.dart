import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey{
  final key=dotenv.env['API_KEY'];
  //static const String apiKey="bf75f771-9841-4ce1-a79e-eb239ae458ed";
}