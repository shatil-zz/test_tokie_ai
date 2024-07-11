import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkie_ai/provider_pattern/providers/characters_provider.dart';

class GeneratedImageSelectionWidget extends StatelessWidget {
  const GeneratedImageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Generated Result'),
        centerTitle: true,
      ),
      body: Consumer<CharactersProvider>(
        builder: (context, model, child) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: model.generatedImages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = model.generatedImages[index];
                    final isSelected = imageUrl == model.selectedImageUrl;
                    return GestureDetector(
                      onTap: () => model.selectImage(imageUrl),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? Colors.yellow : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(imageUrl, fit: BoxFit.cover),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.yellow,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  child: Text('Pick'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
