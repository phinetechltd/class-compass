import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';

/// Platform (SaaS) admin dashboard: schools, plans, learners and subscription revenue across
/// every school, instead of one school's figures.
class SaasDashboardWidget extends StatefulWidget {
  const SaasDashboardWidget({super.key});

  @override
  State<SaasDashboardWidget> createState() => _SaasDashboardWidgetState();
}

class _SaasDashboardWidgetState extends State<SaasDashboardWidget> {
  Map<String, dynamic>? _data;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await Get.find<ApiClient>().getData(AppConstants.saasDashboardReport);
    if (!mounted) return;
    setState(() {
      if (res.statusCode == 200 && res.body is Map && res.body['data'] is Map) {
        _data = Map<String, dynamic>.from(res.body['data']);
        _failed = false;
      } else {
        _failed = true;
      }
    });
  }

  num _n(String key) => num.tryParse('${_data?[key] ?? 0}') ?? 0;

  String _money(num v) {
    final s = v.round().toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
    return 'KSh $s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_data == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 120),
        child: Center(child: _failed
            ? Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Could not load platform figures.'),
                const SizedBox(height: 12),
                FilledButton(onPressed: _load, child: const Text('Try again')),
              ])
            : const CircularProgressIndicator()),
      );
    }
    final months = (_data!['transactions'] as List? ?? []).whereType<Map>().toList();
    final plans = (_data!['package_report'] as List? ?? []).whereType<Map>().toList();
    final maxPaid = months.fold<num>(0, (m, e) => (num.tryParse('${e['total_paid']}') ?? 0) > m ? (num.tryParse('${e['total_paid']}') ?? 0) : m);

    final cards = [
      ('Schools', '${_n('total_institutes')}', Icons.apartment_rounded, const Color(0xFF016DF6)),
      ('Active schools', '${_n('total_active_institute')}', Icons.verified_rounded, const Color(0xFF00A86B)),
      ('Inactive schools', '${_n('total_inactive_institute')}', Icons.pause_circle_rounded, const Color(0xFFF59E0B)),
      ('Learners on the platform', '${_n('total_learners')}', Icons.school_rounded, const Color(0xFF7C5CFF)),
      ('New schools this month', '${_n('new_institutes_this_month')}', Icons.add_business_rounded, const Color(0xFF0EA5E9)),
      ('Subscription revenue this year', _money(_n('total_revenue_year')), Icons.payments_rounded, const Color(0xFF043268)),
    ];

    Widget panel(String title, Widget child) => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(18),
              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            child,
          ]),
        );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Platform overview', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text('Every school on Class Compass, their plans and subscription payments.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
        const SizedBox(height: 20),
        LayoutBuilder(builder: (context, box) {
          final cols = box.maxWidth > 1000 ? 3 : box.maxWidth > 560 ? 2 : 1;
          final w = (box.maxWidth - 16 * (cols - 1)) / cols;
          return Wrap(spacing: 16, runSpacing: 16, children: [
            for (final c in cards)
              Container(
                width: w,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: c.$4, borderRadius: BorderRadius.circular(18)),
                child: Row(children: [
                  Container(width: 46, height: 46, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(12)),
                      child: Icon(c.$3, color: Colors.white)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c.$2, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                    Text(c.$1, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13)),
                  ])),
                ]),
              ),
          ]);
        }),
        const SizedBox(height: 20),
        panel('Subscription payments by month (${DateTime.now().year})', SizedBox(
          height: 180,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            for (final m in months)
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Tooltip(
                    message: '${m['month']}: ${_money(num.tryParse('${m['total_paid']}') ?? 0)}',
                    child: Container(
                      height: maxPaid > 0 ? 140 * ((num.tryParse('${m['total_paid']}') ?? 0) / maxPaid).toDouble() + 2 : 2,
                      decoration: BoxDecoration(color: const Color(0xFF016DF6), borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('${m['month']}'.substring(0, 3), style: theme.textTheme.bodySmall),
                ]),
              )),
          ]),
        )),
        const SizedBox(height: 20),
        panel('Schools by plan', plans.isEmpty
            ? Text('No active subscriptions yet.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor))
            : Column(children: [
                for (final p in plans)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(children: [
                      SizedBox(width: 140, child: Text('${p['plan_name']}', style: const TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(6), child: LinearProgressIndicator(
                        value: ((num.tryParse('${p['usage_percent']}') ?? 0) / 100).toDouble(), minHeight: 10,
                        backgroundColor: theme.dividerColor.withValues(alpha: 0.2)))),
                      const SizedBox(width: 12),
                      Text('${p['institute_count']} school${p['institute_count'] == 1 ? '' : 's'}'),
                    ]),
                  ),
              ])),
        const SizedBox(height: 20),
        Wrap(spacing: 12, runSpacing: 12, children: [
          FilledButton.icon(onPressed: () => Get.toNamed(RouteHelper.subscription), icon: const Icon(Icons.workspace_premium_rounded), label: const Text('Schools & subscriptions')),
          OutlinedButton.icon(onPressed: _load, icon: const Icon(Icons.refresh_rounded), label: const Text('Refresh')),
        ]),
      ]),
    );
  }
}
