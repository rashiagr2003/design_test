class ProjectModel {
  final String id;
  final String title;
  final String subject;
  final String author;
  final String grade;
  final String imagePath;

  ProjectModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.author,
    required this.grade,
    required this.imagePath,
  });

  static List<ProjectModel> getStaticProjects() {
    return [
      ProjectModel(
        id: '1',
        title: 'Kemampuan Merangkum Tulisan',
        subject: 'BAHASA SUNDA',
        author: 'Oleh Al-Baiqi Samaan',
        grade: 'A',
        imagePath: 'assets/project1.jpg',
      ),
      ProjectModel(
        id: '2',
        title: 'Kemampuan',
        subject: 'BAHASA SUNDA',
        author: 'Oleh Al-Baiqi Samaan',
        grade: 'A',
        imagePath: 'assets/project2.png',
      ),
      ProjectModel(
        id: '3',
        title: 'Merangkum',
        subject: 'BAHASA SUNDA',
        author: 'Oleh Al-Baiqi Samaan',
        grade: 'A',
        imagePath: 'assets/project3.png',
      ),
      ProjectModel(
        id: '4',
        title: 'Tulisan',
        subject: 'BAHASA SUNDA',
        author: 'Oleh Al-Baiqi Samaan',
        grade: 'A',
        imagePath: 'assets/project4.png',
      ),
      ProjectModel(
        id: '5',
        title: 'Kemampuan Merangkum Tulisan',
        subject: 'BAHASA SUNDA',
        author: 'Oleh Al-Baiqi Samaan',
        grade: 'A',
        imagePath: 'assets/project1.jpg',
      ),
    ];
  }
}
