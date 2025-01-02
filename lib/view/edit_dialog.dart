import 'package:flutter/material.dart';

showEditDialog(
    BuildContext context,
    String title,
    {TextEditingController? imageUrlController,
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
            _buildTextField("Image URL", controller: imageUrlController),
            _buildTextField("Title", controller: titleController),
            _buildTextField("Description", controller: descriptionController),
            _buildTextField("Date",
                controller: dateController,
                inputType: TextInputType.datetime),
            _buildTextField("Topic", controller: topicController),
            _buildTextField("Blog URL", controller: blogUrlController),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                    print("Image URL: ${imageUrlController?.text}");
                    print("Title: ${titleController?.text}");
                    print("Description: ${descriptionController?.text}");
                    print("Date: ${dateController?.text}");
                    print("Topic: ${topicController?.text}");
                    print("Blog URL: ${blogUrlController?.text}");
                    Navigator.pop(context); // Close dialog
                  },
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
  );
}

Widget _buildTextField(
    String label, {
      TextEditingController? controller,
      TextInputType inputType = TextInputType.text,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}
