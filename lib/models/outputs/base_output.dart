class BaseOutput {
  final int code;
  final String message;

  BaseOutput({required this.code, required this.message});

  @override
  String toString() {
    return 'BaseOutput{code: $code, message: $message}';
  }
  
}
