class CastMember {
  final String name;
  final String imagePath;

  CastMember({required this.name, required this.imagePath});
   Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': imagePath,
    };
  }

  factory CastMember.fromMap(Map<String, dynamic> map) {
    return CastMember(
      name: map['name'] ?? '',
      imagePath: map['image'] ?? '',
    );
  }
} 