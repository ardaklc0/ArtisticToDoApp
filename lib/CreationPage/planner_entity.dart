class Planner {
  final int? id;
  final String creationDate;
  final String plannerArtist;

  const Planner({
   this.id,
   required this.creationDate,
   required this.plannerArtist
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creation_date': creationDate,
      'planner_artist': plannerArtist
    };
  }
  @override
  String toString() {
    return 'Planner{id: $id, creation_date: $creationDate, planner_artist: $plannerArtist}';
  }
}