import 'package:flutter/material.dart';

const kColor1 = Color.fromRGBO(226, 94, 62, 1);
const kColor2 = Color.fromARGB(255, 252, 125, 93);

List<Map<String, String>> places = [
  {
    'type': 'historical',
    'subtype': 'museum',
    'image': 'images/placeImages/national_museum.jpg',
    'title': 'National Museum',
    'latitude': '6.029184148611888',
    'longitude': '80.21713256835938',
    'description':
        'Circa-1656 Dutch building now a museum, with artifacts like masks, carvings, ship equipment & armor.',
    'street': 'Church Street'
  },
  {
    'type': 'historical',
    'subtype': 'museum',
    'image': 'images/placeImages/maritime_museum.jpg',
    'title': 'Maritime Museum',
    'latitude': '6.0282453505495806',
    'longitude': '80.21805372670991',
    'description':
        'Underwater artifacts, ship models & other marine-centric exhibits in a Dutch warehouse from 1671.',
    'street': 'Queens Street'
  },
  {
    'type': 'historical',
    'subtype': 'museum',
    'image': 'images/placeImages/mansion_museum.png',
    'title': 'Mansion Museum',
    'latitude': '6.02666626106581',
    'longitude': '80.21889057586961',
    'description': '',
    'street': 'Leyn Baan Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/star_bastion.jpg',
    'title': 'Star Bastion',
    'latitude': '6.030071086310414',
    'longitude': '80.21365461771649',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/aeolus_bastion.jpg',
    'title': 'Aeolus Bastion',
    'latitude': '6.028644672267317',
    'longitude': '80.21380349979553',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/clippenberg_bastion.jpg',
    'title': 'Clippenberg Bastion',
    'latitude': '6.026962637877344',
    'longitude': '80.21396363162945',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/neptune_bastion.jpg',
    'title': 'Neptune Bastion',
    'latitude': '6.026418491402381',
    'longitude': '80.2147025802099',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/triton_bastion.jpg',
    'title': 'Triton Bastion',
    'latitude': '6.02506641008604',
    'longitude': '80.21610755567515',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/flagrock_bastion.jpg',
    'title': 'Flagrock Bastion',
    'latitude': '6.023704985952394',
    'longitude': '80.21748346501165',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/utrecht_bastion.jpg',
    'title': 'Utrecht Bastion',
    'latitude': '6.024534310998068',
    'longitude': '80.21946762074525',
    'description': '',
    'street': 'Hospital Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/aurora_bastion.jpg',
    'title': 'Aurora Bastion',
    'latitude': '6.026364350440924',
    'longitude': '80.21976243124213',
    'description': '',
    'street': 'Hospital Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/akersloot_bastion.jpg',
    'title': 'Akersloot Bastion',
    'latitude': '6.027513024118802',
    'longitude': '80.21981371137203',
    'description': '',
    'street': 'Hospital Street'
  },
  {
    'type': 'historical',
    'subtype': 'bastion',
    'image': 'images/placeImages/zwart_bastion.jpg',
    'title': 'Zwart Bastion',
    'latitude': '6.029146932363322',
    'longitude': '80.21929522519076',
    'description': '',
    'street': 'Queens Street'
  },
  {
    'type': 'historical',
    'subtype': 'others',
    'image': 'images/placeImages/lighthouse.jpg',
    'title': 'Lighthouse',
    'latitude': '6.024681642686777',
    'longitude': '80.21936780691149',
    'description': '',
    'street': 'Hospital Street'
  },
  {
    'type': 'historical',
    'subtype': 'others',
    'image': 'images/placeImages/dutch_belfry.jpg',
    'title': 'Ducth Belfry',
    'latitude': '6.0280401780587916',
    'longitude': '80.21758876739379',
    'description': '',
    'street': 'Queens Street'
  },
  {
    'type': 'historical',
    'subtype': 'others',
    'image': 'images/placeImages/queens_house.jpg',
    'title': 'British Queen\'s House',
    'latitude': '6.027845459422394',
    'longitude': '80.2177443354998',
    'description': '',
    'street': 'Queens Street'
  },
  {
    'type': 'historical',
    'subtype': 'others',
    'image': 'images/placeImages/saints_church.jpg',
    'title': 'All Saint\'s Church',
    'latitude': '6.0275893909777905',
    'longitude': '80.21745465692729',
    'description': '',
    'street': 'Queens Street'
  },
  {
    'type': 'historical',
    'subtype': 'others',
    'image': 'images/placeImages/temple.jpg',
    'title': 'Sri Sudharmalaya Temple',
    'latitude': '6.027094591706631',
    'longitude': '80.21535750475037',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'historical',
    'subtype': 'others',
    'image': 'images/placeImages/reformed_church.jpg',
    'title': 'Ducth Reformed Church',
    'latitude': '6.0282946517659095',
    'longitude': '80.21718841201944',
    'description': '',
    'street': 'Church Street'
  },
  {
    'type': 'commercial',
    'subtype': 'hotel',
    'image': 'images/placeImages/yara_hotel.jpg',
    'title': 'Yara Galle Fort',
    'latitude': '6.029058448643519',
    'longitude': '80.21555062388508',
    'description': '',
    'street': 'Middle Street'
  },
  {
    'type': 'commercial',
    'subtype': 'hotel',
    'image': 'images/placeImages/seagreen_hotel.jpg',
    'title': 'Seagreen',
    'latitude': '6.028085523479828',
    'longitude': '80.21498149258059',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'commercial',
    'subtype': 'hotel',
    'image': 'images/placeImages/bartizan_hotel.jpg',
    'title': 'Bartizan Galle Fort',
    'latitude': '6.025706217231935',
    'longitude': '80.21601414305763',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'commercial',
    'subtype': 'hotel',
    'image': 'images/placeImages/galleheritage_hotel.jpg',
    'title': 'Galle Heritage Villa',
    'latitude': '6.0250200308373705',
    'longitude': '80.21731685841294',
    'description': '',
    'street': 'Church Street'
  },
  {
    'type': 'commercial',
    'subtype': 'hotel',
    'image': 'images/placeImages/fortprinters_hotel.jpg',
    'title': 'Fort Printers',
    'latitude': '6.026172343333916',
    'longitude': '80.21799277511255',
    'description': '',
    'street': 'Pedlar Street'
  },
  {
    'type': 'commercial',
    'subtype': 'restaurant',
    'image': 'images/placeImages/indianhut_restaurant.jpg',
    'title': 'Indian Hut',
    'latitude': '6.024302835096089',
    'longitude': '80.21787945178211',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'commercial',
    'subtype': 'restaurant',
    'image': 'images/placeImages/pedlarsinn_restaurant.jpg',
    'title': 'Pedlar\'s Inn',
    'latitude': '6.026159339838067',
    'longitude': '80.21641496568044',
    'description': '',
    'street': 'Pedlar Street'
  },
  {
    'type': 'commercial',
    'subtype': 'restaurant',
    'image': 'images/placeImages/elita_restaurant.jpg',
    'title': 'Elita',
    'latitude': '6.028352928042274',
    'longitude': '80.21568523716557',
    'description': '',
    'street': 'Middle Street'
  },
  {
    'type': 'commercial',
    'subtype': 'restaurant',
    'image': 'images/placeImages/bastille_restaurant.jpg',
    'title': 'Bastille Galle Fort',
    'latitude': '6.026493620786293',
    'longitude': '80.21865812310297',
    'description': '',
    'street': 'Pedlar Street'
  },
  {
    'type': 'commercial',
    'subtype': 'restaurant',
    'image': 'images/placeImages/bastille_restaurant.jpg',
    'title': 'Bastille Galle Fort',
    'latitude': '6.026493620786293',
    'longitude': '80.21865812310297',
    'description': '',
    'street': 'Pedlar Street'
  },
  {
    'type': 'commercial',
    'subtype': 'shop',
    'image': 'images/placeImages/devasundara_shop.jpg',
    'title': 'Devasundara Gems and Jewellers',
    'latitude': '6.027327987644526',
    'longitude': '80.21617088463546',
    'description': '',
    'street': 'Lighthouse Street'
  },
  {
    'type': 'commercial',
    'subtype': 'shop',
    'image': 'images/placeImages/kkboutique_shop.jpg',
    'title': 'KK Boutique',
    'latitude': '6.027327987644526',
    'longitude': '80.21617088463546',
    'description': '',
    'street': 'Pedlars Street'
  },
  {
    'type': 'commercial',
    'subtype': 'shop',
    'image': 'images/placeImages/luna_shop.jpg',
    'title': 'Luna',
    'latitude': '6.0265684502118395',
    'longitude': '80.21605236452451',
    'description': '',
    'street': 'Parawa Street'
  },
  {
    'type': 'commercial',
    'subtype': 'shop',
    'image': 'images/placeImages/lankagems_shop.jpg',
    'title': 'Lanka Gems and Jewellery',
    'latitude': '6.024453959754429',
    'longitude': '80.21716908550502',
    'description': '',
    'street': 'Rampart Street'
  },
  {
    'type': 'commercial',
    'subtype': 'shop',
    'image': 'images/placeImages/sandaken_shop.jpg',
    'title': 'Sandaken Jewellers',
    'latitude': '6.026244733663945',
    'longitude': '80.21904795350807',
    'description': '',
    'street': 'Pedlar Street'
  },
  {
    'type': 'activities',
    'subtype': 'activity',
    'image': 'images/placeImages/dutch_bike.jpg',
    'title': 'Dutch Bike Rental',
    'latitude': '6.028464290999751',
    'longitude': '80.21551676088721',
    'description': '',
    'street': 'Middle Street'
  },
  {
    'type': 'activities',
    'subtype': 'activity',
    'image': 'images/placeImages/sithuvili_gallery.jpg',
    'title': 'Sithuvili Gallery',
    'latitude': '6.025956951780997',
    'longitude': '80.21885342891136',
    'description': '',
    'street': 'Layne Baan Street'
  },
  {
    'type': 'activities',
    'subtype': 'activity',
    'image': 'images/placeImages/walking_path.jpg',
    'title': 'Walking Path',
    'latitude': '6.025167921280009',
    'longitude': '80.21942917267361',
    'description': '',
    'street': 'Hospital Street'
  },
];
