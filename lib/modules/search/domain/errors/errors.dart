abstract class FailureSearch implements Exception {}

class InvalidTextError extends FailureSearch {}

class DataSourceError extends FailureSearch {}
