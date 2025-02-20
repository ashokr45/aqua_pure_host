//
//
// import 'package:flutter/material.dart';
//
// import '../utils/constants/colors.dart';
//
// class QDataContainer extends StatelessWidget {
//   final String? title1;
//   final String heading;
//   final String? title2;
//   final String? title3;
//   final String? title4;
//   final String? title5;
//   final String? title6;
//   final String? title7;
//   final String? title8;
//   final String? title9;
//   final String? title10;
//   final String? title11;
//   final String? title12;
//   final String? title13;
//   final String? title14;
//
//   const QDataContainer({
//     super.key,
//     this.title1,
//     this.title2,
//     this.title3,
//     this.title4,
//     this.title5,
//     this.title6,
//     this.title7,
//     this.title8,
//     this.title9,
//     this.title10,
//     this.title11,
//     this.title12,
//     required this.heading, this.title13, this.title14,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Determine if the screen width is large (indicating desktop)
//     bool isDesktop = MediaQuery.of(context).size.width > 600; // Adjust the breakpoint as needed
//
//     // List of all titles
//     List<String?> titles = [
//       title1,
//       title2,
//       title3,
//       title4,
//       title5,
//       title6,
//       title7,
//       title8,
//       title9,
//       title10,
//       title11,
//       title12,
//       title13,
//       title14,
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Heading
//         Container(
//           height: 40,
//           width: double.infinity,
//           decoration: BoxDecoration(color: TColors.appBarColor),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//             child: Text(
//               heading,
//               style: TextStyle(
//                 color: TColors.textWhite,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//
//         // Data container with rows conditionally shown based on non-null titles
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: isDesktop
//                 ? TColors.textWhite // Use your desired color for desktop
//                 : TColors.appBarColor.withOpacity(0.3),
//           ),
//           // child: Column(
//           //   children: [
//           //     for (int i = 0; i < titles.length; i += 2)
//           //       if (titles[i] != null || (i + 1 < titles.length && titles[i + 1] != null))
//           //         _buildDataRow(
//           //           titles[i],
//           //           i + 1 < titles.length ? titles[i + 1] : null,
//           //         ),
//           //   ],
//           // ),
//           child: Column(
//             children: [
//               for (int i = 0; i < titles.length - 1; i += 2)
//                 if (titles[i] != null || (i + 1 < titles.length && titles[i + 1] != null))
//                   _buildDataRow(
//                     titles[i],
//                     i + 1 < titles.length ? titles[i + 1] : null,
//                   ),
//
//               // Handle the last remaining title if the number of titles is odd
//               if (titles.length % 2 != 0 && titles.last != null)
//                 _buildSingleDataRow(titles.last),
//             ],
//           ),
//
//         ),
//       ],
//     );
//   }
//
//   // Method to build a row for each pair of titles
//   Widget _buildDataRow(String? titleLeft, String? titleRight) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Left title
//           Expanded(child: Text(titleLeft ?? '')),
//
//           // Left container
//           SizedBox(width: 5),
//           Container(
//             height: 25,
//             width: 100,
//             decoration: BoxDecoration(
//               border: Border.all(),
//               color: TColors.inactiveBtn,
//             ),
//           ),
//
//           // Spacing
//           if (titleRight != null) SizedBox(width: 30),
//
//           // Right title
//           Expanded(
//             child: titleRight != null
//                 ? Text(titleRight)
//                 : const SizedBox(), // Empty placeholder to maintain alignment
//           ),
//
//           // Right container (only if titleRight is not null)
//           if (titleRight != null)
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Container(
//                 height: 25,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   color: TColors.inactiveBtn,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSingleDataRow(String? title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Left title
//           Expanded(child: Text(title ?? '')),
//
//           // Left container
//           SizedBox(width: 5),
//           Container(
//             height: 25,
//             width: 100,
//             decoration: BoxDecoration(
//               border: Border.all(),
//               color: TColors.inactiveBtn,
//             ),
//           ),
//
//
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Container(
//               height: 25,
//               width: 100,
//               decoration: BoxDecoration(
//                 border: Border.all(),
//                 color: Colors.transparent, // Transparent to maintain spacing
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }


import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class QDataContainer extends StatelessWidget {
  final String? title1;
  final String heading;
  final String? title2;
  final String? title3;
  final String? title4;
  final String? title5;
  final String? title6;
  final String? title7;
  final String? title8;
  final String? title9;
  final String? title10;
  final String? title11;
  final String? title12;
  final String? title13;
  final String? title14;

  const QDataContainer({
    super.key,
    this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.title6,
    this.title7,
    this.title8,
    this.title9,
    this.title10,
    this.title11,
    this.title12,
    required this.heading, this.title13, this.title14,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the screen width is large (indicating desktop)
    bool isDesktop = MediaQuery.of(context).size.width > 600; // Adjust the breakpoint as needed

    // List of all titles
    List<String?> titles = [
      title1,
      title2,
      title3,
      title4,
      title5,
      title6,
      title7,
      title8,
      title9,
      title10,
      title11,
      title12,
      title13,
      title14,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(color: TColors.appBarColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              heading,
              style: TextStyle(
                color: TColors.textWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Data container with rows conditionally shown based on non-null titles
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDesktop
                ? TColors.textWhite // Use your desired color for desktop
                : TColors.appBarColor.withOpacity(0.3),
          ),
          child: Column(
            children: [
              for (int i = 0; i < titles.length - 1; i += 2)
                if (titles[i] != null || (i + 1 < titles.length && titles[i + 1] != null))
                  _buildDataRow(
                    titles[i],
                    i + 1 < titles.length ? titles[i + 1] : null,
                  ),

              // Handle the last remaining title if the number of titles is odd
              if (titles.length % 2 != 0 && titles.last != null)
                _buildSingleDataRow(titles.last),
            ],
          ),
        ),
      ],
    );
  }

  // Method to build a row for each pair of titles
  Widget _buildDataRow(String? titleLeft, String? titleRight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left title
          Expanded(child: Text(titleLeft ?? '')),

          // Left container
          SizedBox(width: 5),
          Container(
            height: 25,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(),
              color: TColors.inactiveBtn,
            ),
          ),

          // Spacing
          if (titleRight != null) SizedBox(width: 30),

          // Right title
          Expanded(
            child: titleRight != null
                ? Text(titleRight)
                : const SizedBox(), // Empty placeholder to maintain alignment
          ),

          // Right container (only if titleRight is not null)
          if (titleRight != null)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                height: 25,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: TColors.inactiveBtn,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Method to build a single data row for an odd title
  Widget _buildSingleDataRow(String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left title
          Expanded(child: Text(title ?? '')),

          // Left container
          SizedBox(width: 5),
          Container(
            height: 25,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(),
              color: TColors.inactiveBtn,
            ),
          ),

          // Right container (set to transparent if it's the last item)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 25,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.transparent, // Transparent to maintain spacing
              ),
            ),
          ),
        ],
      ),
    );
  }
}
