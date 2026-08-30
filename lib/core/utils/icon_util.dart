import 'package:flutter/widgets.dart';
import 'package:forui_phosphor/forui_phosphor.dart';

/// Represents a grouped collection of icons for selection in UI forms.
class IconCategory {
  /// Creates an [IconCategory] with a display [name] and icon map [icons].
  const IconCategory({required this.name, required this.icons});

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
        'receipt': FPhosphorIcons.receipt,
        'invoice': FPhosphorIcons.invoice,
        'calculator': FPhosphorIcons.calculator,
        'scales': FPhosphorIcons.scales,
        'hand_coins': FPhosphorIcons.handCoins,
        'trend_up': FPhosphorIcons.trendUp,
        'trend_down': FPhosphorIcons.trendDown,
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
        't_shirt': FPhosphorIcons.tShirt,
        'sneaker': FPhosphorIcons.sneaker,
        'watch': FPhosphorIcons.watch,
        'sunglasses': FPhosphorIcons.sunglasses,
        'tote': FPhosphorIcons.tote,
        'handbag': FPhosphorIcons.handbag,
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
        'bicycle': FPhosphorIcons.bicycle,
        'bus': FPhosphorIcons.bus,
        'train': FPhosphorIcons.train,
        'taxi': FPhosphorIcons.taxi,
        'gas_pump': FPhosphorIcons.gasPump,
        'map_pin': FPhosphorIcons.mapPin,
        'globe': FPhosphorIcons.globe,
        'tent': FPhosphorIcons.tent,
        'suitcase': FPhosphorIcons.suitcase,
        'suitcase_rolling': FPhosphorIcons.suitcaseRolling,
        'scooter': FPhosphorIcons.scooter,
        'motorcycle': FPhosphorIcons.motorcycle,
        'boat': FPhosphorIcons.boat,
        'steering_wheel': FPhosphorIcons.steeringWheel,
      },
    ),
    IconCategory(
      name: 'Housing & Utilities',
      icons: {
        'house': FPhosphorIcons.house,
        'house_line': FPhosphorIcons.houseLine,
        'building': FPhosphorIcons.building,
        'building_apartment': FPhosphorIcons.buildingApartment,
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
        'trash': FPhosphorIcons.trash,
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
        'music_notes': FPhosphorIcons.musicNotes,
        'headphones': FPhosphorIcons.headphones,
        'barbell': FPhosphorIcons.barbell,
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
        'tennis_ball': FPhosphorIcons.tennisBall,
      },
    ),
    IconCategory(
      name: 'Technology & Work',
      icons: {
        'laptop': FPhosphorIcons.laptop,
        'desktop': FPhosphorIcons.desktop,
        'device_mobile': FPhosphorIcons.deviceMobile,
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
        'monitor': FPhosphorIcons.monitor,
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
        'wrench': FPhosphorIcons.wrench,
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

  /// Looks up an icon by its identifier [name], falling back to a wallet icon if not found.
  static IconData getIcon(String? name) {
    if (name == null || !availableIcons.containsKey(name)) {
      return FPhosphorIcons.wallet;
    }
    return availableIcons[name]!;
  }
}
