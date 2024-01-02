import 'package:flutter/material.dart';
import 'package:sps_mobile/widgets/on_boarding_page.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  int currentPage = 0;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: const [
              OnboardingPage(
                  title: 'Sauver trois vies avec un don',
                  description:
                      'Chaque don de votre part peut aider jusqu\'à trois personnes.',
                  image: 'assets/images/img1.png'),
              OnboardingPage(
                  title: 'Devenez un donneur',
                  description:
                      'Rejoignez les donneurs pour aider à sauver des vies.',
                  image: 'assets/images/img2.png'),
              OnboardingPage(
                  title: 'Planifiez votre don',
                  description:
                      'Planifiez votre prochain acte de générosité en suivant des étapes simples.',
                  image: 'assets/images/img3.png'),
            ],
          ),
          Positioned(
            bottom: 40.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16.0),
                        backgroundColor: Colors.red),
                    onPressed: () {
                      if (currentPage > 0) {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                const SizedBox(width: 30),
                Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              currentPage == index ? Colors.red : Colors.grey,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 30),
                currentPage < 2
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: Colors.red, // Couleur du bouton
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (currentPage < 2) {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      )
                    : TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Débuter',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
