
import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/project.dart';
import 'package:jtask_flutter/ui/projects/projects_viewModel.dart';

class ProjectDetails extends StatelessWidget {
  final ProjectState projectState;
  final ProjectsViewModel viewModel;
  
  const ProjectDetails({super.key, required this.projectState, required this.viewModel});
  
  static ProjectDetails of(ProjectsViewModel viewModel, [Project? projectInit]){
    return ProjectDetails(projectState: ProjectState(projectInit), viewModel: viewModel);
  }
  
  Project getProject() {
    return projectState.toProject();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: projectState.title,
          decoration: InputDecoration(
              labelText: "Title"
          ),
          onChanged: (val) => {
            projectState.title = val
          },
        ),
      ],
    );
  }
  
}

class ProjectState {
  ProjectState(Project? init) {
    id = init?.id ?? "";
    title = init?.title ?? "";
  }
  
  Project toProject(){
    return (id:id, title:title);
  }
  
  late String id;
  late String title;
}