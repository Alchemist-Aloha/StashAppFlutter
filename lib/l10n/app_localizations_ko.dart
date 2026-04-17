// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'StashFlow';

  @override
  String get nav_scenes => '장면';

  @override
  String get nav_performers => '출연자';

  @override
  String get nav_studios => '스튜디오';

  @override
  String get nav_tags => '태그';

  @override
  String get nav_galleries => '갤러리';

  @override
  String nScenes(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString개의 장면',
      zero: '장면 없음',
    );
    return '$_temp0';
  }

  @override
  String nPerformers(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString명의 출연자',
      zero: '출연자 없음',
    );
    return '$_temp0';
  }

  @override
  String get common_reset => '초기화';

  @override
  String get common_apply => '적용';

  @override
  String get common_save_default => '기본값으로 저장';

  @override
  String get common_sort_method => '정렬 방식';

  @override
  String get common_direction => '방향';

  @override
  String get common_ascending => '오름차순';

  @override
  String get common_descending => '내림차순';

  @override
  String get common_favorites_only => '즐겨찾기만';

  @override
  String get common_apply_sort => '정렬 적용';

  @override
  String get common_apply_filters => '필터 적용';

  @override
  String get common_view_all => '전체 보기';

  @override
  String get common_default => 'Default';

  @override
  String get common_later => '나중에';

  @override
  String get common_update_now => '지금 업데이트';

  @override
  String get common_configure_now => '지금 설정';

  @override
  String get common_clear_rating => '평점 지우기';

  @override
  String get common_no_media => '미디어가 없습니다';

  @override
  String get common_setup_required => '설정이 필요합니다';

  @override
  String get common_update_available => '업데이트 가능';

  @override
  String get details_studio => '스튜디오 상세';

  @override
  String get details_performer => '출연자 상세';

  @override
  String get details_tag => '태그 상세';

  @override
  String get details_scene => '장면 상세';

  @override
  String get details_gallery => '갤러리 상세';

  @override
  String get studios_filter_title => '스튜디오 필터';

  @override
  String get studios_filter_saved => '필터 설정이 기본값으로 저장되었습니다';

  @override
  String get sort_name => '이름';

  @override
  String get sort_scene_count => '장면 수';

  @override
  String get sort_rating => '평점';

  @override
  String get sort_updated_at => '업데이트 날짜';

  @override
  String get sort_created_at => '생성 날짜';

  @override
  String get sort_random => '랜덤';

  @override
  String get studios_sort_saved => '정렬 설정이 기본값으로 저장되었습니다';

  @override
  String get studios_no_random => '랜덤 탐색에 사용할 수 있는 스튜디오가 없습니다';

  @override
  String get tags_filter_title => '태그 필터';

  @override
  String get tags_filter_saved => '필터 설정이 기본값으로 저장되었습니다';

  @override
  String get tags_sort_saved => '정렬 설정이 기본값으로 저장되었습니다';

  @override
  String get tags_no_random => '랜덤 탐색에 사용할 수 있는 태그가 없습니다';

  @override
  String get scenes_no_random => '랜덤 탐색에 사용할 수 있는 장면이 없습니다';

  @override
  String get performers_no_random => '랜덤 탐색에 사용할 수 있는 출연자가 없습니다';

  @override
  String get galleries_no_random => '랜덤 탐색에 사용할 수 있는 갤러리가 없습니다';

  @override
  String common_error(String message) {
    return '오류: $message';
  }

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_customize => 'Customize StashFlow';

  @override
  String get settings_customize_subtitle =>
      'Tune playback, appearance, layout, and support tools from one place.';

  @override
  String get settings_core_section => 'Core settings';

  @override
  String get settings_core_subtitle => 'Most-used configuration pages';

  @override
  String get settings_server => 'Server';

  @override
  String get settings_server_subtitle => 'Connection and API configuration';

  @override
  String get settings_playback => 'Playback';

  @override
  String get settings_playback_subtitle => 'Player behavior and interactions';

  @override
  String get settings_keyboard => 'Keyboard';

  @override
  String get settings_keyboard_subtitle => 'Customizable shortcuts and hotkeys';

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_appearance_subtitle => 'Theme and colors';

  @override
  String get settings_interface => 'Interface';

  @override
  String get settings_interface_subtitle => 'Navigation and layout defaults';

  @override
  String get settings_support => 'Support';

  @override
  String get settings_support_subtitle => 'Diagnostics and about';

  @override
  String get settings_develop => 'Develop';

  @override
  String get settings_develop_subtitle => 'Advanced tools and overrides';

  @override
  String get settings_appearance_title => 'Appearance Settings';

  @override
  String get settings_appearance_theme_mode => 'Theme Mode';

  @override
  String get settings_appearance_theme_mode_subtitle =>
      'Choose how the app follows brightness changes';

  @override
  String get settings_appearance_theme_system => 'System';

  @override
  String get settings_appearance_theme_light => 'Light';

  @override
  String get settings_appearance_theme_dark => 'Dark';

  @override
  String get settings_appearance_primary_color => 'Primary Color';

  @override
  String get settings_appearance_primary_color_subtitle =>
      'Pick a seed color for the Material 3 palette';

  @override
  String get settings_appearance_advanced_theming => 'Advanced Theming';

  @override
  String get settings_appearance_advanced_theming_subtitle =>
      'Optimizations for specific screen types';

  @override
  String get settings_appearance_true_black => 'True Black (AMOLED)';

  @override
  String get settings_appearance_true_black_subtitle =>
      'Use pure black backgrounds in dark mode to save battery on OLED screens';

  @override
  String get settings_appearance_custom_hex => 'Custom Hex Color';

  @override
  String get settings_appearance_custom_hex_helper =>
      'Enter an 8-digit ARGB hex code';

  @override
  String get settings_interface_title => 'Interface Settings';

  @override
  String get settings_interface_language => 'Language';

  @override
  String get settings_interface_language_subtitle =>
      'Overwrite the default system language';

  @override
  String get settings_interface_app_language => 'App Language';

  @override
  String get settings_interface_navigation => 'Navigation';

  @override
  String get settings_interface_navigation_subtitle =>
      'Visibility of global navigation shortcuts';

  @override
  String get settings_interface_show_random => 'Show Random Navigation Buttons';

  @override
  String get settings_interface_show_random_subtitle =>
      'Enable or disable the floating casino buttons across list and details pages';

  @override
  String get settings_interface_shake_random => 'Shake to Discover';

  @override
  String get settings_interface_shake_random_subtitle =>
      'Shake your device to jump to a random item in the current tab';

  @override
  String get settings_interface_show_edit => 'Show Edit Button';

  @override
  String get settings_interface_show_edit_subtitle =>
      'Enable or disable the edit button on the scene details page';

  @override
  String get settings_interface_customize_tabs => 'Customize Tabs';

  @override
  String get settings_interface_customize_tabs_subtitle =>
      'Reorder or hide navigation menu items';

  @override
  String get settings_interface_scenes_layout => 'Scenes Layout';

  @override
  String get settings_interface_scenes_layout_subtitle =>
      'Default browsing mode for scenes';

  @override
  String get settings_interface_galleries_layout => 'Galleries Layout';

  @override
  String get settings_interface_galleries_layout_subtitle =>
      'Default browsing mode for galleries';

  @override
  String get settings_interface_layout_default => 'Default Layout';

  @override
  String get settings_interface_layout_default_desc =>
      'Choose the default layout for the page';

  @override
  String get settings_interface_layout_list => 'List';

  @override
  String get settings_interface_layout_grid => 'Grid';

  @override
  String get settings_interface_layout_tiktok => 'Infinite Scroll';

  @override
  String get settings_interface_grid_columns => 'Grid Columns';

  @override
  String get settings_interface_image_viewer => 'Image Viewer';

  @override
  String get settings_interface_image_viewer_subtitle =>
      'Configure fullscreen image browsing behavior';

  @override
  String get settings_interface_swipe_direction => 'Fullscreen Swipe Direction';

  @override
  String get settings_interface_swipe_direction_desc =>
      'Choose how images advance in fullscreen mode';

  @override
  String get settings_interface_swipe_vertical => 'Vertical';

  @override
  String get settings_interface_swipe_horizontal => 'Horizontal';

  @override
  String get settings_interface_waterfall_columns => 'Waterfall Grid Columns';

  @override
  String get settings_interface_performer_layouts => 'Performer Layouts';

  @override
  String get settings_interface_performer_layouts_subtitle =>
      'Media and gallery defaults for performers';

  @override
  String get settings_interface_studio_layouts => 'Studio Layouts';

  @override
  String get settings_interface_studio_layouts_subtitle =>
      'Media and gallery defaults for studios';

  @override
  String get settings_interface_tag_layouts => 'Tag Layouts';

  @override
  String get settings_interface_tag_layouts_subtitle =>
      'Media and gallery defaults for tags';

  @override
  String get settings_interface_media_layout => 'Media Layout';

  @override
  String get settings_interface_media_layout_subtitle =>
      'Layout for Media page';

  @override
  String get settings_interface_galleries_layout_item => 'Galleries Layout';

  @override
  String get settings_interface_galleries_layout_subtitle_item =>
      'Layout for Galleries page';

  @override
  String get settings_server_title => 'Server Settings';

  @override
  String get settings_server_status => 'Connection Status';

  @override
  String get settings_server_status_subtitle =>
      'Live connectivity against the configured server';

  @override
  String get settings_server_details => 'Server Details';

  @override
  String get settings_server_details_subtitle =>
      'Configure endpoint and authentication method';

  @override
  String get settings_server_url => 'GraphQL server URL';

  @override
  String get settings_server_url_helper =>
      'Example format: http(s)://host:port/graphql.';

  @override
  String get settings_server_auth_method => 'Authentication Method';

  @override
  String get settings_server_auth_apikey => 'API Key';

  @override
  String get settings_server_auth_password => 'Username + Password';

  @override
  String get settings_server_auth_password_desc =>
      'Recommended: use your Stash username/password session.';

  @override
  String get settings_server_auth_apikey_desc =>
      'Use API key for static-token authentication.';

  @override
  String get settings_server_username => 'Username';

  @override
  String get settings_server_password => 'Password';

  @override
  String get settings_server_login_test => 'Login & Test';

  @override
  String get settings_server_test => 'Test Connection';

  @override
  String get settings_server_logout => 'Logout';

  @override
  String get settings_server_clear => 'Clear Settings';

  @override
  String settings_server_connected(String version) {
    return 'Connected (Stash $version)';
  }

  @override
  String get settings_server_checking => 'Checking connection...';

  @override
  String settings_server_failed(String error) {
    return 'Failed: $error';
  }

  @override
  String get settings_server_invalid_url => 'Invalid server URL';

  @override
  String get settings_server_resolve_error =>
      'Could not resolve server URL. Check host, port, and credentials.';

  @override
  String get settings_server_logout_confirm =>
      'Logged out and cookies cleared.';

  @override
  String get settings_playback_title => 'Playback Settings';

  @override
  String get settings_playback_behavior => 'Playback behavior';

  @override
  String get settings_playback_behavior_subtitle =>
      'Default playback and background handling';

  @override
  String get settings_playback_prefer_streams => 'Prefer sceneStreams first';

  @override
  String get settings_playback_prefer_streams_subtitle =>
      'When off, playback directly uses paths.stream';

  @override
  String get settings_playback_autoplay => 'Autoplay Next Scene';

  @override
  String get settings_playback_autoplay_subtitle =>
      'Automatically play the next scene when current playback ends';

  @override
  String get settings_playback_background => 'Background Playback';

  @override
  String get settings_playback_background_subtitle =>
      'Keep video audio playing when app is backgrounded';

  @override
  String get settings_playback_pip => 'Native Picture-in-Picture';

  @override
  String get settings_playback_pip_subtitle =>
      'Enable Android PiP button and auto-enter on background';

  @override
  String get settings_playback_subtitles => 'Subtitle settings';

  @override
  String get settings_playback_subtitles_subtitle =>
      'Automatic loading and appearance';

  @override
  String get settings_playback_subtitle_lang => 'Default Subtitle Language';

  @override
  String get settings_playback_subtitle_lang_subtitle =>
      'Auto-load if available';

  @override
  String get settings_playback_subtitle_size => 'Subtitle Font Size';

  @override
  String get settings_playback_subtitle_pos => 'Subtitle Vertical Position';

  @override
  String settings_playback_subtitle_pos_desc(String percent) {
    return '$percent% from bottom';
  }

  @override
  String get settings_playback_subtitle_align => 'Subtitle Text Alignment';

  @override
  String get settings_playback_subtitle_align_subtitle =>
      'Alignment for multiline subtitles';

  @override
  String get settings_playback_seek => 'Seek interaction';

  @override
  String get settings_playback_seek_subtitle =>
      'Choose how scrubbing works during playback';

  @override
  String get settings_playback_seek_double_tap =>
      'Double-tap left/right to seek 10s';

  @override
  String get settings_playback_seek_drag => 'Drag the timeline to seek';

  @override
  String get settings_playback_seek_drag_label => 'Drag';

  @override
  String get settings_playback_seek_double_tap_label => 'Double-tap';

  @override
  String get settings_support_title => 'Support';

  @override
  String get settings_support_diagnostics => 'Diagnostics and project info';

  @override
  String get settings_support_diagnostics_subtitle =>
      'Open runtime logs or jump to the repository when you need help.';

  @override
  String get settings_support_update_available => 'Update Available';

  @override
  String get settings_support_update_available_subtitle =>
      'A newer version is available on GitHub';

  @override
  String settings_support_update_to(String version) {
    return 'Update to $version';
  }

  @override
  String get settings_support_update_to_subtitle =>
      'New features and improvements are waiting for you.';

  @override
  String get settings_support_about => 'About';

  @override
  String get settings_support_about_subtitle =>
      'Project and source information';

  @override
  String get settings_support_version => 'Version';

  @override
  String get settings_support_version_loading => 'Loading version info...';

  @override
  String get settings_support_version_unavailable => 'Version info unavailable';

  @override
  String get settings_support_github => 'GitHub Repository';

  @override
  String get settings_support_github_subtitle =>
      'View source code and report issues';

  @override
  String get settings_support_github_error => 'Could not open GitHub link';

  @override
  String get settings_develop_title => 'Develop';

  @override
  String get settings_develop_diagnostics => 'Diagnostic Tools';

  @override
  String get settings_develop_diagnostics_subtitle =>
      'Troubleshooting and performance';

  @override
  String get settings_develop_video_debug => 'Show Video Debug Info';

  @override
  String get settings_develop_video_debug_subtitle =>
      'Display technical playback details as an overlay on the video player.';

  @override
  String get settings_develop_log_viewer => 'Debug Log Viewer';

  @override
  String get settings_develop_log_viewer_subtitle =>
      'Open a live view of in-app logs.';

  @override
  String get settings_develop_web_overrides => 'Web Overrides';

  @override
  String get settings_develop_web_overrides_subtitle =>
      'Advanced flags for web platform';

  @override
  String get settings_develop_web_auth => 'Allow Password Login on Web';

  @override
  String get settings_develop_web_auth_subtitle =>
      'Overrides the native-only restriction and forces the Username + Password auth method to be visible on Flutter Web.';
}
