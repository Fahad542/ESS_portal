// import 'package:flutter/material.dart';
// import 'package:confetti/confetti.dart';
//
// class BirthdayPopup extends StatefulWidget {
//   @override
//   _BirthdayPopupState createState() => _BirthdayPopupState();
// }
//
// class _BirthdayPopupState extends State<BirthdayPopup>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   final ConfettiController _confettiController =
//   ConfettiController(duration: const Duration(seconds: 2));
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Animation Controller for Popup
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
//     _scaleAnimation =
//         CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
//
//     _controller.forward();
//     _confettiController.play(); // Play confetti animation
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _confettiController.dispose();
//     super.dispose();
//   }
//
//    void showPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => Center(
//         child: ScaleTransition(
//           scale: _scaleAnimation,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               // Popup Background
//               Container(
//                 width: 300,
//                 height: 400,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "🎉 Happy Birthday! 🎂",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       "Wishing you all the joy and happiness\nin the world on your special day!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16, color: Colors.black54),
//                     ),
//                     const SizedBox(height: 32),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text("Close"),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Confetti Animation
//               Positioned.fill(
//                 child: ConfettiWidget(
//                   confettiController: _confettiController,
//                   blastDirectionality: BlastDirectionality.explosive,
//                   shouldLoop: false,
//                   colors: const [Colors.red, Colors.pink, Colors.yellow, Colors.blue],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Happy Birthday Popup")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => showPopup(context),
//           child: const Text("Show Birthday Popup"),
//         ),
//       ),
//     );
//   }
// }
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class PopupHelper {
  static void showPopup(BuildContext context, TickerProvider tickerProvider) {
    // Create Confetti Controller
    final ConfettiController confettiController =
    ConfettiController(duration: const Duration(seconds: 3));

    // Trigger confetti animation
    confettiController.play();

    // Create Animation Controller for Scale
    final AnimationController scaleController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 300),
    );

    final Animation<double> scaleAnimation =
    CurvedAnimation(parent: scaleController, curve: Curves.easeOutBack);

    // Start the scale animation
    scaleController.forward();

    showDialog(
      context: context,
      builder: (context) => Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Popup Background
              Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "🎉 Happy Birthday! 🎂",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Wishing you all the joy and happiness\nin the world on your special day!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        confettiController.stop();
                        scaleController.dispose();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),

              // Confetti Animation
              Positioned.fill(
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [Colors.red, Colors.pink, Colors.yellow, Colors.blue],
                ),
              ),
            ],
          ),
        ),
      ),
    ).then(
            (_) {
           confettiController.dispose();
      scaleController.dispose();
    }
    );
  }
}
