import 'package:iommy/errors/repository_error.dart';
import 'package:talker/talker.dart';

abstract class Repository {
  final Talker logger;

  const Repository({
    required this.logger,
  });

  Future<T> safeCode<T>(Future<T> Function() block) async {
    try {
      return await block();
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace);

      if (error is RepositoryError) {
        rethrow;
      }

      throw RepositoryError(error);
    }
  }
}

extension RepositoryStream<T> on Stream<T> {
  Stream<T> safeCode() => handleError(
        (error) {
      if (error is RepositoryError) {
        throw error;
      }

      throw RepositoryError(error);
    },
  );
}
