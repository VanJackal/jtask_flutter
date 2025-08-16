import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/project.dart';
import 'package:jtask_flutter/ui/projects/project_details.dart';
import 'package:jtask_flutter/ui/projects/projects_viewModel.dart';

class EditProjectDialog extends StatefulWidget{
  const EditProjectDialog({super.key, required this.viewModel, required this.initProject});
  
  final ProjectsViewModel viewModel;

  final Project initProject;

  
  @override
  State<EditProjectDialog> createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends State<EditProjectDialog> {
  @override
  Widget build(BuildContext context) {
    var projectDetails = ProjectDetails.of(widget.viewModel, widget.initProject);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            projectDetails,
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  widget.viewModel.updateProject(widget.initProject.id, projectDetails.getProject());
                }, child: Text("Edit")),
                ElevatedButton(onPressed: (){
                  widget.viewModel.deleteProject(widget.initProject.id);
                  Navigator.pop(context);
                }, child: Text("Delete")),
                TextButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text("Cancel")
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}