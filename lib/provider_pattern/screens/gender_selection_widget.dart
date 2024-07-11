import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkie_ai/provider_pattern/providers/characters_provider.dart';
import 'package:talkie_ai/provider_pattern/screens/create_image_widget.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key});

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  String _selectedGender = '';

  void _onGenderSelected(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }
  @override
  void initState() {
    super.initState();
    Provider.of<CharactersProvider>(context,listen: false).loginUsingDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGenderOption('assets/male.png', 'Boy', 'Male'),
                _buildGenderOption('assets/female.png', 'Girl', 'Female'),
                _buildGenderOption(
                    'assets/non_binary.png', 'Non-Binary', 'Other'),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width-60,
              height: 40,
              child: ElevatedButton(
                onPressed: _selectedGender.isNotEmpty ? _startAction : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      _selectedGender.isNotEmpty ? Colors.yellow : Colors.grey,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String assetPath, String label, String gender) {
    bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => _onGenderSelected(gender),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.yellow : Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Image.asset(
              assetPath,
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.width / 5,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _startAction() {
    Provider.of<CharactersProvider>(context, listen: false).gender =
        _selectedGender;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateImageWidget()),
    );
  }
}
