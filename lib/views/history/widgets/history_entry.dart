import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playoffs_score_card/collections/score_card.collection.dart';
import 'package:playoffs_score_card/theme.dart';
import 'package:playoffs_score_card/views/history/history_details.view.dart';
import 'package:playoffs_score_card/views/history/provider/history.provider.dart';
import 'package:provider/provider.dart';

class HistoryEntry extends StatelessWidget {
  final ScoreCard score;

  const HistoryEntry({required this.score, Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final date = DateFormat("d MMMM yyyy").format(score.date);

    return InkWell(
      onTap: () => _showMaterialDialog(context),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.paddingDefault),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Text(
              "${score.totalScore} / 1000",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: AppTheme.paddingDefault),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog(BuildContext context) {
    final date = DateFormat("d MMMM yyyy").format(score.date);
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) {
        return ChangeNotifierProvider<HistoryProvider>.value(
          value: context.read<HistoryProvider>(),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            scrollable: true,
            title: Text("Score Details: $date"),
            content: SizedBox(
              child: HistoryDetailsView(score: score),
            ),
          ),
        );
      },
    );
  }
}
