import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  WatchlistRepository
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
