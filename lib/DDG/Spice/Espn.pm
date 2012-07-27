package DDG::Spice::Espn;

use DDG::Spice;
use Time::localtime;

attribution web => ['http://dylansserver.com','Dylan Lloyd'],
            email => ['dylan@dylansserver.com','Dylan Lloyd'];

my %players = (
    "aaron adeoye" => 56385,
    "alan anderson" => 6569,
    "alex abraham" => 14347,
    "alex abreu" => 51011,
    "alexis abraham" => 10564,
    "al-farouq aminu" => 4248,
    "alvin abreu" => 36729,
    "andrea bargnani" => 2987,
    "andris biedrins" => 2427,
    "arron afflalo" => 3187,
    "ashley adams" => 10059,
    "ashley adams" => 14370,
    "ashley adams" => 16313,
    "austin akers" => 57393,
    "ben aird" => 52544,
    "betsy adams" => 10988,
    "bilqis abdul-qaadir" => 14186,
    "bisi addey" => 57365,
    "blake ahearn" => 3402,
    "bradley beal" => 6580,
    "brandon bass" => 2745,
    "carmelo anthony" => 1975,
    "chad adams" => 45804,
    "charles abouo" => 41276,
    "chris adams" => 56976,
    "chris andersen" => 1135,
    "c.j. aiken" => 51225,
    "cole aldrich" => 4267,
    "corin adams" => 7347,
    "danielle adams" => 12342,
    "danny agbelese" => 52110,
    "darrell arthur" => 3413,
    "david andersen" => 4205,
    "demetress adams" => 5305,
    "devonta abron" => 57090,
    "d.j. augustin" => 3415,
    "drew absher" => 53174,
    "dynese adams" => 14535,
    "earl barron" => 2477,
    "emmanuel addo" => 45595,
    "eso akunne" => 45975,
    "faisal aden" => 51420,
    "femi akinpetide" => 41404,
    "furkan aldemir" => 6577,
    "garrius adams" => 45527,
    "gilbert arenas" => 974,
    "gillian abshire" => 16934,
    "glenn akerland" => 57805,
    "god'sgift achiuwa" => 57020,
    "gustavo ayon" => 6546,
    "harrison barnes" => 6578,
    "ivy abiona" => 6714,
    "james anderson" => 4242,
    "jamie adams" => 9763,
    "jamye adair" => 11286,
    "janelle adams" => 10802,
    "jared accettura" => 57843,
    "jasmine abrams" => 12034,
    "jazmine adair" => 5602,
    "jeff adrien" => 4335,
    "jeremy adams" => 46003,
    "jerryd bayless" => 3417,
    "jessica adair" => 5601,
    "joel anthony" => 3247,
    "john adams" => 41308,
    "john adenrele" => 57440,
    "jordan aaberg" => 46624,
    "jose agosto" => 56773,
    "jose juan barea" => 3055,
    "justina adams" => 17166,
    "karli abbey" => 13940,
    "kazembe abif" => 56896,
    "keith benson" => 6425,
    "kelenna azubuike" => 2821,
    "kim adams" => 9172,
    "lamarcus aldridge" => 2983,
    "laquananisha adams" => 10311,
    "latisha adams" => 13850,
    "lauren aadland" => 6217,
    "lavoy allen" => 6424,
    "leandro barbosa" => 2166,
    "lebron james" => 1966,
    "lesley adams" => 11351,
    "louis amundson" => 3041,
    "luke adams" => 57292,
    "luke babbitt" => 4250,
    "madison absher" => 14494,
    "marco belinelli" => 3190,
    "marvin adu" => 52629,
    "maryann abrams" => 11135,
    "matt barnes" => 1765,
    "mauvolyene adams" => 9270,
    "maverick ahanmisi" => 51535,
    "michael beasley" => 3418,
    "mike bibby" => 61,
    "morris almond" => 3188,
    "mostafa abdel latif" => 56442,
    "natalie achonwa" => 13627,
    "nick achille" => 57517,
    "nicolas batum" => 3416,
    "nicole adams" => 15926,
    "nikko acosta" => 46906,
    "noruwa agho" => 41196,
    "o'karo akamune" => 56575,
    "omer asik" => 3414,
    "patrick ackerman" => 56228,
    "pete aguilar" => 57388,
    "quincy acy" => 6576,
    "rachel adaline" => 14827,
    "raja bell" => 49,
    "raphael akpejiori" => 51090,
    "ray allen" => 9,
    "remy abell" => 56223,
    "renaldo balkman" => 2986,
    "robert aery" => 47242,
    "rodrigue beaubois" => 3963,
    "ryan anderson" => 3412,
    "salah abdo" => 36726,
    "sarah acker" => 10042,
    "sarah acker" => 8036,
    "shane battier" => 976,
    "sherena abercrumbia" => 14929,
    "solomon alabi" => 4268,
    "taylor abt" => 56478,
    "teddy agbonwaneten" => 61007,
    "teeng akol" => 41088,
    "tiffanie adair" => 15226,
    "tola akomolafe" => 57485,
    "tony allen" => 2367,
    "tony battie" => 45,
    "tracy abrams" => 56643,
    "trevor ariza" => 2426,
    "vanessa abel" => 13369,
    "wale akinbobola" => 57187,
    "walt aikens" => 60885,
    "will adams" => 56251,
    "will barton" => 6579,
);

triggers any => keys %players;

spice to => 'http://api.espn.com/v1/sports/$1/$2/$3/$4/$5?enable=stats,competitors,roster,venues&$6=' . (localtime->year() + 1900) . '&apikey={{ENV{DDG_SPICE_ESPN_APIKEY}}}&callback=$7';

spice from => '(.*?)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)';

spice is_cached => 0;

handle query_lc => sub {
    return "basketball", "nba", "athletes", $players{$_}, "foo", "bar", "ddg_spice_espn";
};

1;
