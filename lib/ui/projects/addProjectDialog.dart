import 'package:flutter/material.dart';
import 'package:jtask_flutter/ui/projects/project_details.dart';
import 'package:jtask_flutter/ui/projects/projects_viewModel.dart';

class AddProjectDialog extends StatefulWidget{
  const AddProjectDialog({super.key, required this.viewModel});
  
  final ProjectsViewModel viewModel;

  
  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  @override
  Widget build(BuildContext context) {
    var projectDetails = ProjectDetails.of(widget.viewModel);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            projectDetails,
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  widget.viewModel.addProject(projectDetails.getProject());
                }, child: Text("Add")),
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