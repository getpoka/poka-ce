import 'package:flutter/widgets.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Represents a grouped collection of icons for selection in UI forms.
class IconCategory {
  /// Creates an [IconCategory] with a display [name] and icon map [icons].
  const new({required this.name, required this.icons});

  final String name;
  final Map<String, IconData> icons;
}

/// Utility class providing categorized Phosphor icons and lookup helpers.
class IconUtil {
  /// List of icon categories used in category creation and selection sheets.
  static const List<IconCategory> categories = [
    IconCategory(
      name: 'Finance & Banking',
      icons: {
        'wallet': FPhosphorIcons.wallet,
        'bank': FPhosphorIcons.bank,
        'credit_card': FPhosphorIcons.creditCard,
        'money': FPhosphorIcons.money,
        'piggy_bank': FPhosphorIcons.piggyBank,
        'coins': FPhosphorIcons.coins,
        'currency_circle_dollar': FPhosphorIcons.currencyCircleDollar,
        'vault': FPhosphorIcons.vault,
        'chart_line_up': FPhosphorIcons.chartLineUp,
        'chart_line_down': FPhosphorIcons.chartLineDown,
        'chart_pie': FPhosphorIcons.chartPie,
        'chart_bar': FPhosphorIcons.chartBar,
        'receipt': FPhosphorIcons.receipt,
        'invoice': FPhosphorIcons.invoice,
        'calculator': FPhosphorIcons.calculator,
        'scales': FPhosphorIcons.scales,
        'hand_coins': FPhosphorIcons.handCoins,
        'trend_up': FPhosphorIcons.trendUp,
        'trend_down': FPhosphorIcons.trendDown,
        'cardholder': FPhosphorIcons.cardholder,
      },
    ),
    IconCategory(
      name: 'Food & Dining',
      icons: {
        'shopping_cart': FPhosphorIcons.shoppingCart,
        'hamburger': FPhosphorIcons.hamburger,
        'coffee': FPhosphorIcons.coffee,
        'fork_knife': FPhosphorIcons.forkKnife,
        'pizza': FPhosphorIcons.pizza,
        'bowl_food': FPhosphorIcons.bowlFood,
        'beer_bottle': FPhosphorIcons.beerBottle,
        'martini': FPhosphorIcons.martini,
        'wine': FPhosphorIcons.wine,
        'cooking_pot': FPhosphorIcons.cookingPot,
        'carrot': FPhosphorIcons.carrot,
        'cake': FPhosphorIcons.cake,
        'ice_cream': FPhosphorIcons.iceCream,
        'cookie': FPhosphorIcons.cookie,
        'egg': FPhosphorIcons.egg,
        'fish_simple': FPhosphorIcons.fishSimple,
      },
    ),
    IconCategory(
      name: 'Shopping & Retail',
      icons: {
        'bag': FPhosphorIcons.bag,
        'storefront': FPhosphorIcons.storefront,
        'basket': FPhosphorIcons.basket,
        'barcode': FPhosphorIcons.barcode,
        'tag': FPhosphorIcons.tag,
        'gift': FPhosphorIcons.gift,
        'package': FPhosphorIcons.package,
        't_shirt': FPhosphorIcons.tShirt,
        'sneaker': FPhosphorIcons.sneaker,
        'watch': FPhosphorIcons.watch,
        'sunglasses': FPhosphorIcons.sunglasses,
        'tote': FPhosphorIcons.tote,
        'handbag': FPhosphorIcons.handbag,
        'crown': FPhosphorIcons.crown,
        'sparkle': FPhosphorIcons.sparkle,
      },
    ),
    IconCategory(
      name: 'Transport & Travel',
      icons: {
        'car': FPhosphorIcons.car,
        'car_profile': FPhosphorIcons.carProfile,
        'airplane': FPhosphorIcons.airplane,
        'airplane_tilt': FPhosphorIcons.airplaneTilt,
        'airplane_takeoff': FPhosphorIcons.airplaneTakeoff,
        'airplane_landing': FPhosphorIcons.airplaneLanding,
        'bicycle': FPhosphorIcons.bicycle,
        'bus': FPhosphorIcons.bus,
        'train': FPhosphorIcons.train,
        'taxi': FPhosphorIcons.taxi,
        'gas_pump': FPhosphorIcons.gasPump,
        'charging_station': FPhosphorIcons.chargingStation,
        'map_pin': FPhosphorIcons.mapPin,
        'globe': FPhosphorIcons.globe,
        'tent': FPhosphorIcons.tent,
        'suitcase': FPhosphorIcons.suitcase,
        'suitcase_rolling': FPhosphorIcons.suitcaseRolling,
        'scooter': FPhosphorIcons.scooter,
        'motorcycle': FPhosphorIcons.motorcycle,
        'boat': FPhosphorIcons.boat,
      },
    ),
    IconCategory(
      name: 'Housing & Utilities',
      icons: {
        'house': FPhosphorIcons.house,
        'house_line': FPhosphorIcons.houseLine,
        'building': FPhosphorIcons.building,
        'building_apartment': FPhosphorIcons.buildingApartment,
        'key': FPhosphorIcons.key,
        'lightning': FPhosphorIcons.lightning,
        'drop': FPhosphorIcons.drop,
        'fire': FPhosphorIcons.fire,
        'wifi_high': FPhosphorIcons.wifiHigh,
        'plugs': FPhosphorIcons.plugs,
        'television': FPhosphorIcons.television,
        'armchair': FPhosphorIcons.armchair,
        'bed': FPhosphorIcons.bed,
        'wrench': FPhosphorIcons.wrench,
        'hammer': FPhosphorIcons.hammer,
        'paint_roller': FPhosphorIcons.paintRoller,
        'toilet': FPhosphorIcons.toilet,
        'bathtub': FPhosphorIcons.bathtub,
        'shower': FPhosphorIcons.shower,
        'lightbulb': FPhosphorIcons.lightbulb,
      },
    ),
    IconCategory(
      name: 'Health & Wellness',
      icons: {
        'first_aid': FPhosphorIcons.firstAid,
        'pill': FPhosphorIcons.pill,
        'heart_beat': FPhosphorIcons.heartbeat,
        'syringe': FPhosphorIcons.syringe,
        'stethoscope': FPhosphorIcons.stethoscope,
        'brain': FPhosphorIcons.brain,
        'baby': FPhosphorIcons.baby,
        'bandaids': FPhosphorIcons.bandaids,
        'thermometer': FPhosphorIcons.thermometer,
        'wheelchair': FPhosphorIcons.wheelchair,
        'activity': FPhosphorIcons.activity,
        'tooth': FPhosphorIcons.tooth,
        'shield_check': FPhosphorIcons.shieldCheck,
        'shield_plus': FPhosphorIcons.shieldPlus,
        'barbell': FPhosphorIcons.barbell,
      },
    ),
    IconCategory(
      name: 'Education & Learning',
      icons: {
        'student': FPhosphorIcons.student,
        'graduation_cap': FPhosphorIcons.graduationCap,
        'book': FPhosphorIcons.book,
        'book_open': FPhosphorIcons.bookOpen,
        'books': FPhosphorIcons.books,
        'exam': FPhosphorIcons.exam,
        'pencil': FPhosphorIcons.pencil,
        'pen': FPhosphorIcons.pen,
        'chalkboard': FPhosphorIcons.chalkboard,
        'certificate': FPhosphorIcons.certificate,
        'backpack': FPhosphorIcons.backpack,
        'ruler': FPhosphorIcons.ruler,
      },
    ),
    IconCategory(
      name: 'Lifestyle & Entertainment',
      icons: {
        'game_controller': FPhosphorIcons.gameController,
        'film_strip': FPhosphorIcons.filmStrip,
        'monitor_play': FPhosphorIcons.monitorPlay,
        'music_notes': FPhosphorIcons.musicNotes,
        'headphones': FPhosphorIcons.headphones,
        'palette': FPhosphorIcons.palette,
        'heart': FPhosphorIcons.heart,
        'smiley': FPhosphorIcons.smiley,
        'camera': FPhosphorIcons.camera,
        'popcorn': FPhosphorIcons.popcorn,
        'ticket': FPhosphorIcons.ticket,
        'microphone': FPhosphorIcons.microphone,
        'radio': FPhosphorIcons.radio,
        'speaker_hifi': FPhosphorIcons.speakerHifi,
        'mask_happy': FPhosphorIcons.maskHappy,
        'volleyball': FPhosphorIcons.volleyball,
        'basketball': FPhosphorIcons.basketball,
        'soccer_ball': FPhosphorIcons.soccerBall,
      },
    ),
    IconCategory(
      name: 'Technology & Work',
      icons: {
        'laptop': FPhosphorIcons.laptop,
        'desktop': FPhosphorIcons.desktop,
        'device_mobile': FPhosphorIcons.deviceMobile,
        'devices': FPhosphorIcons.devices,
        'briefcase': FPhosphorIcons.briefcase,
        'pen_nib': FPhosphorIcons.penNib,
        'code': FPhosphorIcons.code,
        'folder': FPhosphorIcons.folder,
        'printer': FPhosphorIcons.printer,
        'mouse': FPhosphorIcons.mouse,
        'keyboard': FPhosphorIcons.keyboard,
        'hard_drives': FPhosphorIcons.hardDrives,
        'cpu': FPhosphorIcons.cpu,
        'headset': FPhosphorIcons.headset,
        'handshake': FPhosphorIcons.handshake,
      },
    ),
    IconCategory(
      name: 'Family & Pets',
      icons: {
        'users': FPhosphorIcons.users,
        'user': FPhosphorIcons.user,
        'paw_print': FPhosphorIcons.pawPrint,
        'cat': FPhosphorIcons.cat,
        'dog': FPhosphorIcons.dog,
        'bird': FPhosphorIcons.bird,
        'fish': FPhosphorIcons.fish,
        'horse': FPhosphorIcons.horse,
        'shield_star': FPhosphorIcons.shieldStar,
      },
    ),
    IconCategory(
      name: 'Other',
      icons: {
        'dots_three': FPhosphorIcons.dotsThree,
        'star': FPhosphorIcons.star,
        'asterisk': FPhosphorIcons.asterisk,
        'question': FPhosphorIcons.question,
        'info': FPhosphorIcons.info,
        'bell': FPhosphorIcons.bell,
        'calendar': FPhosphorIcons.calendar,
        'clock': FPhosphorIcons.clock,
        'flag': FPhosphorIcons.flag,
        'leaf': FPhosphorIcons.leaf,
        'tree': FPhosphorIcons.tree,
        'umbrella': FPhosphorIcons.umbrella,
        'target': FPhosphorIcons.target,
        'trophy': FPhosphorIcons.trophy,
      },
    ),
  ];

  /// Combined map of all available icon identifiers to [IconData].
  ///
  /// Built once and cached — the icon catalogue is constant — so hot paths like
  /// transaction tiles do not rebuild the merged map on every frame.
  static final Map<String, IconData> availableIcons = _buildAvailableIcons();

  static Map<String, IconData> _buildAvailableIcons() {
    final icons = <String, IconData>{};
    for (final category in categories) {
      icons.addAll(category.icons);
    }
    return icons;
  }

  /// Lazy index of keyword aliases per icon, aggregated across all supported locales from i18n JSONs.
  static final Map<String, Set<String>> _keywordAliases = _buildKeywordAliases();

  static Map<String, Set<String>> _buildKeywordAliases() {
    final map = <String, Set<String>>{};
    for (final locale in AppLocale.values) {
      final translations = locale.buildSync();
      final aliasesMap = translations.icons.aliases;
      for (final entry in aliasesMap.entries) {
        final key = entry.key;
        final words = entry.value.toLowerCase().split(',');
        final set = map.putIfAbsent(key, () => <String>{});
        for (final word in words) {
          final trimmed = word.trim();
          if (trimmed.isNotEmpty) {
            set.add(trimmed);
          }
        }
      }
    }
    return map;
  }

  /// Looks up an icon by its identifier [name], falling back to a wallet icon if not found.
  static IconData getIcon(String? name) {
    if (name == null) return FPhosphorIcons.wallet;
    if (availableIcons.containsKey(name)) return availableIcons[name]!;
    final normalized = name.replaceAll('-', '_');
    if (availableIcons.containsKey(normalized)) return availableIcons[normalized]!;
    final hyphenated = name.replaceAll('_', '-');
    if (availableIcons.containsKey(hyphenated)) return availableIcons[hyphenated]!;
    return FPhosphorIcons.wallet;
  }

  /// Searches for icons matching [query] across icon keys, category names,
  /// and multilingual keyword aliases from i18n JSON files.
  static Map<String, IconData> searchIcons(String query) {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return availableIcons;

    final results = <String, IconData>{};
    for (final category in categories) {
      final categoryMatches = category.name.toLowerCase().contains(trimmed);
      for (final entry in category.icons.entries) {
        final key = entry.key;
        final keyWords = key.replaceAll('_', ' ').toLowerCase();
        final aliases = _keywordAliases[key] ?? const <String>{};

        if (key.contains(trimmed) ||
            keyWords.contains(trimmed) ||
            categoryMatches ||
            aliases.any((alias) => alias.contains(trimmed))) {
          results[key] = entry.value;
        }
      }
    }
    return results;
  }
}
