import 'package:flutter/material.dart';
import '../constant.dart';

class CurrentWeatherItem extends StatelessWidget {
  const CurrentWeatherItem({
    Key? key,
    required this.icon,
    this.description,
    required this.title,
    required this.specification,
  }) : super(key: key);
  final String specification;
  final IconData icon;
  final String title;
  final String? description;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('current item rebuild');
    return Card(
      color: cardBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 15,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                specification,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 32, fontWeight: FontWeight.w400),
              ),
            ),
            if (description != null)
              SizedBox(
                // color: Colors.cyan,
                height: size.height * 0.06,
                width: double.maxFinite,
                child: Text(
                  description!,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
