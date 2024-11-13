'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "37835836d9b3ded88055e84fd01fdd55",
"assets/AssetManifest.bin.json": "130ff58f4018748386d61575be83c149",
"assets/AssetManifest.json": "5d7a63fed48cf40b3bac44b7cb57ceb4",
"assets/assets/01.png": "5a076b289ae47123f78b327d1c1f820c",
"assets/assets/02.png": "c382283a430e6f1b503fc66832317e87",
"assets/assets/03.png": "d1dc29ed1002a984a4a9c5f0dba21af6",
"assets/assets/04.png": "c6e49cef08c88bd1a26eb91ea19ece3f",
"assets/assets/05.png": "ccf852aa3d5c87056e2d4e40d6133617",
"assets/assets/activity.png": "f0bdbe2c81aa0cde85f1e7bfbd2a24f1",
"assets/assets/add-square.png": "163ddef99db1ad02b561f574693fa628",
"assets/assets/addpostst.png": "6534456339b7667bb79f4612514be1c0",
"assets/assets/apple.png": "f64c8ea5a9eac1a338cabd3a511de46a",
"assets/assets/archive-add.png": "cf2ef37d7bc1a613ba2b5ffb311e4bcd",
"assets/assets/archive-add1.png": "ad377593858774fa116d8365d396f2ec",
"assets/assets/archive-tick.png": "5292572fad711c7576048eadce4aff46",
"assets/assets/archive-tick1.png": "ff52de6c9160648b759ce3fe9df0a045",
"assets/assets/archive.png": "fa8f7a260a6b369df21eaf6899baba16",
"assets/assets/archive1.png": "f8b4a8001d33f64b2bdf07a5722b1401",
"assets/assets/archive2.png": "4d5e70bbd8518870db50bc917e621da3",
"assets/assets/archive3.png": "577056b91db432edcd1dce80136ca11e",
"assets/assets/arrow-down1.png": "f703020031700b375af9e850c38bd956",
"assets/assets/arrow-right.png": "38480e09c9cada074dabaf0f99fb695c",
"assets/assets/arrowdown.png": "d11a2e24c48e09396e4e0d1a0cd788ac",
"assets/assets/back.png": "40f5c8d33b18d57cd702ce8e86abe5c5",
"assets/assets/background.jpg": "91e16ca6714fd805077f5246389fac3c",
"assets/assets/Background.png": "9f0e37ba57135040523a96ff3d695094",
"assets/assets/background2.jpg": "94f13667df343f6db429feeeb442cc10",
"assets/assets/background3.jpg": "8913958923e0d14a96df17efdc740670",
"assets/assets/background4.jpg": "d890a138e876f217515611d7f1ea8963",
"assets/assets/background5.jpg": "dad5536e879a3949ff912f9eec441672",
"assets/assets/background6.jpg": "36fdc600e998d9dcadba132431a1e985",
"assets/assets/background7.jpg": "572ccdfeeb5f4b41ec081f3c39e3821d",
"assets/assets/background8.jpg": "5c4a6c844d7bea57ef59b84c69293c95",
"assets/assets/badge-check.png": "c7709dd22438375b99a340353d0313fc",
"assets/assets/Banner.png": "26c5d476ff9477bdd2bc6b10a4cfe8d9",
"assets/assets/Business.png": "0371c3922ee4e88f57ec2f3e3e71be19",
"assets/assets/Button.png": "539d7a1b15fa35ab608d34ee8fd357d4",
"assets/assets/calendar1.png": "92f595852688ab907dceaeabdff850e9",
"assets/assets/call.png": "ab46a7e598475f4cf573c4139ee2d17d",
"assets/assets/camera.png": "870bd50b1c6637937c4501bd91fce77e",
"assets/assets/camera1.png": "8c27fa07bcd7cdf175e10c3a635bb112",
"assets/assets/chat1.png": "33f3816cbc352ebfe72fd0409e683f77",
"assets/assets/chat2.png": "f442db20362ac8c73c15c570cdd186b9",
"assets/assets/chat3.png": "bb00ed170a641e94bc7ea80f868665ec",
"assets/assets/chat4.png": "b6a3866833953452d06b2c1ba9664ecd",
"assets/assets/chat5.png": "f20fcf745259eb77d9a7895fa044b0cc",
"assets/assets/chat6.png": "568cf03350a14a8383581029895ea920",
"assets/assets/clipboard-tick.png": "1520d8c82c675a171334edc54091f3e3",
"assets/assets/clock.png": "f78f68fc54854cdf9fa9bb4d18fe2adf",
"assets/assets/close.png": "30b18a389311c09b2c2f95cd44a3e3da",
"assets/assets/closefriends.png": "8646e0a635467cf6dc629816abbd6f28",
"assets/assets/colorfilter.png": "2b721a364c6d1cfe1821c3f51f04025b",
"assets/assets/colorfilter1.png": "e488e0c870c9fb60908b260b77178af4",
"assets/assets/comment.png": "53b82ad4ad10afb479b32686f2177e55",
"assets/assets/community.png": "4d3a9ef2b27d6147d653940a880422f9",
"assets/assets/copy-success.png": "a61f214da1c51ad6edb1e79de0d79f6b",
"assets/assets/Country1.png": "daefde5de11b30b1b6c80d6de6de0ce1",
"assets/assets/Country2.png": "3aeb88857a9b9994d2cec01dffca1a77",
"assets/assets/Country3.png": "2bd87dc97fb6c6e62c32d84d74be59f3",
"assets/assets/Country4.png": "a52afbb5f6f7259a3ee1a328e2c6b9a3",
"assets/assets/Country5.png": "4168038e5758fd2c66145b4584965e64",
"assets/assets/Country6.png": "f59caab106569835a47ba0c069759dd3",
"assets/assets/Country7.png": "dd25fcd2b5e017a98ec4a7c7d794328f",
"assets/assets/Country8.png": "cbec5755d7e5c3f31444b1fd727644b7",
"assets/assets/Crop.png": "363791057d76ccc792a3841ee8b0021f",
"assets/assets/Custom.png": "6bac4963f7b727d9a44460e4c4bf5bb7",
"assets/assets/design.png": "a87845d8b580740ee89b6cd19c7341ce",
"assets/assets/detail.png": "d64ebca876e8babe2897dcb1e2213392",
"assets/assets/direct.png": "099c61f66d284be782b149dc6e2cb120",
"assets/assets/document.png": "7567c86eec8bcbf4e5ff6c67eb0f14f4",
"assets/assets/education.png": "9dc5310df26e03618cb439c404342d3b",
"assets/assets/eye-slash.png": "1db3ad69c078a464a5e17e4020b02605",
"assets/assets/faceid.png": "86956a9182258d8357178da6a6d9face",
"assets/assets/fashion.png": "63936d12250f30cbb2df00b3e2908ff5",
"assets/assets/feedback.png": "7127664f636a9cfa11332a9696cde634",
"assets/assets/flash.png": "0a6173ee03fef3d0b93870aa8cf66a69",
"assets/assets/fluent_eye.png": "23d41b9f82224d184a06e75edeac4af0",
"assets/assets/fonts/MyriadPro/MyriadPro-Black.ttf": "06b251661dab072d9a51d3371827a1fb",
"assets/assets/fonts/MyriadPro/MyriadPro-Bold.ttf": "d5b486487376f7295854815db1a93224",
"assets/assets/fonts/MyriadPro/MyriadPro-Light.ttf": "f4bf8ccd575532aae5e5b07b1749de32",
"assets/assets/fonts/MyriadPro/MyriadPro-Regular.ttf": "be82e3850974c1ccddfcf305d93ad7ce",
"assets/assets/fonts/MyriadPro/MyriadPro-SemiBold.ttf": "e753d434a34f00b2afa45aa4771ecee2",
"assets/assets/food.png": "bd85811750cd2b89586cb53cc2da8690",
"assets/assets/football1.png": "e82a8e2d5d172dee6c5a6570c6ec8f5a",
"assets/assets/football2.png": "0ed137c24f847fec92d852059405bbf2",
"assets/assets/football3.png": "0837898503a2943e5f05aa32ede31447",
"assets/assets/forgot.png": "51ddb613f7f6dfc2c261483a27b86a32",
"assets/assets/forgot_ui.png": "f96817d49f1712b0c9679609ef1b7849",
"assets/assets/format-square.png": "ed1c5ea48576e7f4e14b4f426d569e1f",
"assets/assets/Frame%2520427321881.png": "320fa0fd2f35c2ae8ad64e8d74974975",
"assets/assets/Frame%2520427321882.png": "93f730c29fd520e63b88e90a05190dab",
"assets/assets/Frame%2520427321883.png": "bd2b38da0a6289c8ad0430bbc1020d60",
"assets/assets/Frame.png": "5c59742c583f2e6838c689c597982c52",
"assets/assets/Frame1.png": "d9c9c94cabe89930655a5985fd52c7f2",
"assets/assets/gallarry.png": "622dfacaf5e335b83fad4e1066165a5f",
"assets/assets/gallery-add.png": "5b1f9e774ea92962881b99d5b6fdf45e",
"assets/assets/gallery-tick.png": "e9a61a86c7982f025bda4e921dce4f97",
"assets/assets/gaming.png": "4d7092023515e3728bd69f83a4dcce75",
"assets/assets/getstarted.png": "aa5a8e89f2b84a7a53ee4c61517ad84a",
"assets/assets/global-search.png": "a000e1600e24fd8c059281c1b492412a",
"assets/assets/google.png": "55b29a029b116f2d51a0fb2abcfddb37",
"assets/assets/graduate.png": "76314bb36e41554f5fafc2a641b8f297",
"assets/assets/grid-1.png": "943dfdcf8ec29cc792008f1aaaa59ce9",
"assets/assets/grid5.png": "3a979e8ec8cbf22ff2d87e2183b6310f",
"assets/assets/happyemoji.png": "e9a225c5d777ad0ed84142460c39344f",
"assets/assets/hastag.png": "32c3db644c61e6b3e12eb585b167f25c",
"assets/assets/health.png": "3a86cfe44f5f2eaee99265d0fd118ceb",
"assets/assets/heart.png": "914524309a53054f47640428a70aa96d",
"assets/assets/heart1.png": "248f09423e87afda1342a3c5e51928db",
"assets/assets/heart2.png": "4c6ac139e0af968faf1c033c0b0059b3",
"assets/assets/hearts.png": "5a26c236064863a0756edd8b3ea45cb9",
"assets/assets/holiday.png": "2f79963c4043e7dd95840fb85adb47b2",
"assets/assets/home.png": "8830108f142f96356a6781d18c18e3fe",
"assets/assets/icons/bell.svg": "3e0d9bca0964cda807e44d715a37ddab",
"assets/assets/icons/chart_purple.svg": "7ac4c8358f7a3dad030030d7373986d2",
"assets/assets/icons/cup.svg": "70713fef09d5fc9d7aafec77f5b8efbb",
"assets/assets/icons/home.svg": "f005850bfa8b59669fcc158efc77f2e7",
"assets/assets/icons/new_user_blue.svg": "a69fb38dedc286d5919defb09aa13661",
"assets/assets/icons/rocket_orange.svg": "e51abbc304736dbd13d450170452e885",
"assets/assets/icons/setting-2.svg": "3e76bfebfdbb2ebb68752127d6f259db",
"assets/assets/icons/speedometer_yellow.svg": "43a3673d13114139dcaa4accc7f607c2",
"assets/assets/icons/stack.svg": "6297fc7bd4fb2d403a4507bf606f84db",
"assets/assets/icons/white_logo.svg": "c3c8224e613104ca8ddfe4cf38488adf",
"assets/assets/Illustration.png": "c7e05dea62f18ee82adadbe3573c0820",
"assets/assets/Images%252001.png": "a2710f9e483d517e63fb1d98bc76e380",
"assets/assets/Images%252002.png": "50752bd16f1341cc5ff60b2b19530b63",
"assets/assets/Images%252003.png": "65434b34ee328eff47151dc9c5896756",
"assets/assets/Images%252004.png": "b45c016980bf4afb828cfe5cb90a8d94",
"assets/assets/Images%252005.png": "5caa26cd71f2e0e0c411dd2a4cbfa1da",
"assets/assets/Images%252006.png": "db96ff5d92ac5f9c0547584bd694177e",
"assets/assets/Images%252007.png": "839fb52839169af2b5deeacfc2b06d45",
"assets/assets/Images%252008.png": "2624df356083f8783543f2383456fac4",
"assets/assets/Images%252009.png": "f9883f07ec4a311690fdff9fddd0f6c0",
"assets/assets/info-circle.png": "ab41d57af238290a01a5c47e915a0fc8",
"assets/assets/info-circle1.png": "b340a1087054d7d57ff701b663664642",
"assets/assets/infomation.png": "4e48416fa17b7d82734aea0f20c0db89",
"assets/assets/InstaStory.png": "92af65eab7b003e1e1e08b7021a20644",
"assets/assets/invite1.png": "ca20c065f169d4bd5e0891feb7dc16e2",
"assets/assets/invite2.png": "d28c85eee43c8aa936c7ebf2acec77a0",
"assets/assets/invite3.png": "2b5ca30cbf62bee4a7442a8a4017ba6d",
"assets/assets/invite4.png": "8bd58b4fdf94412b06a24c0d6b10a6e3",
"assets/assets/invite5.png": "150c999e2e70a665ce7a1267d9d2942f",
"assets/assets/invite6.png": "f7ba4217ddedd26da342eecc80383341",
"assets/assets/key.png": "df529cbc63389856fb8a997af5c6f903",
"assets/assets/LearnSphereLogo.png": "2a84cfb2225c6448d093e5224e461e42",
"assets/assets/like.png": "523c5b9832c4f7e52784e111b9002be6",
"assets/assets/live.png": "d25ee871a39eab56a46112328e5cc938",
"assets/assets/live1.png": "5d75fe2c0f00e80b66bb76cdf37cb9cf",
"assets/assets/live2.png": "f1a5ecb84bf1b6db6e563234f6ca951f",
"assets/assets/livep1.png": "9338079abb6d816124c512401b34b908",
"assets/assets/livep2.png": "476a5cec14e1cb69667a015d61276ed3",
"assets/assets/livep3.png": "09bd716dd5fdee31fe9fe266f540d111",
"assets/assets/livepic.png": "d0d2b7cdec22aba1f166be2a92b628b8",
"assets/assets/location-cross.png": "758df5fce5931fa281bd957b7a6f6fb6",
"assets/assets/location-tick.png": "316dd29b6ed5b9a860ef00041954d565",
"assets/assets/location.png": "b62d03b220b5c292dda16fe8ea73c31f",
"assets/assets/location1.png": "c069bd566770f130e13c7244fba8ad08",
"assets/assets/lock-circle.png": "cc81ce9d6018e6941a793365baa28fcd",
"assets/assets/lock.png": "f9599a54918b62aa49f922fc142d5e75",
"assets/assets/login.png": "c2f74610e4de1b1d1236aab0b414ad42",
"assets/assets/login_ui.png": "ed5acb854e467d95ea9b666e46a8ef8e",
"assets/assets/login_ui2.png": "fc24e5e521767fc8a7f92b1c6f5da957",
"assets/assets/ls2t.png": "81fb72b7d14d190d79388d27f61acaf4",
"assets/assets/LS2_transparent.png": "81fb72b7d14d190d79388d27f61acaf4",
"assets/assets/ls3.png": "6e1f40c285592a992ff56e588cdb43a0",
"assets/assets/ls3t.png": "40d4b65523b71a5779a31780285d4455",
"assets/assets/LS3_transparent.png": "40d4b65523b71a5779a31780285d4455",
"assets/assets/maximize-3.png": "a55b3b8f318b532e74a405042d7089a3",
"assets/assets/message.png": "f375c25433b29dcab6e83d49ecea6c7d",
"assets/assets/Messager.png": "de2cb89f0cdff27710d50211d09e0b88",
"assets/assets/messages.png": "aab5a00abc83a60243e637e6eebdff8a",
"assets/assets/mini-music-sqaure.png": "b7b32ea128ff1ad2597006143a6ea43d",
"assets/assets/movie.png": "da56c7675672c1d8010bdfa93a7c021a",
"assets/assets/music.png": "358d05494cb12c3ee1ef4782f892d557",
"assets/assets/newpost.png": "a9a1b028109a90581f105a7d29dd5a17",
"assets/assets/note.png": "6e3f0f81ef0d2058f3676fcdcfb56f30",
"assets/assets/notification.png": "21879d113f38c66beea4b8e3cb6f73b4",
"assets/assets/Onboarding1.png": "a1954654d75f14760ddda6fe0fc9b01f",
"assets/assets/Onboarding2.png": "6a12c98818106b34fca73853ed376c46",
"assets/assets/Onboarding3.png": "e682fe78165ecea0e6fd4ff983004159",
"assets/assets/option1.png": "df3c7ea73e95866535b285b22802989b",
"assets/assets/option2.png": "f3797181c23742a182dbc9ba9b0bd955",
"assets/assets/option3.png": "7ccfcd9b388e739f2e7db4c781fbad3a",
"assets/assets/option4.png": "8bcbc4b07550973bb54cb4b078314d90",
"assets/assets/Original.png": "5ae5dca083ca4e8d7add55eb5bf9dcd0",
"assets/assets/password.png": "c33146a83449052cb3443f7c23b619ca",
"assets/assets/people.png": "9a1521d773320239b872d98114dff2dd",
"assets/assets/peoshare.png": "a04d11619b22084341364d9a0527686f",
"assets/assets/photo.png": "641b9daa31781f2a8b07cd26ff19ebc3",
"assets/assets/play.png": "66102988ef4de1758b8093756e40704e",
"assets/assets/play1.png": "b2f420315cde8187ebdaba7c8216f373",
"assets/assets/Popular1.png": "a1606071aee21f4be3f67471f247390f",
"assets/assets/Popular2.png": "7260c1898e48cbd7dcc387e27381aa2d",
"assets/assets/Popular3.png": "12d223d4caa2de9395edd62c21a79524",
"assets/assets/Popular4.png": "a22a9124ba60c8ed59ec369bdaa4a010",
"assets/assets/Popular5.png": "5caa453b073796487229ee7137f048dc",
"assets/assets/Popular6.png": "959f7d9ab2e7d5032fb3c789e0c75b72",
"assets/assets/Post01.png": "b10772f4bc57c80ee51dc6b9b5f487f2",
"assets/assets/Post02.png": "275f66629fdd5c5f6afe8e6a941e6b4b",
"assets/assets/post1.1.png": "eca7eecfc8583399085505e9b6f96855",
"assets/assets/post1.2.png": "54426c8f4d689fcb3949f3ba1636e1b3",
"assets/assets/post1.3.png": "07ecdceab1eb6a199c12a94eab127e3d",
"assets/assets/post2.1.png": "08a738874993f2378c409cf7cbfaacb6",
"assets/assets/post2.2.png": "1307b3338acdfc720942a74c64f9280f",
"assets/assets/post2.3.png": "3291245db198249c2a3b8b0dfac918de",
"assets/assets/Post5.png": "90ce3fe69a91c15ef8a6f735f629887e",
"assets/assets/Post6.png": "155119a414631d024dd51ad9a9aef0c3",
"assets/assets/product1.png": "1b523ee29be4730750ec33fa4c352db0",
"assets/assets/product2.png": "1c2ea0b058839896ff03ea2e31b6c52e",
"assets/assets/product3.png": "23de5b4f064af132fefd2b9c35b65d5c",
"assets/assets/profile-2user.png": "ee44fde1149df49e27335d20065d1ca7",
"assets/assets/profile.png": "67bf3008d63a12864381b12645affef8",
"assets/assets/Rectangle%252022760.png": "b12ba1c0b3530352f7534afb42fc1f73",
"assets/assets/reel.png": "7bc6be0057c30c8143e66ce43d739565",
"assets/assets/reel1.png": "3ee6befb2737611b23d86a9d9c96da23",
"assets/assets/reel3.png": "8654d243949e073e9224ce2298ab2c7d",
"assets/assets/register3.png": "d1e7a8c334f970e417140b7dfca20b4d",
"assets/assets/register4.png": "da312c51761ed6544533d0f5ed401e14",
"assets/assets/register5.png": "6fb5656c1679a2c74fa6dbecb9668b53",
"assets/assets/repost.png": "6ecdc294968fd5343c64820e035d6a47",
"assets/assets/roatact.png": "09fc2cd8ff52795e23bcef2ead220217",
"assets/assets/sale1.png": "03a2cc4677d87b0835f26e32d7f9f0a0",
"assets/assets/sale2.png": "f8691e05cbf88a54a4b2cfca6812b145",
"assets/assets/save.png": "f744acc68f6a46ef8c2740cdc52dc514",
"assets/assets/science.png": "7922cd7a06ac91fd501796e85e1f1cf8",
"assets/assets/search.png": "73cdacf9b42eab5e26d8cfb6b06e84ae",
"assets/assets/security-time.png": "4aea2b3596d770fb839764b06c08eb99",
"assets/assets/security-user.png": "40e3a5963fb91defa9c917d4e067ef7d",
"assets/assets/send-2.png": "72e1813fadb2b60770de03eac6c85fca",
"assets/assets/send.png": "0e188110eff00acbde41e808a3d943de",
"assets/assets/setting-2.png": "004a456d90edc4c9cbea0bd3d3f0a464",
"assets/assets/setting-4.png": "ebf34611844899b474434942ebec1385",
"assets/assets/setting.png": "191f66dc28936f2b213b4b3d7e3c6358",
"assets/assets/setting1.png": "0b80185575ca59ad98c30f4ae0b2f408",
"assets/assets/Share.png": "493e9f2a1edcf77baa13e66651ca64e7",
"assets/assets/Share01.png": "f7512c15262215720391cc61422ca48e",
"assets/assets/Share03.png": "5c1b3bf2af1396064a7faed8e9c91e10",
"assets/assets/Share1.png": "40dc8669d0eeb5e2e9f6e2561de07c80",
"assets/assets/Share2.png": "d2fb3eafff56bffb8ece533ec30a927c",
"assets/assets/Share3.png": "25faa6dad3b68728dfb4b5227d87dbc5",
"assets/assets/Share4.png": "75b866f5c109c518ee1a0aeec64cd2d8",
"assets/assets/shopping-bag.png": "4d7ecc5cc0afd671df94f00850412430",
"assets/assets/shopping-bag1.png": "d67010bc81bb81ffed9f24567afac1e6",
"assets/assets/shopping-prod.png": "5c65ebd6ea83ed2fd99e07260cd330cc",
"assets/assets/Shutter.png": "50a3a8f7aa8c6389361e70c0a15d221f",
"assets/assets/sms-notification.png": "041f2864e94a32aedaa81dad89c7b590",
"assets/assets/soffty.png": "ccc7b26e5cec3f63f27833e6f6f53998",
"assets/assets/soffty1.png": "fe80b65ebf6c1d10c8925f54e6138f3e",
"assets/assets/soffty2..png": "409d292f5e91789a0c17f04f8db7d5ca",
"assets/assets/sport.png": "8e5cb1fcd476eff64e69e11f49dc5c9f",
"assets/assets/Stories%252003.png": "357fbad650c486bc05106a05b1752771",
"assets/assets/Stories1.png": "5cdeb04803d51c193683417aa8429364",
"assets/assets/stories2.png": "fa55a5c18c5e335aec33d044c0ae227e",
"assets/assets/story0.1.png": "c97f48cf6bdb3cde51644ff8903c00e2",
"assets/assets/story0.2.png": "826ffe66639db69657afb31726744ed3",
"assets/assets/story0.3.png": "713eb2330a4b50b83c46f6c5b15d5421",
"assets/assets/storyphoto.png": "72d11a84819d3d72aa8636ac25afaf30",
"assets/assets/storyphoto2.png": "202c8257ffb2f89e4415ccfd1655046c",
"assets/assets/Symmetric.png": "cef862e54e09e4fcbf8ffeb66d8e465b",
"assets/assets/tag-user.png": "f5a912fdbab43a4bbfeeb15217f7cd2e",
"assets/assets/tag-user1.png": "f64f2f0ca43b332574f51c122c10796d",
"assets/assets/tag-user2.png": "587ebbe0563dd034eb35087f5dba76ab",
"assets/assets/tag1.png": "a24d8f2bd5da37aebe8dbf2b7196bd04",
"assets/assets/tag2.png": "846b7fb17a05b6bc578074c637cb0ce4",
"assets/assets/textalign.png": "633fd226480ac9db0f008d13abdc76ee",
"assets/assets/tick-circle.png": "27abdfb35192fba6ba7daf1450624779",
"assets/assets/tilt.png": "e8ee3e4fd778b93412ad222b09639399",
"assets/assets/timer.png": "623b5a6cbdc38806f537346d5aba6bb3",
"assets/assets/travel.png": "26619901cc979f9e8716f526f56a80a2",
"assets/assets/tshirt.png": "a9ac77cbbb5fc81d9856ad839db04be8",
"assets/assets/tshirt3.png": "62e3452ea4fa9523bc374a7b0a6f1d1f",
"assets/assets/user.png": "f33a1c0d2ebf76781cff31030971ab34",
"assets/assets/verify1.png": "2ee262076aa4182cac7865714f80719a",
"assets/assets/verify3.png": "08794de63a41efeef3edf72161734f28",
"assets/assets/verify4.png": "ff333d20a204e64b94d0de28b0e0da23",
"assets/assets/video-play.png": "b8df536ca11c197e099ef557bc00373c",
"assets/assets/video-play1.png": "75fe2888f3c8d08ba762fa50a13292ec",
"assets/assets/video.png": "580eda2fe6f64db8bbceeaad36a0d32a",
"assets/assets/videoplay1.png": "8df375480a08c3cd44e9703143b03708",
"assets/assets/videoplay2.png": "d0af1c744758e4efc355d6cca98ce958",
"assets/FontManifest.json": "51c3f98398aae05bf4ef382c0955e102",
"assets/fonts/MaterialIcons-Regular.otf": "35162c585e194d150c8a198ff69115b4",
"assets/NOTICES": "359cf1ccd1cd8a6e16b63b784ea1fdeb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.ico": "8ff9ce9f50fe21d5d096237ca3ba2666",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "5b628de6cd1d5a121661a44746d03e63",
"icons/Icon-192.png": "1c4fa613d7f9bed334cecdece0754162",
"icons/Icon-512.png": "c802b80aa5ef85537b033494b4ccdfab",
"icons/Icon-maskable-192.png": "3805d119a5d2a814c295f9813bd3e850",
"icons/Icon-maskable-512.png": "247df5a7f213c5e9b505d371aae186f2",
"index.html": "3e2aab519dac1a4a861cc5b805baca55",
"/": "3e2aab519dac1a4a861cc5b805baca55",
"main.dart.js": "f49553c1844c45bc364c28ba07f885a5",
"manifest.json": "c57016103c86078ba93d18e981c2532e",
"version.json": "4abd423077107cbc82a5fa83c90f9226"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
