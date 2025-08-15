import 'package:flutter/material.dart';
import 'package:jtask_flutter/ui/projects/projects_viewModel.dart';

class AddProjectDialog extends StatefulWidget{
  const AddProjectDialog({super.key, required this.viewModel, required this.submitText});
  
  final ProjectsViewModel viewModel;

  final String submitText;

  
  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  String title = "";
  
  void _addProjectButton() {
    widget.viewModel.addProject(title);
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              initialValue: title,
              decoration: InputDecoration(
                labelText: "Title"
              ),
              onChanged: (val) => {
                title = val
              },
            ),
            Row(
              children: [
                ElevatedButton(onPressed: _addProjectButton, child: Text(widget.submitText)),
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