import 'package:stash_app_flutter/core/utils/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stash_app_flutter/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'bottom_sheet_panel_chrome.dart';

/// A bottom sheet that allows the user to set a rating (0-5 stars).
class RatingBottomSheet extends StatelessWidget {
  /// The current rating (0-100).
  final int initialRating;

  /// The title of the bottom sheet.
  final String title;

  /// Optional subtitle shown below the title in the details layout.
  final String? subtitle;

  /// Callback when a rating is selected (0-100).
  final ValueChanged<int> onRatingSelected;

  final Widget? detailsWidget;

  const RatingBottomSheet({
    required this.initialRating,
    required this.onRatingSelected,
    required this.title,
    this.subtitle,
    this.detailsWidget,
    super.key,
  });

  /// Shows the rating bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required int initialRating,
    required ValueChanged<int> onRatingSelected,
    String? title,
    String? subtitle,
    Widget? detailsWidget,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final sheet = RatingBottomSheet(
      initialRating: initialRating,
      onRatingSelected: onRatingSelected,
      title: title ?? l10n.common_rate,
      subtitle: subtitle,
      detailsWidget: detailsWidget,
    );
    if (detailsWidget != null) {
      return showFrostedPanelBottomSheet<void>(
        context: context,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.88,
        ),
        builder: (_) => sheet,
      );
    }
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => sheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dims = context.dimensions;
    if (detailsWidget != null) {
      return SafeArea(
        top: false,
        child: FrostedPanel(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusExtraLarge),
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(dims.spacingLarge),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (subtitle != null) ...[
                          SizedBox(height: dims.spacingSmall),
                          Text(
                            subtitle!,
                            style: context.textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    tooltip: l10n.common_close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: dims.spacingMedium),
              ..._buildRatingControls(context, dims, l10n),
              SizedBox(height: dims.spacingMedium),
              detailsWidget!,
            ],
          ),
        ),
      );
    }
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: dims.spacingLarge,
          horizontal: dims.spacingMedium,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildContent(context, dims, l10n),
        ),
      ),
    );
  }

  List<Widget> _buildContent(
    BuildContext context,
    AppDimensions dims,
    AppLocalizations l10n,
  ) {
    return [
      Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(height: dims.spacingLarge),
      ..._buildRatingControls(context, dims, l10n),
    ];
  }

  List<Widget> _buildRatingControls(
    BuildContext context,
    AppDimensions dims,
    AppLocalizations l10n,
  ) {
    return [
      Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(5, (index) {
          final starValue = (index + 1) * 20;
          final isSelected = initialRating >= starValue;
          return IconButton(
            tooltip: context.l10n.common_star,
            icon: Icon(
              isSelected ? Icons.star : Icons.star_border,
              size: 48 * dims.fontSizeFactor,
              color: Colors.amber,
            ),
            onPressed: () {
              onRatingSelected(starValue);
              Navigator.pop(context);
            },
          );
        }),
      ),
      SizedBox(height: dims.spacingMedium),
      TextButton(
        onPressed: () {
          onRatingSelected(0);
          Navigator.pop(context);
        },
        child: Text(l10n.common_clear_rating),
      ),
    ];
  }
}
