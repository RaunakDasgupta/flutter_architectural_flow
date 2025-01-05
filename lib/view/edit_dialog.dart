import 'package:flutter/material.dart';

showEditDialog(
    BuildContext context,
    String title,
    {TextEditingController? imageUrlController,
      VoidCallback? onSubmitButtonClick,
      VoidCallback? onCancelButtonClick,
      VoidCallback? onDateSelectionTap,
      TextEditingController? titleController,
      TextEditingController? descriptionController,
      TextEditingController? dateController,
      TextEditingController? topicController,
      TextEditingController? blogUrlController}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField("Banner URL", controller: imageUrlController),
              _buildTextField("Blog Title", controller: titleController),
              _buildTextField("Short Description", controller: descriptionController),
              _buildTextField("Published Date",
                  controller: dateController,
                  onTap: onDateSelectionTap,
                  inputType: TextInputType.datetime),
              _buildTextField("Topic", controller: topicController),
              _buildTextField("Blog URL", controller: blogUrlController),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: onCancelButtonClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(width: 16,),
                  ElevatedButton(
                    onPressed: onSubmitButtonClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Submit", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildTextField(
    String label, {
      TextEditingController? controller,
      VoidCallback? onTap,
      TextInputType inputType = TextInputType.text,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: inputType,
      onTap: onTap,
    //  initialValue: controller?.text ?? "",
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}
