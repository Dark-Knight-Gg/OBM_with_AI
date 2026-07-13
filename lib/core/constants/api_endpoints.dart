/// Centralized API endpoints and base URL.
///
/// To switch environments, change [baseUrl] once — all endpoints below will
/// be re-derived from it.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Base URL ─────────────────────────────────────────────────
  // Change this single value to point the whole app at a different server.
  static const String baseUrl = 'http://10.168.6.37:9080';

  // ── Auth ─────────────────────────────────────────────────────
  static const String login = '$baseUrl/api/v1/auth/login';
}