#!/usr/bin/env python3
"""Add missing translation keys to StashFlow locale ARB files.

Adds the 15 settings_keyboard_* keys (after the last existing settings_keyboard_*
key, matching app_en.arb ordering) and the 13 settings_config_* keys (at the end
of the file) for every locale that is missing them.
"""
import json
from pathlib import Path

root = Path(__file__).resolve().parent.parent
l10n_dir = root / 'lib' / 'l10n'

EN_ORDER = list(json.loads((l10n_dir / 'app_en.arb').read_text(encoding='utf-8')).keys())

# ---------------------------------------------------------------------------
# Translations: locale -> key -> value
# ---------------------------------------------------------------------------
T = {
    'de': {
        "settings_keyboard_global_section": "Globale Navigation",
        "settings_keyboard_video_section": "Videoplayer",
        "settings_keyboard_image_section": "Bildbetrachter",
        "settings_keyboard_next_tab": "Nächster Tab",
        "settings_keyboard_previous_tab": "Vorheriger Tab",
        "settings_keyboard_tab_number": "Tab {number}",
        "settings_keyboard_first_image": "Erstes Bild",
        "settings_keyboard_last_image": "Letztes Bild",
        "settings_keyboard_close_image": "Bildbetrachter schließen",
        "settings_keyboard_unbind": "Verknüpfung aufheben",
        "settings_keyboard_reset_confirm_title": "Tastaturkürzel zurücksetzen?",
        "settings_keyboard_reset_confirm_body": "Alle benutzerdefinierten Tastaturkürzel werden durch die Standardeinstellungen ersetzt.",
        "settings_keyboard_reserved": "Diese Verknüpfung ist vom Browser oder Betriebssystem reserviert.",
        "settings_keyboard_tab_reserved": "Die Tab-Taste ist für die Tastaturnavigation reserviert.",
        "settings_keyboard_conflict_moved": "Verknüpfung verschoben von {action}.",
        "settings_config_backup_title": "App-Konfiguration",
        "settings_config_backup_subtitle": "Benutzersichtbare Einstellungen und Serverprofile speichern oder ersetzen",
        "settings_config_export": "Konfiguration speichern",
        "settings_config_import": "Konfiguration importieren",
        "settings_config_include_credentials": "Anmeldedaten unverschlüsselt einschließen",
        "settings_config_credentials_warning": "Jeder, der diese Datei besitzt, kann Ihre Server-Anmeldedaten und den App-Sperrcode lesen.",
        "settings_config_exported": "Konfiguration gespeichert",
        "settings_config_import_title": "App-Konfiguration ersetzen?",
        "settings_config_import_summary": "Diese Datei enthält {profileCount} Serverprofile. Beim Import werden alle aktuellen benutzersichtbaren Einstellungen und Profile ersetzt.",
        "settings_config_import_confirm": "Konfiguration ersetzen",
        "settings_config_imported": "Konfiguration importiert. Starten Sie die App neu, um alle Einstellungen zu übernehmen.",
        "settings_config_invalid": "Die Konfigurationsdatei ist ungültig oder wird nicht unterstützt.",
        "settings_config_plaintext_label": "Anmeldedaten werden in der exportierten Datei als lesbarer Text gespeichert.",
    },
    'es': {
        "settings_keyboard_global_section": "Navegación global",
        "settings_keyboard_video_section": "Reproductor de vídeo",
        "settings_keyboard_image_section": "Visor de imágenes",
        "settings_keyboard_next_tab": "Siguiente pestaña",
        "settings_keyboard_previous_tab": "Pestaña anterior",
        "settings_keyboard_tab_number": "Pestaña {number}",
        "settings_keyboard_first_image": "Primera imagen",
        "settings_keyboard_last_image": "Última imagen",
        "settings_keyboard_close_image": "Cerrar visor de imágenes",
        "settings_keyboard_unbind": "Desvincular acceso directo",
        "settings_keyboard_reset_confirm_title": "¿Restablecer los accesos directos del teclado?",
        "settings_keyboard_reset_confirm_body": "Todos los accesos directos personalizados se reemplazarán por los predeterminados.",
        "settings_keyboard_reserved": "Este acceso directo está reservado por el navegador o el sistema operativo.",
        "settings_keyboard_tab_reserved": "La tecla Tab está reservada para la navegación con el foco del teclado.",
        "settings_keyboard_conflict_moved": "Acceso directo movido de {action}.",
        "settings_config_backup_title": "Configuración de la aplicación",
        "settings_config_backup_subtitle": "Guardar o reemplazar la configuración visible y los perfiles de servidor",
        "settings_config_export": "Guardar configuración",
        "settings_config_import": "Importar configuración",
        "settings_config_include_credentials": "Incluir credenciales sin cifrar",
        "settings_config_credentials_warning": "Cualquiera con este archivo puede leer sus credenciales de servidor y el código de acceso de la app.",
        "settings_config_exported": "Configuración guardada",
        "settings_config_import_title": "¿Reemplazar la configuración de la aplicación?",
        "settings_config_import_summary": "Este archivo contiene {profileCount} perfiles de servidor. Al importar se reemplazan todas las configuraciones y perfiles actuales.",
        "settings_config_import_confirm": "Reemplazar configuración",
        "settings_config_imported": "Configuración importada. Reinicie la aplicación para aplicar todos los ajustes.",
        "settings_config_invalid": "El archivo de configuración no es válido o no es compatible.",
        "settings_config_plaintext_label": "Las credenciales se almacenan como texto legible en el archivo exportado.",
    },
    'fr': {
        "settings_keyboard_global_section": "Navigation globale",
        "settings_keyboard_video_section": "Lecteur vidéo",
        "settings_keyboard_image_section": "Visionneuse d'images",
        "settings_keyboard_next_tab": "Onglet suivant",
        "settings_keyboard_previous_tab": "Onglet précédent",
        "settings_keyboard_tab_number": "Onglet {number}",
        "settings_keyboard_first_image": "Première image",
        "settings_keyboard_last_image": "Dernière image",
        "settings_keyboard_close_image": "Fermer la visionneuse d'images",
        "settings_keyboard_unbind": "Dissocier le raccourci",
        "settings_keyboard_reset_confirm_title": "Réinitialiser les raccourcis clavier ?",
        "settings_keyboard_reset_confirm_body": "Tous les raccourcis clavier personnalisés seront remplacés par les valeurs par défaut.",
        "settings_keyboard_reserved": "Ce raccourci est réservé par le navigateur ou le système d'exploitation.",
        "settings_keyboard_tab_reserved": "La touche Tab est réservée à la navigation au clavier.",
        "settings_keyboard_conflict_moved": "Raccourci déplacé depuis {action}.",
        "settings_config_backup_title": "Configuration de l'application",
        "settings_config_backup_subtitle": "Enregistrer ou remplacer les paramètres visibles et les profils de serveur",
        "settings_config_export": "Enregistrer la configuration",
        "settings_config_import": "Importer la configuration",
        "settings_config_include_credentials": "Inclure les identifiants non chiffrés",
        "settings_config_credentials_warning": "Toute personne disposant de ce fichier peut lire vos identifiants de serveur et votre code de verrouillage de l'application.",
        "settings_config_exported": "Configuration enregistrée",
        "settings_config_import_title": "Remplacer la configuration de l'application ?",
        "settings_config_import_summary": "Ce fichier contient {profileCount} profils de serveur. L'importation remplace tous les paramètres et profils actuels.",
        "settings_config_import_confirm": "Remplacer la configuration",
        "settings_config_imported": "Configuration importée. Redémarrez l'application pour appliquer tous les réglages.",
        "settings_config_invalid": "Le fichier de configuration est invalide ou non pris en charge.",
        "settings_config_plaintext_label": "Les identifiants sont stockés sous forme de texte lisible dans le fichier exporté.",
    },
    'it': {
        "settings_keyboard_global_section": "Navigazione globale",
        "settings_keyboard_video_section": "Lettore video",
        "settings_keyboard_image_section": "Visualizzatore immagini",
        "settings_keyboard_next_tab": "Scheda successiva",
        "settings_keyboard_previous_tab": "Scheda precedente",
        "settings_keyboard_tab_number": "Scheda {number}",
        "settings_keyboard_first_image": "Prima immagine",
        "settings_keyboard_last_image": "Ultima immagine",
        "settings_keyboard_close_image": "Chiudi visualizzatore immagini",
        "settings_keyboard_unbind": "Scollega scorciatoia",
        "settings_keyboard_reset_confirm_title": "Ripristinare le scorciatoie da tastiera?",
        "settings_keyboard_reset_confirm_body": "Tutte le scorciatoie da tastiera personalizzate verranno sostituite con quelle predefinite.",
        "settings_keyboard_reserved": "Questa scorciatoia è riservata dal browser o dal sistema operativo.",
        "settings_keyboard_tab_reserved": "Il tasto Tab è riservato alla navigazione tramite tastiera.",
        "settings_keyboard_conflict_moved": "Scorciatoia spostata da {action}.",
        "settings_config_backup_title": "Configurazione app",
        "settings_config_backup_subtitle": "Salva o sostituisci le impostazioni visibili e i profili server",
        "settings_config_export": "Salva configurazione",
        "settings_config_import": "Importa configurazione",
        "settings_config_include_credentials": "Includi credenziali non crittografate",
        "settings_config_credentials_warning": "Chiunque abbia questo file può leggere le tue credenziali del server e il codice di blocco dell'app.",
        "settings_config_exported": "Configurazione salvata",
        "settings_config_import_title": "Sostituire la configurazione dell'app?",
        "settings_config_import_summary": "Questo file contiene {profileCount} profili server. L'importazione sostituisce tutte le impostazioni e i profili attuali.",
        "settings_config_import_confirm": "Sostituisci configurazione",
        "settings_config_imported": "Configurazione importata. Riavvia l'app per applicare tutte le impostazioni.",
        "settings_config_invalid": "Il file di configurazione non è valido o non è supportato.",
        "settings_config_plaintext_label": "Le credenziali vengono salvate come testo leggibile nel file esportato.",
    },
    'ja': {
        "settings_keyboard_global_section": "グローバルナビゲーション",
        "settings_keyboard_video_section": "ビデオプレーヤー",
        "settings_keyboard_image_section": "画像ビューア",
        "settings_keyboard_next_tab": "次のタブ",
        "settings_keyboard_previous_tab": "前のタブ",
        "settings_keyboard_tab_number": "タブ {number}",
        "settings_keyboard_first_image": "最初の画像",
        "settings_keyboard_last_image": "最後の画像",
        "settings_keyboard_close_image": "画像ビューアを閉じる",
        "settings_keyboard_unbind": "ショートカットを解除",
        "settings_keyboard_reset_confirm_title": "キーボードショートカットをリセットしますか？",
        "settings_keyboard_reset_confirm_body": "すべてのカスタムキーボードショートカットがデフォルトに置き換えられます。",
        "settings_keyboard_reserved": "このショートカットはブラウザまたはオペレーティングシステムによって予約されています。",
        "settings_keyboard_tab_reserved": "Tabキーはキーボードフォーカスナビゲーション用に予約されています。",
        "settings_keyboard_conflict_moved": "{action} から移動したショートカット",
        "settings_config_backup_title": "アプリ設定",
        "settings_config_backup_subtitle": "ユーザー向け設定とサーバープロファイルを保存または置換",
        "settings_config_export": "設定を保存",
        "settings_config_import": "設定をインポート",
        "settings_config_include_credentials": "認証情報を暗号化せずに含める",
        "settings_config_credentials_warning": "このファイルを持っている人は誰でも、サーバーの認証情報とアプリロックのパスコードを読むことができます。",
        "settings_config_exported": "設定を保存しました",
        "settings_config_import_title": "アプリ設定を置き換えますか？",
        "settings_config_import_summary": "このファイルには {profileCount} 個のサーバープロファイルが含まれています。インポートすると、現在のユーザー向け設定とプロファイルがすべて置き換えられます。",
        "settings_config_import_confirm": "設定を置き換え",
        "settings_config_imported": "設定をインポートしました。すべての設定を適用するにはアプリを再起動してください。",
        "settings_config_invalid": "設定ファイルが無効またはサポートされていません。",
        "settings_config_plaintext_label": "認証情報はエクスポートしたファイルに読み取り可能なテキストとして保存されます。",
    },
    'ko': {
        "settings_keyboard_global_section": "전역 탐색",
        "settings_keyboard_video_section": "비디오 플레이어",
        "settings_keyboard_image_section": "이미지 뷰어",
        "settings_keyboard_next_tab": "다음 탭",
        "settings_keyboard_previous_tab": "이전 탭",
        "settings_keyboard_tab_number": "탭 {number}",
        "settings_keyboard_first_image": "첫 번째 이미지",
        "settings_keyboard_last_image": "마지막 이미지",
        "settings_keyboard_close_image": "이미지 뷰어 닫기",
        "settings_keyboard_unbind": "단축키 해제",
        "settings_keyboard_reset_confirm_title": "키보드 단축키를 재설정하시겠습니까?",
        "settings_keyboard_reset_confirm_body": "모든 사용자 지정 키보드 단축키가 기본값으로 대체됩니다.",
        "settings_keyboard_reserved": "이 단축키는 브라우저 또는 운영 체제에서 예약되어 있습니다.",
        "settings_keyboard_tab_reserved": "Tab 키는 키보드 포커스 탐색용으로 예약되어 있습니다.",
        "settings_keyboard_conflict_moved": "{action}에서 이동된 단축키",
        "settings_config_backup_title": "앱 구성",
        "settings_config_backup_subtitle": "사용자용 설정 및 서버 프로필 저장 또는 교체",
        "settings_config_export": "구성 저장",
        "settings_config_import": "구성 가져오기",
        "settings_config_include_credentials": "자격 증명을 암호화하지 않고 포함",
        "settings_config_credentials_warning": "이 파일을 가진 사람은 누구나 서버 자격 증명과 앱 잠금 암호를 읽을 수 있습니다.",
        "settings_config_exported": "구성이 저장되었습니다",
        "settings_config_import_title": "앱 구성을 교체하시겠습니까?",
        "settings_config_import_summary": "이 파일에는 {profileCount}개의 서버 프로필이 포함되어 있습니다. 가져오면 현재 사용자용 설정과 프로필이 모두 교체됩니다.",
        "settings_config_import_confirm": "구성 교체",
        "settings_config_imported": "구성을 가져왔습니다. 모든 설정을 적용하려면 앱을 다시 시작하세요.",
        "settings_config_invalid": "구성 파일이 유효하지 않거나 지원되지 않습니다.",
        "settings_config_plaintext_label": "자격 증명은 내보낸 파일에 읽을 수 있는 텍스트로 저장됩니다.",
    },
    'ru': {
        "settings_keyboard_global_section": "Глобальная навигация",
        "settings_keyboard_video_section": "Видеоплеер",
        "settings_keyboard_image_section": "Просмотр изображений",
        "settings_keyboard_next_tab": "Следующая вкладка",
        "settings_keyboard_previous_tab": "Предыдущая вкладка",
        "settings_keyboard_tab_number": "Вкладка {number}",
        "settings_keyboard_first_image": "Первое изображение",
        "settings_keyboard_last_image": "Последнее изображение",
        "settings_keyboard_close_image": "Закрыть просмотр изображений",
        "settings_keyboard_unbind": "Отвязать сочетание клавиш",
        "settings_keyboard_reset_confirm_title": "Сбросить сочетания клавиш?",
        "settings_keyboard_reset_confirm_body": "Все настраиваемые сочетания клавиш будут заменены значениями по умолчанию.",
        "settings_keyboard_reserved": "Это сочетание клавиш зарезервировано браузером или операционной системой.",
        "settings_keyboard_tab_reserved": "Клавиша Tab зарезервирована для навигации с помощью клавиатуры.",
        "settings_keyboard_conflict_moved": "Сочетание клавиш перемещено из {action}.",
        "settings_config_backup_title": "Конфигурация приложения",
        "settings_config_backup_subtitle": "Сохранить или заменить настройки приложения и профили серверов",
        "settings_config_export": "Сохранить конфигурацию",
        "settings_config_import": "Импортировать конфигурацию",
        "settings_config_include_credentials": "Включить учётные данные без шифрования",
        "settings_config_credentials_warning": "Любой, у кого есть этот файл, сможет прочитать ваши учётные данные сервера и код блокировки приложения.",
        "settings_config_exported": "Конфигурация сохранена",
        "settings_config_import_title": "Заменить конфигурацию приложения?",
        "settings_config_import_summary": "Этот файл содержит {profileCount} профилей серверов. Импорт заменяет все текущие настройки и профили.",
        "settings_config_import_confirm": "Заменить конфигурацию",
        "settings_config_imported": "Конфигурация импортирована. Перезапустите приложение, чтобы применить все настройки.",
        "settings_config_invalid": "Файл конфигурации недействителен или не поддерживается.",
        "settings_config_plaintext_label": "Учётные данные сохраняются в виде читаемого текста в экспортированном файле.",
    },
    'zh': {
        "settings_keyboard_global_section": "全局导航",
        "settings_keyboard_video_section": "视频播放器",
        "settings_keyboard_image_section": "图片查看器",
        "settings_keyboard_next_tab": "下一个标签页",
        "settings_keyboard_previous_tab": "上一个标签页",
        "settings_keyboard_tab_number": "标签页 {number}",
        "settings_keyboard_first_image": "第一张图片",
        "settings_keyboard_last_image": "最后一张图片",
        "settings_keyboard_close_image": "关闭图片查看器",
        "settings_keyboard_unbind": "取消绑定快捷键",
        "settings_keyboard_reset_confirm_title": "重置键盘快捷键？",
        "settings_keyboard_reset_confirm_body": "所有自定义键盘快捷键都将替换为默认值。",
        "settings_keyboard_reserved": "此快捷键已被浏览器或操作系统保留。",
        "settings_keyboard_tab_reserved": "Tab 键保留用于键盘焦点导航。",
        "settings_keyboard_conflict_moved": "快捷键从 {action} 移出。",
        "settings_config_backup_title": "应用配置",
        "settings_config_backup_subtitle": "保存或替换用户可见的设置和服务器配置文件",
        "settings_config_export": "保存配置",
        "settings_config_import": "导入配置",
        "settings_config_include_credentials": "以明文包含凭据",
        "settings_config_credentials_warning": "任何拥有此文件的人都可以读取你的服务器凭据和应用锁密码。",
        "settings_config_exported": "配置已保存",
        "settings_config_import_title": "替换应用配置？",
        "settings_config_import_summary": "此文件包含 {profileCount} 个服务器配置文件。导入将替换当前所有用户可见的设置和配置。",
        "settings_config_import_confirm": "替换配置",
        "settings_config_imported": "配置已导入。重启应用以应用所有设置。",
        "settings_config_invalid": "配置文件无效或不受支持。",
        "settings_config_plaintext_label": "凭据将以可读文本形式存储在导出的文件中。",
    },
    'zh_Hans': {
        "settings_keyboard_global_section": "全局导航",
        "settings_keyboard_video_section": "视频播放器",
        "settings_keyboard_image_section": "图片查看器",
        "settings_keyboard_next_tab": "下一个标签页",
        "settings_keyboard_previous_tab": "上一个标签页",
        "settings_keyboard_tab_number": "标签页 {number}",
        "settings_keyboard_first_image": "第一张图片",
        "settings_keyboard_last_image": "最后一张图片",
        "settings_keyboard_close_image": "关闭图片查看器",
        "settings_keyboard_unbind": "取消绑定快捷键",
        "settings_keyboard_reset_confirm_title": "重置键盘快捷键？",
        "settings_keyboard_reset_confirm_body": "所有自定义键盘快捷键都将替换为默认值。",
        "settings_keyboard_reserved": "此快捷键已被浏览器或操作系统保留。",
        "settings_keyboard_tab_reserved": "Tab 键保留用于键盘焦点导航。",
        "settings_keyboard_conflict_moved": "快捷键从 {action} 移出。",
        "settings_config_backup_title": "应用配置",
        "settings_config_backup_subtitle": "保存或替换用户可见的设置和服务器配置文件",
        "settings_config_export": "保存配置",
        "settings_config_import": "导入配置",
        "settings_config_include_credentials": "以明文包含凭据",
        "settings_config_credentials_warning": "任何拥有此文件的人都可以读取你的服务器凭据和应用锁密码。",
        "settings_config_exported": "配置已保存",
        "settings_config_import_title": "替换应用配置？",
        "settings_config_import_summary": "此文件包含 {profileCount} 个服务器配置文件。导入将替换当前所有用户可见的设置和配置。",
        "settings_config_import_confirm": "替换配置",
        "settings_config_imported": "配置已导入。重启应用以应用所有设置。",
        "settings_config_invalid": "配置文件无效或不受支持。",
        "settings_config_plaintext_label": "凭据将以可读文本形式存储在导出的文件中。",
    },
    'zh_Hant': {
        "settings_keyboard_global_section": "全域導覽",
        "settings_keyboard_video_section": "影片播放器",
        "settings_keyboard_image_section": "圖片檢視器",
        "settings_keyboard_next_tab": "下一個分頁",
        "settings_keyboard_previous_tab": "上一個分頁",
        "settings_keyboard_tab_number": "分頁 {number}",
        "settings_keyboard_first_image": "第一張圖片",
        "settings_keyboard_last_image": "最後一張圖片",
        "settings_keyboard_close_image": "關閉圖片檢視器",
        "settings_keyboard_unbind": "取消綁定快速鍵",
        "settings_keyboard_reset_confirm_title": "重設鍵盤快速鍵？",
        "settings_keyboard_reset_confirm_body": "所有自訂鍵盤快速鍵都將替換為預設值。",
        "settings_keyboard_reserved": "此快速鍵已由瀏覽器或作業系統保留。",
        "settings_keyboard_tab_reserved": "Tab 鍵保留用於鍵盤焦點導覽。",
        "settings_keyboard_conflict_moved": "快速鍵已從 {action} 移出。",
        "settings_config_backup_title": "應用程式設定",
        "settings_config_backup_subtitle": "儲存或取代使用者可見的設定與伺服器設定檔",
        "settings_config_export": "儲存設定",
        "settings_config_import": "匯入設定",
        "settings_config_include_credentials": "以明文包含憑證",
        "settings_config_credentials_warning": "任何擁有此檔案的人都可以讀取你的伺服器憑證和應用程式鎖定密碼。",
        "settings_config_exported": "設定已儲存",
        "settings_config_import_title": "取代應用程式設定？",
        "settings_config_import_summary": "此檔案包含 {profileCount} 個伺服器設定檔。匯入會取代目前所有使用者可見的設定與設定檔。",
        "settings_config_import_confirm": "取代設定",
        "settings_config_imported": "設定已匯入。重新啟動應用程式以套用所有設定。",
        "settings_config_invalid": "設定檔無效或不受支援。",
        "settings_config_plaintext_label": "憑證會以可讀文字形式儲存在匯出的檔案中。",
    },
}

KEYBOARD_KEYS = [
    "settings_keyboard_global_section",
    "settings_keyboard_video_section",
    "settings_keyboard_image_section",
    "settings_keyboard_next_tab",
    "settings_keyboard_previous_tab",
    "settings_keyboard_tab_number",
    "settings_keyboard_first_image",
    "settings_keyboard_last_image",
    "settings_keyboard_close_image",
    "settings_keyboard_unbind",
    "settings_keyboard_reset_confirm_title",
    "settings_keyboard_reset_confirm_body",
    "settings_keyboard_reserved",
    "settings_keyboard_tab_reserved",
    "settings_keyboard_conflict_moved",
]
CONFIG_KEYS = [
    "settings_config_backup_title",
    "settings_config_backup_subtitle",
    "settings_config_export",
    "settings_config_import",
    "settings_config_include_credentials",
    "settings_config_credentials_warning",
    "settings_config_exported",
    "settings_config_import_title",
    "settings_config_import_summary",
    "settings_config_import_confirm",
    "settings_config_imported",
    "settings_config_invalid",
    "settings_config_plaintext_label",
]


def render_entries(entries):
    lines = []
    for i, (k, v) in enumerate(entries):
        comma = ',' if i < len(entries) - 1 else ''
        lines.append(f'  {json.dumps(k, ensure_ascii=False)}: {json.dumps(v, ensure_ascii=False)}{comma}')
    return '\n'.join(lines)


def main():
    for locale, translations in T.items():
        path = l10n_dir / f'app_{locale}.arb'
        data = json.loads(path.read_text(encoding='utf-8'))

        missing_keyboard = [k for k in KEYBOARD_KEYS if k not in data]
        missing_config = [k for k in CONFIG_KEYS if k not in data]

        tracked = KEYBOARD_KEYS + CONFIG_KEYS

        # Pop all tracked keys, then reinsert in the correct position so re-runs
        # are idempotent and placement always matches app_en.arb ordering.
        for mk in tracked:
            data.pop(mk, None)

        # Build new dict preserving existing order, inserting keyboard keys right
        # after the last existing settings_keyboard_* key, and config keys at the end.
        new = {}
        # Build new dict preserving existing order, inserting keyboard keys right
        # after the last existing settings_keyboard_* key, and config keys at the end.
        keys = list(data.keys())
        last_kb = max(
            (i for i, k in enumerate(keys) if k.startswith('settings_keyboard_')),
            default=-1,
        )
        new = {}
        for i, k in enumerate(keys):
            new[k] = data[k]
            if i == last_kb:
                for mk in KEYBOARD_KEYS:
                    new[mk] = translations[mk]
        for mk in CONFIG_KEYS:
            new[mk] = translations[mk]

        text = json.dumps(new, ensure_ascii=False, indent=2) + '\n'
        path.write_text(text, encoding='utf-8')
        added_kb = [k for k in KEYBOARD_KEYS if k not in data]
        added_cfg = [k for k in CONFIG_KEYS if k not in data]
        print(f'{locale}: +{len(added_kb)} keyboard, +{len(added_cfg)} config keys')


if __name__ == '__main__':
    main()
