// Openapi Generator last run: : 2024-12-01T04:06:12.885721
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

const remoteSpecUrl = 'http://localhost:3000/api-docs-json';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'solar_monitor_api',
  ),
  inputSpec: RemoteSpec(path: remoteSpecUrl),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'packages/solar_monitor_api',
)
class ApiGenDio {}
