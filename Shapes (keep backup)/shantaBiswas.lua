local strokesData = {
  [1] = {
    x = { 226.38225787062, 226.38225787062, 226.38421691908, 226.3893833243, 226.40451872117, 226.44219589674, 226.50235625527, 226.57605148646, 226.65348935935, 226.73170207168, 226.80187373228, 226.8666514602, 226.9900115918, 227.12352677229, 227.28920266181, 227.38860318639, 227.50220337402, 227.63003219904, 227.7714546286, 227.92227920051, 228.08368102998, 228.2507367408, 228.42367349629, 228.60083423647, 228.78121916601, 228.96381837093, 229.15034622067, 229.34277981602, 229.53853994083, 229.73869214279, 229.94359328857, 230.15390239488, 230.37057819672, 230.59407604899, 230.82431891502, 231.0648263759, 231.31208832056, 231.57573165187, 231.86126242119, 232.17743485984, 232.51970453395, 232.89762863576, 233.30763622268, 233.7454124719, 234.19798683597, 234.66060018634, 235.11920658974, 235.57194304644, 236.01818285597, 236.46181206466, 236.90604271818, 237.35409099553, 237.80811427131, 238.26898383442, 238.73548102797, 239.20326498239, 239.67274779193, 240.13998685704, 240.60678204745, 241.07433018241, 241.54353681177, 242.01509367292, 242.48723371233, 242.96055702156, 243.43515490903, 243.91125737075, 244.38905963623, 244.9325329287, 245.4124503919, 245.8925676421, 246.36264167398, 246.83001936445, 247.30123234326, 247.78633203994, 248.28544184042, 248.79990279431, 249.33958029795, 249.8932368983, 250.46326201503, 251.04596564611, 251.63919639436, 252.25136504858, 252.86624730752, 253.48885055408, 254.12339659087, 254.76501748096, 255.41009479774, 256.0651494843, 256.72099013979, 257.37076346197, 258.00922279419, 258.63025429993, 259.24215687766, 259.84631737678, 260.43813943442, 261.0152027013, 261.57736949241, 262.12657022908, 262.67011794677, 263.21010207695, 263.74949387685, 264.28517171495, 264.81670284391, 265.3428943651, 265.86349128594, 266.38092443088, 266.89342141226, 267.4026519248, 267.90042928837, 268.38529743293, 268.85399574605, 269.30240583745, 269.72343148663, 270.1246268881, 270.50715099482, 270.86940520811, 271.22090929486, 271.55940824747, 271.89096044785, 272.21860523616, 272.53966006906, 272.85744200509, 273.17106125024, 273.47615775759, 273.77066151365, 274.05778373217, 274.33836750972, 274.60461986802, 274.85796461345, 275.09397993122, 275.311893421, 275.50647859552, 275.6712510315, 275.79415804513, 275.87281779112, 275.91274016575, 275.92272190162, 275.91280576408, 275.86374439669, 275.76145583628, 275.60366417275, 275.42858888768, 275.19144397366, 274.88625985894, 274.58040262352, 274.19740105031, 273.74118170587, 273.2336696091, 272.69828995511, 272.14801439879, 271.5899559822, 271.01676733827, 270.42760100126, 269.82442811526, 269.20625162248, 268.57801473192, 267.94419501409, 267.30299266323, 266.65482187883, 266.00049059758, 265.34963133601, 264.69208250925, 264.03095408056, 263.36290942259, 262.68307181201, 261.98288729894, 261.25712266501, 260.51079051017, 259.74568268809, 258.95659706552, 258.14566205218, 257.31460336924, 256.46741861134, 255.61139495021, 254.75138384206, 253.8916481623, 253.04032118942, 252.20177966289, 251.38066391364, 250.57200880685, 249.77860743278, 248.99737719724, 248.21697236487, 247.42876996353, 246.63269586419, 245.82584600782, 244.99526530269, 244.14233906422, 243.2637322364, 242.35837615411, 241.44343928496, 240.52178120483, 239.59500178522, 238.66783594553, 237.7415475499, 236.82417761589, 235.91217093346, 235.00069690437, 234.08889095316, 233.17906148131, 232.27522831164, 231.38180785003, 230.51508320981, 229.67963838251, 228.87618258968, 228.10848819924, 227.37030150872, 226.67238680192, 225.98982506618, 225.32434113139, 224.67131258089, 224.02126299908, 223.37121108054, 222.71388600718, 222.05473566759, 221.39442816275, 220.74471998665, 220.11068923643, 219.48345361075, 218.86327727456, 218.24466404505, 217.62588351399, 216.99275764464, 216.34824304298, 215.68575294621, 215.0094660225, 214.3252878431, 213.63491243502, 212.94494495371, 212.25464251364, 211.46221676061, 210.71605226771, 210.02078607464, 209.35724584417, 208.75903986886, 208.15985977256, 207.52842719704, 206.86752966848, 206.18678802641, 205.49388799495, 204.81481105304, 204.06323445794, 203.43706200415, 202.8554328219, 202.29276344996, 201.67323721399, 201.13540497585, 200.61122294048, 200.08488388229, 199.54161583062, 198.97798554904, 198.40411796729, 197.82114254521, 197.23811161169, 196.65476870586, 196.09151750022, 195.54673878841, 195.02965257707, 194.52140923565, 194.02329384873, 193.52884683574, 193.03725779925, 192.53994216084, 192.03790735311, 191.52776525402, 191.01444599248, 190.49915272833, 190.00593026634, 189.53282028901, 189.08408840639, 188.65726965543, 188.25764409515, 187.87377253244, 187.50604785403, 187.14752035647, 186.7874209966, 186.41677359851, 186.04812509253, 185.68048004604, 185.31447607551, 184.95041704272, 184.59318767936, 184.24832753082, 183.91858566939, 183.60821199386, 183.32028873629, 183.05551923007, 182.8073564253, 182.575590109, 182.35688170811, 182.14704226205, 181.94548497034, 181.74749858711, 181.55314790308, 181.36270505264, 181.17699588056, 180.99817878854, 180.82369767581, 180.65409032362, 180.48677735466, 180.32817423137, 180.17823179328, 180.03605978007, 179.89994565252, 179.76876175701, 179.64550111043, 179.53041497816, 179.42249926292, 179.32568710402, 179.24112086617, 179.17536199661, 179.13063856136, 179.10506793619, 179.09479194386, 179.09531653111, 179.10233369975, 179.11231498448, 179.14094571985, 179.19506611954, 179.2726015523, 179.38887165784, 179.51566641621, 179.63939527013, 179.78317891322, 179.94664237567, 180.13461446989, 180.34361278153, 180.56960036698, 180.81421535452, 181.08271960295, 181.38119345594, 181.71127763007, 182.06556899278, 182.44438483935, 182.853639276, 183.29215079212, 183.75821004886, 184.24625567849, 184.7475566851, 185.25906214691, 185.77639131079, 186.29836900678, 186.8227949996, 187.34845117137, 187.87979725789, 188.4897411817, 188.9984708646, 189.5081651495, 190.03899036644, 190.672607198, 191.22158258272, 191.78191773595, 192.36607155741, 192.98016555221, 193.60982615337, 194.25234922315, 194.89700256282, 195.53651736771, 196.17618592548, 196.81696401686, 197.45737123225, 198.10228706351, 198.74478003551, 199.4025374722, 200.07727414449, 200.77572627554, 201.50089734305, 202.27041442584, 203.07806333259, 203.92088395884, 204.80193471691, 205.71820837694, 206.67164822181, 207.66113218709, 208.67804125508, 209.71319161946, 210.75757510085, 211.81147011434, 212.87173913454, 213.93659669071, 215.00585547513, 216.08126265752, 217.17099345318, 218.27251531528, 219.3910660762, 220.5238121655, 221.66991026872, 222.83191638609, 224.01093883296, 225.2138078735, 226.4494224712, 227.72296348469, 229.03582917217, 230.37370307145, 231.73637391896, 233.12190181739, 234.52043839864, 235.91910469973, 237.29640626841, 238.63070158148, 239.90883666259, 241.12935304933, 242.28753635304, 243.38761860775, 244.43757097054, 245.43700404553, 246.3716087159, 247.26352600278, 248.11848700031, 248.94539206138, 249.74571300603, 250.39940145256, 251.06667475676, 251.75445992375, 252.46563032988, 253.18776582915, 253.89916474915, 254.59634112851, 255.27408290698, 255.9292082824, 256.55999383848, 257.17366838091, 257.76719568683, 258.33794922457, 258.88499435001, 259.41359733422, 259.93671488332, 260.54119217484, 261.13208568441, 261.64123256754, 262.1660024434, 262.70899460551, 263.29089142027, 263.91250502854, 264.5499338018, 265.18865149195, 265.81713902194, 266.4364082395, 267.03754599215, 267.61332632641, 268.11656273159, 268.69533209243, 269.23975127479, 269.74648711705, 270.21150696274, 270.65095315753, 271.07225933821, 271.48368337376, 271.82845934377, 272.19373759772, 272.59370631295, 273.02087698975, 273.4558104558, 273.89149164393, 274.24156956626, 274.60659033726, 274.99207309613, 275.31369721415, 275.66223715163, 275.95996216356, 276.28941265286, 276.6217257206, 276.94314192736, 277.24387209914, 277.47029877483, 277.71580885225, 277.9286612488, 278.17209197883, 278.42907461877, 278.68359256662, 278.8793991196, 279.04897177677, 279.21719689131, 279.35402644173, 279.48391388951, 279.56192989992, 279.60584524645, 279.6234295972, 279.62248806772, 279.60995005949, 279.59196560992, 279.50295684944, 279.3446982316, 279.11846618882, 278.81316075724, 278.42155798022, 277.83406371965, 277.14488871533, 276.52306308659, 275.88497822477, 275.20074580581, 274.43357382124, 273.38424959551, 272.38898746871, 271.36004817169, 270.26609570457, 269.05820316775, 267.70614554798, 266.1931640125, 264.54780118194, 262.78304462936, 260.91687229786, 258.7163009399, 256.72467460974, 254.82132475228, 252.93176133611, 251.0136715043, 249.03789614244, 246.98534644728, 244.84451815224, 242.61668478699, 240.30476472415, 237.91644130799, 235.46659960117, 232.97308567311, 230.44258402112, 227.89598106387, 225.33488793417, 222.76947130509, 220.19341773567, 217.3987974741, 214.97550226587, 212.41621060145, 209.79957075704, 207.16356817513, 204.52116828603, 201.89500701664, 199.29036132367, 196.72095391416, 194.19379140087, 191.7201811216, 189.31495724935, 186.99198828187, 184.77602940468, 182.35540248158, 180.40714205851, 178.72734207879, 177.24331194366, 175.88792499186, 174.63170987996, 173.45426845051, 172.3535407056, 171.34593463539, 170.43903405877, 169.64017088864, 168.95550442512, 168.38899672561, 167.96338669711, 167.69237537305, 167.56058091844, 167.534202458, 167.6759698533, 167.94626877187, 168.40906622368, 168.91535060115, 169.49509351683, 170.16809549767, 170.94283269151, 171.82612412853, 172.81519625354, 173.92266219016, 175.1468045034, 176.48246781163, 177.94015142738, 179.48482416417, 181.34345978612, 182.94112034565, 184.42727887238, 186.11315876169, 187.4776945457, 188.68059826325, 189.79268850963, 191.06821882384, 192.17111520683, 193.35135358124, 194.34867802883, 195.21205126227, 196.12549899901, 196.92675561116, 197.6465759824, 198.28444668604, 198.90452901675, 199.49816444089, 200.11226390409, 200.7329900816, 201.33103666433, 201.87051460126, 202.28341329311, 202.67650707854, 203.05027112166, 203.35945332991, 203.62769224647, 203.93080398736, 204.24863405652, 204.50955815514, 204.72665175437, 204.94624215176, 205.10576420525, 205.23873481066, 205.34345272556, 205.41052747029, 205.45580043752, 205.47760653423, 205.47951902626, 205.47267880297, 205.43997934484, 205.37328963132, 205.25519157574, 205.10066287174, 204.91667013442, 204.70553187136, 204.46395912594, 204.18947676266, 203.88178884423, 203.53483204951, 203.07243972199, 202.5871455964, 201.90840298902, 201.34646272125, 200.85762176646, 200.42591061992, 199.96039899133, 199.46168446469, 199.01147521967, 198.58571675588, 198.1894364596, 197.75429501593, 197.36513371024, 196.94778191692, 196.53509281652, 196.13439744746, 195.75789582093, 195.42386281864, 195.13077117596, 194.87543263292, 194.65080840211, 194.48566029584, 194.40824978899, 194.46964151442, 194.72477048093, 195.19353971916, 195.86747314008, 195.95005561613, 196.03651722864, 196.12685797761, 196.22107786305, 196.31917688495, 196.42115504332, 196.52701233815, 196.63674876944, 196.75036433719, 196.86785904141, 196.98923288209, 197.11448585923, 197.24361797284, 197.37662922291, 197.51351960944, 197.65428913243 },
    y = { 149.19405121522, 149.49539605841, 149.97970674366, 150.33460299473, 150.86636123161, 151.6779873027, 152.4986362104, 153.31227920376, 154.01013008807, 154.56597482964, 154.97750088717, 155.30459423064, 155.82262013054, 156.29215763325, 156.81864637987, 157.11712944515, 157.43918426325, 157.78345097671, 158.14310276639, 158.50657728098, 158.87732977427, 159.23786985774, 159.59162043029, 159.93378284381, 160.268987399, 160.59555345338, 160.91197488244, 161.22251092038, 161.52435297321, 161.81722953765, 162.09824186904, 162.36964626951, 162.63099713316, 162.87965232975, 163.11587555437, 163.34044796032, 163.55018074372, 163.75338189836, 163.95323796671, 164.15535445759, 164.35599449769, 164.56205748403, 164.77183878649, 164.98370484094, 165.19210810942, 165.39715956552, 165.58988438452, 165.76942458393, 165.93479999893, 166.08667664878, 166.22454251533, 166.3486282554, 166.45990716662, 166.5584160168, 166.64862290699, 166.73047491172, 166.8036127663, 166.86716899611, 166.92297572758, 166.97248036906, 167.01476071857, 167.04932513973, 167.07617248495, 167.09595692769, 167.10964245863, 167.11158143248, 167.09970894933, 167.06577492025, 167.01753857263, 166.95306748866, 166.87450493531, 166.77909378594, 166.66514741795, 166.53044304339, 166.37201920952, 166.19308799923, 165.99144990599, 165.76974804689, 165.52801334335, 165.26790613086, 164.98758306093, 164.68207316763, 164.35134445438, 163.98634893307, 163.58051674777, 163.13424467819, 162.64924156096, 162.12765557639, 161.58299885687, 161.02311328707, 160.45022076732, 159.86518336821, 159.26452488638, 158.64508193438, 158.00601221957, 157.34823947369, 156.67588724952, 155.98606880583, 155.27858901259, 154.55733031556, 153.82429695015, 153.08160887865, 152.33610302627, 151.58705702012, 150.83206294956, 150.06254926401, 149.27500882129, 148.47061202013, 147.65121604749, 146.81506811237, 145.96052203824, 145.08715880535, 144.19631134967, 143.2832544162, 142.34225247568, 141.3683568266, 140.34367161341, 139.29098239878, 138.20500138047, 137.08746894383, 135.94111184818, 134.77144970107, 133.58945182033, 132.4026475901, 131.21824835958, 130.03022339509, 128.84112248112, 127.65298956222, 126.46897912306, 125.28158551771, 124.07365716884, 122.837863426, 121.56902443815, 120.27801166725, 118.97031924381, 117.63679641235, 116.28694664395, 114.92119735382, 113.55858962215, 112.21440453278, 110.88642465199, 109.78096189209, 108.57553264992, 107.2713380528, 106.1581119345, 104.92916167312, 103.61988543747, 102.32578041255, 101.08998332313, 99.925702397263, 98.836146427083, 97.804976443059, 96.816111677415, 95.85880498611, 94.925624113959, 94.012058215175, 93.128779182692, 92.277562026112, 91.46209442922, 90.681696114754, 89.941102551172, 89.226503984836, 88.539645154346, 87.878133954572, 87.234717981576, 86.601966144577, 85.976944864792, 85.360267145706, 84.753812017105, 84.158335052819, 83.576398962989, 83.010839086372, 82.463168892354, 81.9397115931, 81.446742802368, 80.981639251219, 80.543889582157, 80.133586381478, 79.749614106125, 79.388196093362, 79.047863875534, 78.732683503846, 78.438536601448, 78.163410336412, 77.906003901269, 77.663870582209, 77.434074321945, 77.21813446037, 77.017148377514, 76.833030616934, 76.666052699678, 76.514033987199, 76.37728776793, 76.254917532452, 76.149303893184, 76.063470736097, 75.994246800345, 75.939495963933, 75.899927114486, 75.874738670817, 75.861566893049, 75.857401257651, 75.871037554024, 75.904314405101, 75.956477358619, 76.024683161492, 76.109095545072, 76.206392166693, 76.315999762468, 76.433304546285, 76.559414394794, 76.695644378139, 76.841156536249, 77.0002968962, 77.171153378512, 77.352430165655, 77.540685356533, 77.734509554026, 77.938917382941, 78.154781600131, 78.385110943905, 78.630562134059, 78.894764295183, 79.178646743446, 79.482421937549, 79.80289955668, 80.137779797471, 80.486240570706, 80.845111699325, 81.217666305723, 81.65651456064, 82.076146032881, 82.470434226607, 82.852140523896, 83.199042959948, 83.553072466477, 83.932126877616, 84.341288533464, 84.773854927807, 85.229627744044, 85.688620303677, 86.211275405678, 86.660420674729, 87.088213783639, 87.511052820711, 87.986932837872, 88.406519011378, 88.820881538031, 89.244840978641, 89.691382731498, 90.167838036678, 90.667820239568, 91.187396847816, 91.720274503739, 92.266056275031, 92.805669886879, 93.339741608766, 93.857376604395, 94.376161018587, 94.897285209683, 95.427122715996, 95.966041859844, 96.520183089446, 97.091257873343, 97.677948898415, 98.277134782212, 98.894139150481, 99.51353335507, 100.13377727225, 100.75199020367, 101.3712225301, 101.9890062308, 102.61978688803, 103.26439961523, 103.92994970886, 104.62409394016, 105.36321782393, 106.1241080424, 106.90544956328, 107.70351781764, 108.51403967081, 109.32405261558, 110.12696507235, 110.91669829475, 111.69673342702, 112.46588610578, 113.2312375241, 114.00095006759, 114.78181854374, 115.57763365881, 116.39128150117, 117.22133376401, 118.06426666444, 118.91713001366, 119.78044503391, 120.64313208405, 121.50430209623, 122.37251942137, 123.24881148407, 124.13342242879, 125.02390769145, 125.9237076311, 126.83990940154, 127.78537545868, 128.75841456064, 129.76264422369, 130.80332607808, 131.8966929825, 133.01230863859, 134.14597898369, 135.28672691991, 136.42712367255, 137.56553522766, 138.70359301381, 139.83454689487, 140.9548200773, 142.06465140076, 143.16683021729, 144.2746908038, 145.38410256774, 146.64677058557, 147.77733562299, 148.74565617941, 149.73387206287, 150.75679066492, 151.82585737413, 152.93609897673, 154.07079409323, 155.21762688261, 156.3809849221, 157.56378864088, 158.76295102868, 159.97490909356, 161.19555747564, 162.42604614122, 163.65969928983, 164.89111024242, 166.11321084345, 167.31117415412, 168.4806529251, 169.61240604897, 170.70532015979, 171.76502099888, 172.79907151504, 173.81005395918, 174.93885772081, 175.83975671872, 176.70826994014, 177.58182850852, 178.59818931086, 179.45675273521, 180.31466082705, 181.19122584415, 182.09684075913, 183.01005988468, 183.92313836643, 184.82011808725, 185.6915938187, 186.53863050485, 187.36342494356, 188.1622984941, 188.94050214431, 189.69078557766, 190.42954364723, 191.16088972982, 191.8910714071, 192.62279253512, 193.36397886325, 194.09973933183, 194.81555091676, 195.50853401373, 196.17479884606, 196.81694031603, 197.42938900061, 198.01237112772, 198.56533834823, 199.08905885593, 199.58524910617, 200.0559197259, 200.49894194212, 200.91937288862, 201.32151264518, 201.70707195685, 202.07494021729, 202.41958629002, 202.74604676234, 203.05447478139, 203.34156794117, 203.60175562106, 203.83722799618, 204.04943603704, 204.23765190292, 204.40319101671, 204.54730735072, 204.6752522851, 204.79166188333, 204.90075393474, 205.00937238602, 205.11836147359, 205.2295642095, 205.34279551568, 205.45449386579, 205.56820358156, 205.67900364226, 205.78997213895, 205.90284423675, 206.01284901277, 206.11964092903, 206.22668778381, 206.33479815987, 206.45048147796, 206.55621476672, 206.67452126417, 206.80960600842, 206.96935669372, 207.15289035995, 207.35957926553, 207.58711133193, 207.83774623729, 208.11358628478, 208.41056464226, 208.73280177796, 209.07784225579, 209.44489803658, 209.82759452455, 210.22784089676, 210.65304224795, 211.17542369493, 211.7126447487, 212.19338147719, 212.70418538267, 213.2464937855, 213.83979005578, 214.48466216488, 215.16093395417, 215.85946030062, 216.57181266398, 217.3003724729, 218.03752066087, 218.78013775689, 219.46592238732, 220.29872395798, 221.12301655122, 221.92941783516, 222.70381631357, 223.46821958986, 224.23252813746, 225.00813375312, 225.69093575991, 226.44945601968, 227.32442347715, 228.30681828873, 229.35878899259, 230.46126365185, 231.39977666631, 232.43766460723, 233.62059906015, 234.68890528151, 235.94751024802, 237.13840814187, 238.60577427472, 240.27562448646, 242.0211258331, 243.75562134287, 245.14262969833, 246.69901112526, 248.07687758798, 249.68824778224, 251.44942863964, 253.22020890036, 254.63924637549, 255.96679997446, 257.61652918005, 259.18989984152, 261.13531916542, 262.88606342106, 264.59789343255, 266.33556806974, 268.14379598101, 270.03331315002, 271.98753957965, 274.39897875572, 276.439160179, 278.34072194906, 280.20333414651, 282.10949479141, 284.52502647246, 287.04872954559, 289.11147219172, 291.06181885866, 292.96596101864, 294.90904852632, 297.31004729156, 299.38528602644, 301.34212777141, 303.23030839523, 305.11903266076, 307.04899499396, 309.06189375301, 311.12043514234, 313.20161411412, 315.28508558689, 317.61081349247, 319.61146452968, 321.43535813331, 323.14607971839, 324.77758349841, 326.35114099447, 327.86123726829, 329.30529815654, 330.67153922463, 331.9578811843, 333.16292250081, 334.28919227504, 335.33498038733, 336.28988480908, 337.15481020487, 337.92282727306, 338.58718177723, 339.13968754835, 339.59508616585, 339.84853661646, 339.98353987812, 339.95852293727, 339.75924024628, 339.37967467553, 338.821243587, 338.09204233273, 337.20443507673, 336.17448811093, 335.02180032078, 333.76810700761, 332.43804132109, 331.04326009463, 329.36488793308, 327.86345361747, 326.41659649485, 324.97690356716, 323.4930076395, 321.91881292907, 320.23020353953, 318.41326601927, 316.48004416801, 314.44070458861, 312.31062447975, 310.09103710149, 307.76661854375, 305.38533226166, 302.96361030519, 300.52152660507, 297.66509621733, 294.82965557815, 292.553967477, 290.10987597108, 288.14325625253, 286.33461136251, 284.5747839093, 282.79981560954, 280.98807044552, 279.14149081568, 277.25915923097, 275.35077369055, 273.44618198878, 271.54804649511, 269.71342433305, 267.69902643576, 266.12438404268, 264.78834348559, 263.4277120218, 262.44345525683, 261.66281065439, 261.01995847605, 260.37214845913, 259.88748401558, 259.44086796999, 259.12673466878, 258.90930687037, 258.73999590008, 258.64417757301, 258.59395927625, 258.58080982902, 258.59919355027, 258.65477601114, 258.75511919983, 258.90997594246, 259.12005081417, 259.38338544765, 259.6579489053, 260.00416768235, 260.4435212662, 260.92089869037, 261.4546065655, 262.19979574513, 263.20717111807, 264.22999739241, 265.25647493924, 266.51546480989, 267.70373697773, 268.90380867638, 270.12249993933, 271.24027707549, 272.48711224013, 273.80983562656, 274.87530706959, 275.75020730502, 276.66875549549, 277.47424094496, 278.33958746293, 279.1035772585, 279.79904298041, 280.43740934889, 281.05030932376, 281.65356820858, 282.24824477094, 282.84902816265, 283.56582105849, 284.23313691458, 285.0639278466, 285.67239518861, 286.14526440097, 286.51005963871, 286.85597034138, 287.17199450505, 287.41197388927, 287.60291153843, 287.74450691899, 287.87014945501, 287.94844502401, 287.99819835822, 288.00459673545, 287.96300009585, 287.86730242291, 287.71324238274, 287.49210007606, 287.18835600049, 286.7714938109, 286.2149518686, 285.48454783059, 284.55322895474, 283.44893017345, 282.21452278483, 280.92254902701, 280.76965165238, 280.62015482114, 280.47405853329, 280.33136278884, 280.19206758778, 280.05617293011, 279.92367881584, 279.79458524495, 279.66889221746, 279.54659973337, 279.42770779266, 279.31221639535, 279.20012554142, 279.0914352309, 278.98614546376, 278.88425624002 },
    pressure = { 0.75205331846946, 0.76873499906633, 0.85442864876063, 0.90287847414888, 0.95888160658163, 1.0203060678313, 1.0248725432535, 1.0202591181356, 1.0184449857943, 1.0211132371811, 1.0263198776781, 1.0309573209319, 1.0412235537179, 1.0516972496304, 1.0623990596424, 1.0667828386859, 1.0696249054694, 1.0724324259037, 1.0754555738591, 1.0794160206827, 1.0838543967437, 1.0878695259814, 1.0907948202984, 1.0932454113157, 1.0960146624284, 1.0980573654426, 1.1011551891683, 1.1041777031698, 1.1064690079213, 1.10805600121, 1.1095966368172, 1.110135772857, 1.1108833612135, 1.1108793989055, 1.1107591506104, 1.1111033565254, 1.1119407134793, 1.1137509507125, 1.1159451895605, 1.1189524231029, 1.1215221693335, 1.1246363455624, 1.1264134661109, 1.1287099819808, 1.1310173693886, 1.131993641861, 1.1344530834825, 1.1349639608084, 1.1349829610285, 1.1348060108421, 1.1346149847148, 1.1358700713048, 1.1370552083609, 1.1406877096164, 1.1450962021212, 1.1490848185576, 1.1545255456728, 1.1598734354423, 1.1684265563018, 1.1791186420233, 1.1919118550328, 1.2040192713318, 1.2129323082429, 1.2196704738966, 1.2257340049051, 1.2324470472985, 1.2386217541303, 1.2465254515199, 1.2518481406386, 1.25808179351, 1.2637025394475, 1.2674513410285, 1.2717491303744, 1.2754725264884, 1.2801449848033, 1.2865366324848, 1.293670674196, 1.301765608813, 1.3104745669143, 1.319509607611, 1.3268888560814, 1.3319392514731, 1.3351989129972, 1.3377166947114, 1.3429964932586, 1.3496821768717, 1.3577136639325, 1.3676214814742, 1.3763285090865, 1.3825847195698, 1.3863486593592, 1.3867029770753, 1.3873980631239, 1.3890755889791, 1.3912050465363, 1.3922946658063, 1.3925959818676, 1.3960402699929, 1.3995381951676, 1.4068266849901, 1.412264037885, 1.4142802350641, 1.4158423361879, 1.4131504503067, 1.4145502161684, 1.4185865873501, 1.4243046672325, 1.4307688071481, 1.4374141755477, 1.4440811282353, 1.4507471520566, 1.4598591240917, 1.4655978161628, 1.4686221740529, 1.4696731065121, 1.4698685600166, 1.4698828125, 1.4752023738258, 1.4822861316662, 1.4891391170604, 1.4986568914156, 1.5025435898659, 1.5058454665177, 1.5101091118055, 1.5116576248942, 1.516114543656, 1.5181994617877, 1.519867522747, 1.5248394698461, 1.5284416513297, 1.5293920228652, 1.5323718629529, 1.5352210898474, 1.5330640178094, 1.5362805203266, 1.5396562280299, 1.5419848139412, 1.5457442958356, 1.5516593975008, 1.5566811521747, 1.5626424032224, 1.5892860280236, 1.6039965260834, 1.6096947465626, 1.6306355332864, 1.6248328432142, 1.6180799107957, 1.6192398093051, 1.5970187610814, 1.5876214533433, 1.588305935665, 1.5889811121431, 1.5904505143361, 1.5911632497571, 1.59126953125, 1.5926163137692, 1.5946801734734, 1.5955462175557, 1.5982743225054, 1.5997755266338, 1.59881818518, 1.6005521855291, 1.5994630174215, 1.5983049199863, 1.597938038044, 1.595501598554, 1.5951439240669, 1.5955040685098, 1.5932242276688, 1.5904607778038, 1.5880628782238, 1.5870686862708, 1.5856212910897, 1.5860884039897, 1.587915502092, 1.5876113166255, 1.5870517423116, 1.5892681318172, 1.5895973315839, 1.5892711148753, 1.590230381407, 1.5909603373988, 1.591222813014, 1.592365823973, 1.5931443742751, 1.5934257495163, 1.5956997481054, 1.5995334080737, 1.6027940810181, 1.6053374945902, 1.6040829273119, 1.6004157502848, 1.5960670576027, 1.591647851105, 1.5907906294083, 1.5910740651214, 1.592412302175, 1.5932167571489, 1.5922795274371, 1.5903682811578, 1.5893607638357, 1.5890954093454, 1.5879298408813, 1.5871670047584, 1.5858247529993, 1.5839706751615, 1.5829202532166, 1.5825496805499, 1.5834215510533, 1.5860333469147, 1.5878624405821, 1.5887303531535, 1.5880864198674, 1.5855448595679, 1.5827349083759, 1.5820241545099, 1.5839717150862, 1.5865627226146, 1.5899933497381, 1.592137845671, 1.5922014804563, 1.5908481639966, 1.5906894571488, 1.5918704847328, 1.5938404141548, 1.5950800284659, 1.5955610730606, 1.5946536184591, 1.5918410249844, 1.5899594984093, 1.5891533689957, 1.5878828465597, 1.5893807048306, 1.5906188344452, 1.5910967800512, 1.5903013273162, 1.5895648609212, 1.5871872402335, 1.5865235995227, 1.5866202102655, 1.5857226009097, 1.5873811462808, 1.5863913636514, 1.5864022277451, 1.5866063022486, 1.5856959513889, 1.5870069690189, 1.5871905110405, 1.5880270418806, 1.5895796604229, 1.5916431382325, 1.5938846064522, 1.594124454334, 1.5917195964694, 1.5909599333835, 1.5910227426991, 1.590165436482, 1.5925048331007, 1.5934502578192, 1.5936263173945, 1.593543126512, 1.5925092046822, 1.5927180340124, 1.595152675359, 1.5969638700478, 1.5966707195389, 1.5960711603771, 1.5926072508917, 1.5912665547126, 1.5900608882724, 1.5893962708097, 1.5901543155019, 1.5908417242474, 1.5911678532469, 1.5902493520854, 1.5894813334094, 1.5891350607852, 1.5901478965666, 1.5920488198975, 1.5931218789414, 1.5945700761381, 1.5931198313765, 1.5906860613589, 1.5872107683192, 1.5853292167642, 1.5847482984815, 1.5846484375, 1.5867921851877, 1.5883490781098, 1.5889457372197, 1.5890625, 1.5901658264694, 1.5898394556736, 1.5893239083368, 1.5902368078494, 1.5898427090764, 1.5904506222822, 1.5898792518218, 1.5881661362526, 1.5860200579528, 1.5861116879418, 1.5877811346976, 1.588771986515, 1.590228894712, 1.591045244439, 1.588767057362, 1.5897633000893, 1.5896601185086, 1.5905341813059, 1.5911509866297, 1.59126953125, 1.5926373291935, 1.5919989691823, 1.5954802470563, 1.59891571135, 1.6013365648229, 1.6021845010188, 1.60364512136, 1.6017009500948, 1.598999347096, 1.5995468477012, 1.5985913062468, 1.5992586796221, 1.5998735236744, 1.6013304154386, 1.6021369344467, 1.6036394995398, 1.6057640979194, 1.6066152816296, 1.6081228795335, 1.6088392016346, 1.6146952064764, 1.6174684538551, 1.6206955083866, 1.6205608723611, 1.6185225617985, 1.6193101498218, 1.6169010789063, 1.6186438604425, 1.6198435362968, 1.6185031194839, 1.6192623454319, 1.6170544168974, 1.6143449305911, 1.6134430656686, 1.6117261043985, 1.612516924075, 1.613158491989, 1.6120661187456, 1.6127389476972, 1.6119617169885, 1.612583116521, 1.613178977047, 1.6120320652837, 1.6112672878598, 1.6111328125, 1.6124727390044, 1.6132090391862, 1.61333984375, 1.61333984375, 1.6146194618157, 1.6166457896617, 1.6188044130289, 1.6197503991564, 1.6199448410299, 1.6224619578163, 1.6227423889199, 1.6249083372047, 1.6262937268991, 1.6252484753963, 1.6312381985189, 1.6361817467652, 1.6375059204672, 1.6389995622517, 1.6369433994039, 1.6356056496931, 1.63541015625, 1.6312438508325, 1.62770580596, 1.6239240440638, 1.6223780654501, 1.6262935367626, 1.6270937498295, 1.6308349134756, 1.6342920336171, 1.6339168504873, 1.6361025479428, 1.6360255818609, 1.6354971871985, 1.6411345389155, 1.6424869743808, 1.6479946760349, 1.6521299651123, 1.6514972187741, 1.6493674018224, 1.6440331321452, 1.6421414470953, 1.6404646552607, 1.6414162786183, 1.6404600145062, 1.638382425649, 1.6391333578507, 1.6369312974531, 1.63969878309, 1.6416387330226, 1.6407563850439, 1.6412489331831, 1.6382773008108, 1.6373483961083, 1.6396523775823, 1.6402260686852, 1.6538319484957, 1.6658768336197, 1.6733180690463, 1.6764622499398, 1.6637374768957, 1.6520166437974, 1.6472682933797, 1.6482746886577, 1.6498049523023, 1.6515516151516, 1.6515727968307, 1.6521779814226, 1.6517272961728, 1.6503408609148, 1.6493246791191, 1.6488367948568, 1.6497560651924, 1.652733858798, 1.6523902936879, 1.6506747207839, 1.6493317848548, 1.6508659496668, 1.6579054043141, 1.6683289319995, 1.6831089524408, 1.6942837480041, 1.7021117122352, 1.7076681106408, 1.7087125842458, 1.7117054571157, 1.7154289174718, 1.7181254475374, 1.7240341321495, 1.7295553439597, 1.7365223523346, 1.7435750113565, 1.750364220426, 1.7688181407351, 1.7832640061828, 1.7926932349172, 1.7997157329653, 1.7868259974147, 1.7849041643349, 1.8053124106298, 1.8199835653214, 1.830194674802, 1.846395051293, 1.8469222641823, 1.8597376788877, 1.877177999937, 1.8757665316707, 1.8790990553108, 1.8767924982839, 1.8902567234777, 1.8973929156333, 1.9129025493772, 1.9183674226218, 1.9057130858596, 1.9096830464622, 1.9155024201448, 1.9338636488874, 1.9484074154552, 1.9693069053236, 1.9654114524168, 1.9652698243338, 1.9791388326027, 1.9854924367346, 2.0033162476111, 2.0118761925691, 2.014294630272, 1.9958239560404, 1.9912617367802, 1.9907686383578, 1.9922280140602, 2.0078077040961, 1.9994320352855, 1.9805345407262, 1.9832429395014, 1.9889297810909, 2.0078046540264, 2.0349197506437, 2.0356944986684, 2.042033062317, 2.0470379214671, 2.0513385431173, 2.0639199189528, 2.0678597863826, 2.0662531523879, 2.06578125, 2.0639537769659, 2.06357421875, 2.0549310585088, 2.050821861135, 2.0521748102892, 2.0507531695009, 2.0626782023048, 2.076351229388, 2.0790234375, 2.0825834478477, 2.0834375, 2.0762226860842, 2.0709798049084, 2.0720185392514, 2.0742295383409, 2.0819224612556, 2.092558120143, 2.0962913558921, 2.0930584671644, 2.0904612653519, 2.0841347764775, 2.0766035109179, 2.0780795743559, 2.0736698937422, 2.0706005678076, 2.0828857725537, 2.0929233474743, 2.09447265625, 2.0999693476729, 2.0919119624266, 2.0790352197762, 2.0731510532648, 2.0687594315044, 2.0661863927685, 2.0573036924342, 2.056953125, 2.055268644537, 2.0563578325168, 2.0630845552723, 2.0640762383531, 2.0605302509676, 2.0545260383936, 2.0542271629452, 2.0514808171898, 2.0454540100768, 2.0404422689785, 2.0325264037009, 2.025323564186, 2.0221230369512, 2.0147244613368, 1.9897820001831, 1.9691338837875, 1.9668472885397, 1.9483019540266, 1.9619485497258, 1.9815632291877, 1.9865086712924, 2.0012650737189, 2.0063534755414, 2.0031317126484, 2.0050276806975, 2.0077721992146, 2.0083792452746, 2.0083984375, 2.0083984375, 1.9836148258478, 1.9836987792564, 1.9793584262636, 1.9569896000203, 1.9640471365626, 1.9627473980437, 1.9582553585061, 1.9529710670633, 1.9488990874633, 1.9324272714888, 1.9236124964876, 1.9259265453187, 1.9207678111461, 1.9241760066584, 1.9264332513621, 1.9285692581055, 1.9291981488311, 1.9299907369944, 1.9268493410516, 1.9166191861072, 1.9087903533518, 1.897945720863, 1.8955147175126, 1.8945844262756, 1.8956450523087, 1.9047872011371, 1.9143463695857, 1.9239619172519, 1.9329662920409, 1.936602164781, 1.9396387992878, 1.942852161523, 1.9522683218659, 1.9591643473059, 1.9507933522006, 1.9546785980127, 1.949978417113, 1.9326623406636, 1.9355070490042, 1.9394124624272, 1.9405264797959, 1.9487699433428, 1.9466115804451, 1.9432725065114, 1.9520573749648, 1.9592678326862, 1.9720460053107, 1.9821321980465, 1.9880405470427, 1.992575330785, 1.9874662374189, 1.9839332838242, 1.9715038573022, 1.9683355171779, 1.9779195251274, 1.9827792422612, 1.9862052551255, 1.9782032120761, 1.9683650110036, 1.9615012703219, 1.9593848604533, 1.9571727315945, 1.9508546751833, 1.932192764212, 1.9017697445552, 1.8640317547732, 1.8169057355412, 1.7690217817726, 1.7168963988842, 1.6545260486878, 1.5745676084341, 1.4692678358699, 1.3356873489699, 1.1757482335318, 0.99786068204024, 0.90933909415893, 0.8038405485114, 0.79139592438569, 0.77895130025998, 0.76650667613426, 0.75406205200855, 0.74161742788284, 0.72917280375713, 0.71672817963141, 0.7042835555057, 0.69183893137999, 0.67939430725428, 0.66694968312856, 0.65450505900285, 0.64206043487714, 0.62961581075143, 0.61717118662571, 0.6047265625 },
    tool = "pen",
    color = 32768,
    width = 2.26,
    fill = -1,
    lineStyle = "plain",
  },
}
return strokesData   -- Return the strokesData table