import 'package:get/get.dart';

List eventCategories = [
  "Auto, Boat & Air",
  "Business & Professional",
  "Charities & Causes",
  "Community & Culture",
  "Family & Education",
  "Fashion & Beauty",
  "Film. Media & Entertainment",
  "Food & Drink",
  "Government & Politics",
  "Health & Wellness",
  "Hobbies & Special Interests",
  "Home & Lifestyle",
  "Music",
  "Performing & Visual Arts",
  "Religion & Spirituality",
  "School Activities",
  "Science & Technology",
  "Seasonal",
  "Sports & Fitness",
  "Travel & Outdoor",
];

RxList lauaConstants = [
  "Bradford",
  "Calderdale",
  "Leeds",
  "Kirklees",
  "Wakefield",
  "Aberdeen City",
  "Aberdeenshire",
  "Adur",
  "Allerdale",
  "Amber Valley",
  "Angus",
  "Antrim and Newtownabbey",
  "Ards and North Down",
  "Argyll and Bute",
  "Armagh City, Banbridge and Craigavon",
  "Arun",
  "Ashfield",
  "Ashford",
  "Babergh",
  "Barking and Dagenham",
  "Barnet",
  "Barnsley",
  "Barrow-in-Furness",
  "Basildon",
  "Basingstoke and Deane",
  "Bassetlaw",
  "Bath and North East Somerset",
  "Bedford",
  "Belfast",
  "Bexley",
  "Birmingham",
  "Blaby",
  "Blackburn with Darwen",
  "Blackpool",
  "Blaenau Gwent",
  "Bolsover",
  "Bolton",
  "Boston",
  "Bournemouth, Christchurch and Poole",
  "Bracknell Forest",
  "Braintree",
  "Breckland",
  "Brent",
  "Brentwood",
  "Bridgend",
  "Brighton and Hove",
  "Bristol, City of",
  "Broadland",
  "Bromley",
  "Bromsgrove",
  "Broxbourne",
  "Broxtowe",
  "Buckinghamshire",
  "Burnley",
  "Bury",
  "Caerphilly",
  "Cambridge",
  "Camden",
  "Cannock Chase",
  "Canterbury",
  "Cardiff",
  "Carlisle",
  "Carmarthenshire",
  "Castle Point",
  "Causeway Coast and Glens",
  "Central Bedfordshire",
  "Ceredigion",
  "Charnwood",
  "Chelmsford",
  "Cheltenham",
  "Cherwell",
  "Cheshire East",
  "Cheshire West and Chester",
  "Chesterfield",
  "Chichester",
  "Chorley",
  "City of Edinburgh",
  "City of London",
  "Clackmannanshire",
  "Colchester",
  "Conwy",
  "Copeland",
  "Corby",
  "Cornwall",
  "Cotswold",
  "County Durham",
  "Coventry",
  "Craven",
  "Crawley",
  "Croydon",
  "Dacorum",
  "Darlington",
  "Dartford",
  "Daventry",
  "Denbighshire",
  "Derby",
  "Derbyshire Dales",
  "Derry City and Strabane",
  "Doncaster",
  "Dorset",
  "Dover",
  "Dudley",
  "Dumfries and Galloway",
  "Dundee City",
  "Ealing",
  "East Ayrshire",
  "East Cambridgeshire",
  "East Devon",
  "East Dunbartonshire",
  "East Hampshire",
  "East Hertfordshire",
  "East Lindsey",
  "East Lothian",
  "East Northamptonshire",
  "East Renfrewshire",
  "East Riding of Yorkshire",
  "East Staffordshire",
  "East Suffolk",
  "Eastbourne",
  "Eastleigh",
  "Eden",
  "Elmbridge",
  "Enfield",
  "Epping Forest",
  "Epsom and Ewell",
  "Erewash",
  "Exeter",
  "Falkirk",
  "Fareham",
  "Fenland",
  "Fermanagh and Omagh",
  "Fife",
  "Flintshire",
  "Folkestone and Hythe",
  "Forest of Dean",
  "Fylde",
  "Gateshead",
  "Gedling",
  "Glasgow City",
  "Gloucester",
  "Gosport",
  "Gravesham",
  "Great Yarmouth",
  "Greenwich",
  "Guildford",
  "Gwynedd",
  "Hackney",
  "Halton",
  "Hambleton",
  "Hammersmith and Fulham",
  "Harborough",
  "Haringey",
  "Harlow",
  "Harrogate",
  "Harrow",
  "Hart",
  "Hartlepool",
  "Hastings",
  "Havant",
  "Havering",
  "Herefordshire, County of",
  "Hertsmere",
  "High Peak",
  "Highland",
  "Hillingdon",
  "Hinckley and Bosworth",
  "Horsham",
  "Hounslow",
  "Huntingdonshire",
  "Hyndburn",
  "Inverclyde",
  "Ipswich",
  "Isle of Anglesey",
  "Isle of Wight",
  "Isles of Scilly",
  "Islington",
  "Kensington and Chelsea",
  "Kettering",
  "King's Lynn and West Norfolk",
  "Kingston upon Hull, City of",
  "Kingston upon Thames",
  "Knowsley",
  "Lambeth",
  "Lancaster",
  "Leicester",
  "Lewes",
  "Lewisham",
  "Lichfield",
  "Lincoln",
  "Lisburn and Castlereagh",
  "Liverpool",
  "Luton",
  "Maidstone",
  "Maldon",
  "Malvern Hills",
  "Manchester",
  "Mansfield",
  "Medway",
  "Melton",
  "Mendip",
  "Merthyr Tydfil",
  "Merton",
  "Mid and East Antrim",
  "Mid Devon",
  "Mid Suffolk",
  "Mid Sussex",
  "Mid Ulster",
  "Middlesbrough",
  "Midlothian",
  "Milton Keynes",
  "Mole Valley",
  "Monmouthshire",
  "Moray",
  "Na h-Eileanan Siar",
  "Neath Port Talbot",
  "New Forest",
  "Newark and Sherwood",
  "Newcastle upon Tyne",
  "Newcastle-under-Lyme",
  "Newham",
  "Newport",
  "Newry, Mourne and Down",
  "North Ayrshire",
  "North Devon",
  "North East Derbyshire",
  "North East Lincolnshire",
  "North Hertfordshire",
  "North Kesteven",
  "North Lanarkshire",
  "North Lincolnshire",
  "North Norfolk",
  "North Somerset",
  "North Tyneside",
  "North Warwickshire",
  "North West Leicestershire",
  "Northampton",
  "Northumberland",
  "Norwich",
  "Nottingham",
  "Nuneaton and Bedworth",
  "Oadby and Wigston",
  "Oldham",
  "Orkney Islands",
  "Oxford",
  "Pembrokeshire",
  "Pendle",
  "Perth and Kinross",
  "Peterborough",
  "Plymouth",
  "Portsmouth",
  "Powys",
  "Preston",
  "Reading",
  "Redbridge",
  "Redcar and Cleveland",
  "Redditch",
  "Reigate and Banstead",
  "Renfrewshire",
  "Rhondda Cynon Taf",
  "Ribble Valley",
  "Richmond upon Thames",
  "Richmondshire",
  "Rochdale",
  "Rochford",
  "Rossendale",
  "Rother",
  "Rotherham",
  "Rugby",
  "Runnymede",
  "Rushcliffe",
  "Rushmoor",
  "Rutland",
  "Ryedale",
  "Salford",
  "Sandwell",
  "Scarborough",
  "Scottish Borders",
  "Sedgemoor",
  "Sefton",
  "Selby",
  "Sevenoaks",
  "Sheffield",
  "Shetland Islands",
  "Shropshire",
  "Slough",
  "Solihull",
  "Somerset West and Taunton",
  "South Ayrshire",
  "South Cambridgeshire",
  "South Derbyshire",
  "South Gloucestershire",
  "South Hams",
  "South Holland",
  "South Kesteven",
  "South Lakeland",
  "South Lanarkshire",
  "South Norfolk",
  "South Northamptonshire",
  "South Oxfordshire",
  "South Ribble",
  "South Somerset",
  "South Staffordshire",
  "South Tyneside",
  "Southampton",
  "Southend-on-Sea",
  "Southwark",
  "Spelthorne",
  "St Albans",
  "St. Helens",
  "Stafford",
  "Staffordshire Moorlands",
  "Stevenage",
  "Stirling",
  "Stockport",
  "Stockton-on-Tees",
  "Stoke-on-Trent",
  "Stratford-on-Avon",
  "Stroud",
  "Sunderland",
  "Surrey Heath",
  "Sutton",
  "Swale",
  "Swansea",
  "Swindon",
  "Tameside",
  "Tamworth",
  "Tandridge",
  "Teignbridge",
  "Telford and Wrekin",
  "Tendring",
  "Test Valley",
  "Tewkesbury",
  "Thanet",
  "Three Rivers",
  "Thurrock",
  "Tonbridge and Malling",
  "Torbay",
  "Torfaen",
  "Torridge",
  "Tower Hamlets",
  "Trafford",
  "Tunbridge Wells",
  "Uttlesford",
  "Vale of Glamorgan",
  "Vale of White Horse",
  "Walsall",
  "Waltham Forest",
  "Wandsworth",
  "Warrington",
  "Warwick",
  "Watford",
  "Waverley",
  "Wealden",
  "Wellingborough",
  "Welwyn Hatfield",
  "West Berkshire",
  "West Devon",
  "West Dunbartonshire",
  "West Lancashire",
  "West Lindsey",
  "West Lothian",
  "West Oxfordshire",
  "West Suffolk",
  "Westminster",
  "Wigan",
  "Wiltshire",
  "Winchester",
  "Windsor and Maidenhead",
  "Wirral",
  "Woking",
  "Wokingham",
  "Wolverhampton",
  "Worcester",
  "Worthing",
  "Wrexham",
  "Wychavon",
  "Wyre Forest",
  "Wyre",
  "York",
].obs;

List lauaDocID = [
  "S12000033",
  "S12000034",
  "E07000223",
  "E07000026",
  "E07000032",
  "S12000041",
  "N09000001",
  "N09000011",
  "S12000035",
  "N09000002",
  "E07000224",
  "E07000170",
  "E07000105",
  "E07000200",
  "E09000002",
  "E09000003",
  "E08000016",
  "E07000027",
  "E07000066",
  "E07000084",
  "E07000171",
  "E06000022",
  "E06000055",
  "N09000003",
  "E09000004",
  "E08000025",
  "E07000129",
  "E06000008",
  "E06000009",
  "W06000019",
  "E07000033",
  "E08000001",
  "E07000136",
  "E06000058",
  "E06000036",
  "E08000032",
  "E07000067",
  "E07000143",
  "E09000005",
  "E07000068",
  "W06000013",
  "E06000043",
  "E06000023",
  "E07000144",
  "E09000006",
  "E07000234",
  "E07000095",
  "E07000172",
  "E06000060",
  "E07000117",
  "E08000002",
  "W06000018",
  "E08000033",
  "E07000008",
  "E09000007",
  "E07000192",
  "E07000106",
  "W06000015",
  "E07000028",
  "W06000010",
  "E07000069",
  "N09000004",
  "E06000056",
  "W06000008",
  "E07000130",
  "E07000070",
  "E07000078",
  "E07000177",
  "E06000049",
  "E06000050",
  "E07000034",
  "E07000225",
  "E07000118",
  "S12000036",
  "E09000001",
  "S12000005",
  "E07000071",
  "W06000003",
  "E07000029",
  "E07000150",
  "E06000052",
  "E07000079",
  "E06000047",
  "E08000026",
  "E07000163",
  "E07000226",
  "E09000008",
  "E07000096",
  "E06000005",
  "E07000107",
  "E07000151",
  "W06000004",
  "E06000015",
  "E07000035",
  "N09000005",
  "E08000017",
  "E06000059",
  "E07000108",
  "E08000027",
  "S12000006",
  "S12000042",
  "E09000009",
  "S12000008",
  "E07000009",
  "E07000040",
  "S12000045",
  "E07000085",
  "E07000242",
  "E07000137",
  "S12000010",
  "E07000152",
  "S12000011",
  "E06000011",
  "E07000193",
  "E07000244",
  "E07000061",
  "E07000086",
  "E07000030",
  "E07000207",
  "E09000010",
  "E07000072",
  "E07000208",
  "E07000036",
  "E07000041",
  "S12000014",
  "E07000087",
  "E07000010",
  "N09000006",
  "S12000047",
  "W06000005",
  "E07000112",
  "E07000080",
  "E07000119",
  "E08000037",
  "E07000173",
  "S12000049",
  "E07000081",
  "E07000088",
  "E07000109",
  "E07000145",
  "E09000011",
  "E07000209",
  "W06000002",
  "E09000012",
  "E06000006",
  "E07000164",
  "E09000013",
  "E07000131",
  "E09000014",
  "E07000073",
  "E07000165",
  "E09000015",
  "E07000089",
  "E06000001",
  "E07000062",
  "E07000090",
  "E09000016",
  "E06000019",
  "E07000098",
  "E07000037",
  "S12000017",
  "E09000017",
  "E07000132",
  "E07000227",
  "E09000018",
  "E07000011",
  "E07000120",
  "S12000018",
  "E07000202",
  "W06000001",
  "E06000046",
  "E06000053",
  "E09000019",
  "E09000020",
  "E07000153",
  "E07000146",
  "E06000010",
  "E09000021",
  "E08000034",
  "E08000011",
  "E09000022",
  "E07000121",
  "E08000035",
  "E06000016",
  "E07000063",
  "E09000023",
  "E07000194",
  "E07000138",
  "N09000007",
  "E08000012",
  "E06000032",
  "E07000110",
  "E07000074",
  "E07000235",
  "E08000003",
  "E07000174",
  "E06000035",
  "E07000133",
  "E07000187",
  "W06000024",
  "E09000024",
  "N09000008",
  "E07000042",
  "E07000203",
  "E07000228",
  "N09000009",
  "E06000002",
  "S12000019",
  "E06000042",
  "E07000210",
  "W06000021",
  "S12000020",
  "S12000013",
  "W06000012",
  "E07000091",
  "E07000175",
  "E08000021",
  "E07000195",
  "E09000025",
  "W06000022",
  "N09000010",
  "S12000021",
  "E07000043",
  "E07000038",
  "E06000012",
  "E07000099",
  "E07000139",
  "S12000050",
  "E06000013",
  "E07000147",
  "E06000024",
  "E08000022",
  "E07000218",
  "E07000134",
  "E07000154",
  "E06000057",
  "E07000148",
  "E06000018",
  "E07000219",
  "E07000135",
  "E08000004",
  "S12000023",
  "E07000178",
  "W06000009",
  "E07000122",
  "S12000048",
  "E06000031",
  "E06000026",
  "E06000044",
  "W06000023",
  "E07000123",
  "E06000038",
  "E09000026",
  "E06000003",
  "E07000236",
  "E07000211",
  "S12000038",
  "W06000016",
  "E07000124",
  "E09000027",
  "E07000166",
  "E08000005",
  "E07000075",
  "E07000125",
  "E07000064",
  "E08000018",
  "E07000220",
  "E07000212",
  "E07000176",
  "E07000092",
  "E06000017",
  "E07000167",
  "E08000006",
  "E08000028",
  "E07000168",
  "S12000026",
  "E07000188",
  "E08000014",
  "E07000169",
  "E07000111",
  "E08000019",
  "S12000027",
  "E06000051",
  "E06000039",
  "E08000029",
  "E07000246",
  "S12000028",
  "E07000012",
  "E07000039",
  "E06000025",
  "E07000044",
  "E07000140",
  "E07000141",
  "E07000031",
  "S12000029",
  "E07000149",
  "E07000155",
  "E07000179",
  "E07000126",
  "E07000189",
  "E07000196",
  "E08000023",
  "E06000045",
  "E06000033",
  "E09000028",
  "E07000213",
  "E07000240",
  "E08000013",
  "E07000197",
  "E07000198",
  "E07000243",
  "S12000030",
  "E08000007",
  "E06000004",
  "E06000021",
  "E07000221",
  "E07000082",
  "E08000024",
  "E07000214",
  "E09000029",
  "E07000113",
  "W06000011",
  "E06000030",
  "E08000008",
  "E07000199",
  "E07000215",
  "E07000045",
  "E06000020",
  "E07000076",
  "E07000093",
  "E07000083",
  "E07000114",
  "E07000102",
  "E06000034",
  "E07000115",
  "E06000027",
  "W06000020",
  "E07000046",
  "E09000030",
  "E08000009",
  "E07000116",
  "E07000077",
  "W06000014",
  "E07000180",
  "E08000036",
  "E08000030",
  "E09000031",
  "E09000032",
  "E06000007",
  "E07000222",
  "E07000103",
  "E07000216",
  "E07000065",
  "E07000156",
  "E07000241",
  "E06000037",
  "E07000047",
  "S12000039",
  "E07000127",
  "E07000142",
  "S12000040",
  "E07000181",
  "E07000245",
  "E09000033",
  "E08000010",
  "E06000054",
  "E07000094",
  "E06000040",
  "E08000015",
  "E07000217",
  "E06000041",
  "E08000031",
  "E07000237",
  "E07000229",
  "W06000006",
  "E07000238",
  "E07000239",
  "E07000128",
  "E06000014",
];
