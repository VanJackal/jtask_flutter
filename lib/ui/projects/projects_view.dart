import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/project.dart';
import 'package:jtask_flutter/ui/projects/addProjectDialog.dart';
import 'package:jtask_flutter/ui/projects/projects_viewModel.dart';

class Projects extends StatelessWidget {
  const Projects({super.key, required this.viewModel});
  
  final ProjectsViewModel viewModel;
  
  void _onSelected(String id) {
    viewModel.selected = id;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context,_) {
        return Column(
          children: [
            Row(
              children: [
                Text("Projects"),
                IconButton(
                    onPressed: (){
                      showDialog(
                          context: context, 
                          builder: (BuildContext context) => Dialog(
                            child: AddProjectDialog(viewModel: viewModel)
                          )
                      );
                    }, 
                    icon: Icon(Icons.add)
                )
              ],
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: ProjectItem.from(viewModel.projects,_onSelected, viewModel.selected),
              ),
            )
          ],
        );
      }
    );
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem({super.key, required this.project, required this.onClick, required this.selected});
  final Project project;
  final Function(String) onClick;
  final String selected;
  
  
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(2),
      color: selected == project.id? theme.colorScheme.inversePrimary : Colors.transparent,
      child: Row(
        children: [
          GestureDetector(
            onTap: (){onClick(project.id);},
            child:Text(project.title)
          )
        ],
      ),
    );
  }
  
  static List<ProjectItem> from(List<Project> projects, Function(String) onClick, String selected) {
    return projects.map((p)=> ProjectItem(project: p, onClick: onClick, selected: selected,)).toList();
  }
  
}