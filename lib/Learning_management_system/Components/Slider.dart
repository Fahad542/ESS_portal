import 'package:flutter/material.dart';



class SliderWithDots extends StatefulWidget {
  @override
  _SliderWithDotsState createState() => _SliderWithDotsState();
}

class _SliderWithDotsState extends State<SliderWithDots> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _buildPage(color: Colors.red, text: 'Page 1', imageUrl: 'assets/images/img1.jpg'),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildPage(color: Colors.green, text: 'Page 2', imageUrl: 'assets/images/img3.jpg'),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildPage(color: Colors.blue, text: 'Page 3', imageUrl: 'assets/images/img1.jpg'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            _buildDotsIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({required Color color, required String text, required String imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),

      ),
      child: Stack(
        children: [
          // Display the image as a background
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover, // Adjust the image fit as needed
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  color: Colors.grey, // Fallback color in case of an error
                  child: Center(child: Text('Image failed to load')), // Error message
                );
              },
            ),
          ),

        ],
      ),
    );
  }


  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.black : Colors.grey,
          ),
        );
      }),
    );
  }
}
