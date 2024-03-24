import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String user_id;
  final String name;
  final String email;

  const MyUser({
    required this.user_id,
    required this.name,
    required this.email,
  });

  static const empty = MyUser(user_id: '', name: '', email: '');

  MyUser copyWith({
    String? user_id,
    String? name,
    String? email,
  }) {
    return MyUser(
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(user_id: user_id, name: name, email: email);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(user_id: entity.user_id, name: entity.name, email: entity.email);
  }

  @override
  List<Object?> get props => [user_id, email, name];
}
