enum ProjectStatus {
  emAndamento(label: 'Em Andamentio'),
  finalizado(label: 'Finalizado');

  final String label;
  const ProjectStatus({required this.label});
}
