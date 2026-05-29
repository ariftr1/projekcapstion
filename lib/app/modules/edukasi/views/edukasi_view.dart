import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edukasi_controller.dart';

class EdukasiView extends GetView<EdukasiController> {
  const EdukasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: CustomScrollView(
        slivers: [
          // 1. HEADER AREA
          SliverAppBar(
            expandedHeight: 100, // Dikembalikan ke 150 agar gradiennya terlihat bagus
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF2052D9),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                "Pusat Edukasi Mata",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2052D9), Color(0xFF6A11CB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // 2. KATEGORI TAB
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => Row(
                children: [
                  _buildTabButton(0, "Tips Harian", Icons.auto_awesome),
                  const SizedBox(width: 12),
                  _buildTabButton(1, "Artikel Medis", Icons.menu_book_rounded),
                ],
              )),
            ),
          ),

          // 3. DAFTAR KARTU EDUKASI (Dinamic berdasarkan Tab)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: Obx(() {
              
              // ==========================================
              // JIKA TAB 0 (TIPS HARIAN) YANG DIPILIH
              // ==========================================
              if (controller.selectedCategory.value == 0) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    
                    // Kartu 1
                    _buildEdukasiCard(
                      context,
                      title: "Aturan Emas 20-20-20",
                      desc: "Metode paling efektif mencegah kelelahan otot siliaris. Istirahatkan matamu setiap 20 menit sekali.",
                      category: "TIPS POPULER",
                      imagePath: 'assets/images/edukasi1.png',
                      fullText: "Metode 20-20-20 diciptakan oleh seorang optometris dari California bernama Dr. Jeffrey Anshel.\n\n"
                                "Saat kita menatap layar digital (laptop/HP) dari jarak dekat, otot siliaris di dalam mata harus terus berkontraksi untuk mempertahankan fokus lensa. Jika dilakukan berjam-jam, otot ini akan mengalami 'spasme' atau kram, yang memicu miopia (rabun jauh) sementara atau bahkan permanen.\n\n"
                                "Cara kerjanya:\n"
                                "• Setiap 20 menit menatap layar.\n"
                                "• Alihkan pandangan sejauh minimal 20 kaki (sekitar 6 meter).\n"
                                "• Tahan pandangan ke kejauhan selama 20 detik.\n\n"
                                "Kenapa harus 20 detik? Karena butuh waktu sekitar 20 detik bagi otot-otot di mata kita untuk benar-benar rileks sepenuhnya.",
                    ),
                    
                    // Kartu 2
                    _buildEdukasiCard(
                      context,
                      title: "Jarak Aman Layar Laptop",
                      desc: "Pastikan jarak antara mata dan layar laptop Anda sekitar 50-60 cm (sepanjang satu lengan penuh).",
                      category: "ERGONOMI",
                      imagePath: 'assets/images/edukasi2.png',
                      fullText: "Ergonomi jarak layar seringkali diabaikan, padahal ini adalah penyebab utama Computer Vision Syndrome (CVS).\n\n"
                                "Mata manusia secara alami didesain untuk melihat jarak jauh. Semakin dekat sebuah objek, semakin keras mata harus bekerja (melakukan konvergensi dan akomodasi).\n\n"
                                "Aturan Jarak yang Benar:\n"
                                "1. Jarak Ideal: Rentangkan satu tangan penuh ke depan Anda saat duduk di depan laptop. Ujung jari Anda harusnya baru menyentuh layar (sekitar 50-75 cm).\n"
                                "2. Sudut Pandang: Bagian atas pinggiran layar (bezel) harus sejajar dengan ketinggian mata Anda. Layar harus dimiringkan sekitar 10-20 derajat ke belakang.\n\n"
                                "Jika layar terlalu dekat, bukan hanya mata yang lelah, tapi leher dan bahu Anda juga akan tanpa sadar menjorok ke depan (postur 'turtle neck') yang menyebabkan nyeri tulang belakang kronis.",
                    ),
                    
                    // Kartu 3
                    _buildEdukasiCard(
                      context,
                      title: "Bahaya Lupa Berkedip",
                      desc: "Saat fokus menatap layar, frekuensi kedipan kita turun drastis. Ini memicu sindrom mata kering (Dry Eye).",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi3.png',
                      fullText: "Berkedip adalah mekanisme pertahanan alami tubuh untuk melumasi bola mata, membersihkan debu, dan mengistirahatkan sel fotoreseptor sejenak.\n\n"
                                "Fakta Medis yang Mengejutkan:\n"
                                "Dalam kondisi normal, manusia berkedip sekitar 15 hingga 20 kali per menit. Namun, saat menatap layar digital (bermain game, coding, atau menonton), tingkat kedipan kita anjlok hingga hanya 5-7 kali per menit!\n\n"
                                "Dampak Kurang Kedip:\n"
                                "Karena mata jarang berkedip, lapisan air mata (tear film) akan menguap lebih cepat. Ini menyebabkan sindrom Mata Kering (Dry Eye Syndrome). Gejalanya meliputi mata terasa perih, berpasir, merah, dan pandangan yang sering kabur mendadak.\n\n"
                                "Solusi:\n"
                                "Biasakan melakukan 'Full Blink' (kedipan penuh). Pastikan kelopak mata atas dan bawah Anda benar-benar bersentuhan saat berkedip.",
                    ),
                    
                    // Kartu 4
                    _buildEdukasiCard(
                      context,
                      title: "Aktivitas Luar Ruangan sebagai Pencegahan Myopia",
                      desc: "Tahukah Anda bahwa kebiasaan anak yang lebih banyak menghabiskan waktu di dalam ruangan ternyata menjadi salah satu penyebab utama meningkatnya kasus miopia?",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi4.png',
                      fullText: "  Tahukah Anda bahwa kebiasaan anak yang lebih banyak menghabiskan waktu di dalam ruangan ternyata menjadi salah satu penyebab utama meningkatnya kasus miopia di seluruh dunia? Prevalensi miopia diprediksi akan mengalami peningkatan yang sangat signifikan pada tahun 2050, dan peningkatan tersebut salah satunya disebabkan karena adanya perubahan gaya hidup yang menyebabkan terjadinya penurunan aktivitas di luar ruangan pada anak-anak. Ini adalah alarm besar yang seharusnya mendorong kita semua — orang tua, guru, maupun tenaga kesehatan — untuk segera mengambil tindakan nyata. Jangan tunggu sampai anak harus memakai kacamata tebal sebelum kita peduli terhadap kesehatan mata mereka.\n\n"
                                "  Kabar baiknya, ada cara pencegahan yang sederhana, menyenangkan, dan tidak memerlukan biaya mahal sama sekali, yaitu dengan memperbanyak waktu bermain dan beraktivitas di luar ruangan. Kegiatan luar ruangan diperkirakan mampu mengeliminasi area defocus di seluruh lapang pandang yang berperan sebagai sinyal stop terhadap pertumbuhan mata, sehingga secara langsung dapat menghambat perkembangan miopia pada anak. Bayangkan betapa besar manfaat yang bisa diperoleh hanya dari aktivitas sederhana seperti berlari, bersepeda, atau sekadar bermain di halaman sekolah setiap harinya.\n\n"
                                "  Oleh karena itu, sudah saatnya kita bersama-sama mendorong anak-anak untuk lebih sering beraktivitas di luar ruangan sebagai bentuk investasi jangka panjang bagi kesehatan mata mereka. Peningkatan waktu aktivitas luar ruangan, terutama ketika disertai dengan intensitas paparan cahaya outdoor yang tinggi, dapat menjadi salah satu strategi paling efektif dalam mencegah timbulnya miopia dan memperlambat laju progresinya — bersifat non-invasif, tidak membutuhkan biaya besar, dan relatif mudah untuk diterapkan sebagai solusi praktis bagi anak yang berisiko mengalami miopia. Mari jadikan aktivitas luar ruangan sebagai bagian dari rutinitas harian anak, karena langkah kecil hari ini akan melindungi penglihatan mereka seumur hidup!",
                    ),
                    
                    // Kartu 5
                    _buildEdukasiCard(
                      context,
                      title: "Jarak Baca Minimal 30 cm sebagai Pencegahan Myopia",
                      desc: "Kebiasaan ini terlihat sepele, namun dampaknya terhadap kesehatan mata sangat serius dan tidak boleh diabaikan.",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi5.png',
                      fullText: "  Pernahkah Anda memperhatikan anak atau siswa di sekitar Anda yang membaca buku dengan wajah nyaris menempel di halaman? Kebiasaan ini terlihat sepele, namun dampaknya terhadap kesehatan mata sangat serius dan tidak boleh diabaikan. Pekerjaan jarak dekat seperti jarak membaca yang terlalu dekat kurang dari 30 cm dapat meningkatkan terjadinya miopia, karena aktivitas melihat dekat jangka panjang menyebabkan akomodasi terus-menerus sehingga tonus otot siliaris menjadi tinggi dan lensa menjadi cembung. Artinya, setiap kali anak membaca terlalu dekat dalam waktu lama, secara perlahan mata mereka sedang dipaksa bekerja ekstra keras hingga akhirnya mengalami kerusakan permanen.\n\n"
                                "  Fakta di lapangan pun membuktikan betapa nyatanya ancaman kebiasaan membaca jarak dekat ini terhadap generasi muda kita. Penelitian terhadap 150 sampel siswa SMA menemukan adanya hubungan antara kebiasaan membaca jarak dekat dengan miopia, di mana usia terbanyak yang menderita miopia adalah 70 orang atau 46,7% pada usia 15 tahun. Angka ini seharusnya menjadi peringatan keras bagi kita semua bahwa miopia bukan lagi masalah orang dewasa — ia sudah menyerang anak-anak kita sejak usia remaja, dan salah satu penyebab utamanya adalah kebiasaan membaca yang salah yang terus dibiarkan tanpa koreksi.\n\n"
                                "  Maka dari itu, mari kita mulai membangun kebiasaan membaca yang benar sejak dini, karena perubahan kecil dalam posisi membaca bisa memberikan perlindungan besar bagi penglihatan anak di masa depan. Terdapat hubungan antara riwayat membaca jarak dekat dengan miopia, di mana siswa dengan kebiasaan membaca jarak dekat mempunyai risiko untuk menderita miopia 0,4 kali lipat, sehingga disarankan perlunya menjaga jarak aman antara mata dengan bahan yang dibaca guna menjaga kesehatan mata sebagai indra vital dalam penglihatan dan untuk mencegah terjadinya miopia. Mulai sekarang, biasakan anak membaca dengan jarak minimal 30 cm, pastikan pencahayaan ruangan cukup, dan ingatkan mereka untuk beristirahat setiap 30 menit — karena mata yang sehat adalah hadiah terbaik yang bisa kita berikan untuk masa depan mereka.",
                    ),
                    
                    // Kartu 6
                    _buildEdukasiCard(
                      context,
                      title: "Membatasi Screen Time",
                      desc: "Tanpa disadari, kebiasaan menatap layar berjam-jam setiap hari sedang mengancam kesehatan mata anak-anak kita secara serius.",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi6.png',
                      fullText: "  Di era digital seperti sekarang, hampir tidak ada anak yang lepas dari genggaman gadget, entah itu smartphone, tablet, maupun laptop. Tanpa disadari, kebiasaan menatap layar berjam-jam setiap hari sedang mengancam kesehatan mata anak-anak kita secara serius. Banyak faktor penyebab miopia, di antaranya adalah faktor keturunan, ras/etnis, kebiasaan membaca dengan jarak dekat, posisi membaca, menggunakan handphone, asupan sayuran, buah, dan olahraga. Faktor risiko kebiasaan yang berpengaruh terhadap kejadian myopia adalah kebiasaan jarak baca (p=0.037) dan kebiasaan menggunakan handphone (p=0.001; OR adjusted 0.119). Angka-angka ini bukan sekadar statistik — ini adalah bukti nyata bahwa gadget yang ada di tangan anak kita setiap hari berpotensi merusak penglihatannya secara permanen jika tidak segera dikendalikan.\n\n"
                                "  Penelitian ilmiah telah dengan tegas membuktikan bahwa perilaku penggunaan gadget yang tidak terkontrol memiliki hubungan langsung dengan kejadian miopia pada anak usia sekolah. Hasil penelitian ini bermanfaat untuk melakukan pencegahan sejak dini kepada anak-anak tentang faktor risiko dari perilaku penggunaan gadget terhadap miopia, dan menyarankan agar penelitian lanjutan juga memperhatikan faktor intensitas cahaya serta aktivitas luar dan dalam ruangan. Ini adalah sinyal kuat yang harus kita dengarkan bersama — bahwa pencegahan harus dimulai sejak dini, sebelum kerusakan pada mata anak benar-benar terjadi dan sulit untuk diperbaiki. Jangan sampai kita menyesal di kemudian hari hanya karena terlambat bertindak.\n\n"
                                "  Sudah saatnya orang tua dan guru bergandengan tangan untuk secara aktif mengontrol dan membatasi penggunaan gadget pada anak demi melindungi kesehatan mata mereka. Disarankan melakukan pencegahan agar miopia yang telah terjadi tidak semakin berat dengan mengubah kebiasaan yang mempengaruhi progresivitas miopia, seperti mengatur jarak baca yang tepat dalam melakukan aktivitas jarak dekat, dan orang tua diharapkan untuk mengontrol kebiasaan anak agar minus mata tidak bertambah lagi. Tetapkan aturan screen time yang jelas di rumah, ajak anak beristirahat dari layar setiap 20 menit, dan gantikan waktu layar dengan aktivitas yang lebih menyehatkan mata — karena melindungi penglihatan anak hari ini berarti menjamin kualitas hidup mereka di masa depan.",
                    ),
                    
                    // Kartu 7
                    _buildEdukasiCard(
                      context,
                      title: "Atropin Dosis Rendah sebagai Senjata Ampuh Melawan Progresi Myopia",
                      desc: "Miopia bukan sekadar soal kacamata yang terus berganti ukuran — ini soal kualitas hidup dan masa depan penglihatan Anda.",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi7.png',
                      fullText: "  Pernahkah Anda merasa kacamata Anda terus bertambah minusnya setiap kali periksa ke dokter? Jika iya, Anda tidak sendirian — jutaan orang di seluruh dunia menghadapi masalah yang sama tanpa menyadari bahwa ada solusi medis yang bisa menghentikan perburukan itu. Penggunaan atropin tetes mata telah dilaporkan dapat memperlambat progresivitas myopia, dan WHO memperkirakan bahwa prevalensi myopia akan meningkat pesat dari 28,3% penduduk dunia pada tahun 2010 menjadi 49,7% pada tahun 2050. Pada penderita myopia, kondisi ini diperkirakan akan mengalami perburukan setiap tahunnya sekitar -0,50 D sampai -1,00 D, sehingga sangat penting dilakukan upaya untuk menekan laju progresivitas myopia sedini mungkin. Fakta ini seharusnya menjadi pengingat keras bagi kita semua bahwa miopia yang dibiarkan tanpa penanganan adalah ancaman nyata terhadap kualitas penglihatan jangka panjang.\n\n"
                                "  Bukti ilmiah telah berbicara sangat jelas mengenai efektivitas atropin dosis rendah dalam mengendalikan laju perkembangan miopia. Atropin 0,01% efektif dalam mencegah perkembangan miopia, di mana perkembangan miopia pada kelompok perlakuan hanya −0,14 ± 0,35 dibandingkan −0,65 ± 0,54 pada kelompok kontrol tanpa pengobatan (p < 0,01), dan hanya 2% pasien terpaksa menghentikan pengobatan karena efek samping seperti fotofobia dan kesulitan membaca. Dengan tingkat keberhasilan yang begitu tinggi dan efek samping yang sangat minimal, atropin dosis rendah adalah pilihan medis yang sangat layak untuk dipertimbangkan oleh siapa saja yang mengalami miopia progresif — baik remaja maupun dewasa. Jangan biarkan kekhawatiran yang belum terbukti menghalangi Anda mendapatkan perlindungan terbaik untuk mata Anda.\n\n"
                                "  Dengan dukungan bukti ilmiah yang semakin kuat, kini saatnya setiap individu dan tenaga kesehatan bersama-sama mempertimbangkan atropin dosis rendah sebagai bagian dari strategi perlindungan mata secara menyeluruh. Beberapa studi menunjukkan myopia dapat dicegah dan dikontrol, termasuk melalui aplikasi tetes mata atropin dosis rendah setiap hari dalam konsentrasi berkisar antara 0,01% dan 0,05%, yang berguna untuk mengurangi atau memperlambat perkembangan miopia. Jangan tunda lagi — segera konsultasikan kondisi mata Anda kepada dokter spesialis mata, karena semakin dini intervensi dilakukan, semakin besar peluang untuk melindungi penglihatan Anda dari kerusakan yang lebih serius di masa depan. Ingat, satu tetes kecil setiap hari bisa menjadi perbedaan besar bagi kualitas hidup Anda seumur hidup.",
                    ),
                    
                    // Kartu 8
                    _buildEdukasiCard(
                      context,
                      title: "Mengenal Orthokeratologi sebagai Solusi Modern Pengendalian Myopia",
                      desc: "Bayangkan bisa melihat jernih di siang hari tanpa kacamata atau lensa kontak, hanya dengan memakai lensa khusus saat tidur di malam hari.",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi8.png',
                      fullText: "  Siapa yang tidak ingin terbebas dari ketergantungan kacamata setiap hari, namun tetap mendapatkan penglihatan yang jernih dan tajam? Kini impian itu bukan lagi sesuatu yang mustahil, berkat kemajuan teknologi lensa kontak yang dikenal dengan nama orthokeratologi. Pilihan intervensi berupa penggunaan lensa kontak kaku khusus yang disebut orthokeratologi dipakai saat tidur untuk mengubah topografi kornea dan memanipulasi defokus retina perifer, meski demikian penggunaan lensa kontak perlu memperhatikan kebersihan dan aspek keamanan karena ada potensi infeksi yang menyebabkan keratitis. Dengan kata lain, cukup dengan memakai lensa ini saat tidur malam, Anda bisa bangun di pagi hari dengan penglihatan yang jauh lebih baik tanpa perlu langsung meraih kacamata — bukankah itu sesuatu yang luar biasa?\n\n"
                                "  Lebih dari sekadar kenyamanan, orthokeratologi telah terbukti secara ilmiah memberikan hasil yang signifikan dalam memperlambat perkembangan miopia pada penggunanya. Lensa kontak orthokeratology (OK) adalah lensa kontak dengan desain khusus yang hanya dipakai saat malam hari, di mana lensa OK membuat sentral kornea menjadi flat dan dapat mengurangi miopia secara sementara. Di antara semua intervensi yang pernah dilakukan, obat tetes mata atropin diketahui memiliki efek yang paling signifikan untuk mengurangi progresifitas miopia yaitu sampai mencapai 70%, namun orthokeratologi tetap menjadi pilihan unggulan bagi mereka yang menginginkan kebebasan dari kacamata di siang hari. Ini adalah bukti nyata bahwa teknologi kesehatan mata terus berkembang, dan kita sebagai pengguna memiliki lebih banyak pilihan efektif dibandingkan sebelumnya untuk melindungi kualitas penglihatan kita.\n\n"
                                "  Dengan segala keunggulan yang telah dibuktikan oleh penelitian ilmiah, orthokeratologi layak menjadi pilihan yang serius untuk dipertimbangkan oleh siapa saja yang ingin mengendalikan miopia mereka secara lebih aktif dan modern. Dalam meta-analisis yang melibatkan 44 studi dengan total 6.400 penderita miopia, dilaporkan bahwa tetes mata atropin, orthokeratologi, dan lensa kontak multifokal efektif dalam mengatasi perkembangan miopia. Orthokeratologi secara khusus dilaporkan menurunkan pemanjangan aksial sebanyak 0,19 mm per tahun, sementara lensa kontak multifokal menghasilkan koreksi refraksi 0,15D dalam 1 tahun. Jangan ragu untuk berkonsultasi dengan dokter spesialis mata Anda mengenai apakah orthokeratologi adalah pilihan yang tepat untuk kondisi Anda — karena berinvestasi pada kesehatan mata hari ini berarti memastikan kualitas penglihatan yang lebih baik untuk seluruh perjalanan hidup Anda ke depan.",
                    ),
                    
                    // Kartu 9
                    _buildEdukasiCard(
                      context,
                      title: "Bagaimana Nutrisi yang Tepat Menjadi Perisai Alami Melawan Myopia",
                      desc: "Siapa sangka bahwa kunci perlindungan mata Anda mungkin sudah ada di meja makan setiap hari?",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi9.png',
                      fullText: "  Tahukah Anda bahwa apa yang Anda makan setiap hari ternyata memiliki pengaruh langsung terhadap kesehatan mata Anda? Di tengah maraknya berbagai solusi medis canggih untuk mengatasi miopia, sering kali kita melupakan bahwa perlindungan paling mendasar justru bisa dimulai dari pilihan makanan yang kita konsumsi sehari-hari. Wortel (Daucus carota L) merupakan sayuran yang memiliki sumber provitamin A, vitamin B, vitamin C, serta zat-zat lain yang bermanfaat bagi kesehatan mata, dan konsumsi wortel secara rutin dianjurkan sebagai bagian dari upaya pencegahan miopia. Artinya, langkah sesederhana menambahkan wortel ke dalam menu harian Anda sudah merupakan bentuk nyata perlindungan terhadap kesehatan mata — sesuatu yang mudah dilakukan namun sering kali diremehkan.\n\n"
                                "  Namun perlindungan mata tidak berhenti hanya pada wortel saja — ada rangkaian nutrisi penting lainnya yang bekerja bersama-sama membentuk sistem pertahanan mata yang kuat dan menyeluruh. Vitamin A sangat penting untuk fungsi penglihatan terutama di cahaya redup dan berperan dalam menjaga kesehatan kornea sebagai lapisan terluar mata yang bening, sementara Vitamin C dan E adalah antioksidan kuat yang melindungi sel-sel mata dari kerusakan akibat radikal bebas yang merupakan molekul tidak stabil yang dapat merusak sel-sel tubuh termasuk di mata. Kombinasi nutrisi-nutrisi ini bekerja layaknya sebuah tim pelindung yang menjaga setiap bagian mata Anda dari kerusakan — dan kabar terbaiknya, semua nutrisi tersebut bisa Anda dapatkan dengan mudah dari makanan sehari-hari yang ada di sekitar Anda.\n\n"
                                "  Maka dari itu, sudah saatnya kita semua mulai memandang makanan bukan hanya sebagai pemenuh rasa lapar, tetapi juga sebagai investasi jangka panjang bagi kesehatan penglihatan kita. Penelitian menyarankan pengkajian lebih dalam terkait jumlah asupan vitamin A yang dapat membantu mencegah atau mengurangi myopia, sekaligus menegaskan bahwa pola makan sehat dan deteksi dini perlu diperhatikan bersama sebagai bagian dari upaya pencegahan miopia yang menyeluruh. Mulailah hari ini — perbanyak konsumsi sayuran berwarna cerah, buah-buahan kaya antioksidan, dan makanan bergizi seimbang lainnya, karena setiap suapan makanan bergizi yang Anda pilih adalah langkah nyata menuju penglihatan yang lebih sehat dan tajam sepanjang hidup Anda.",
                    ),
                    
                    // Kartu 10
                    _buildEdukasiCard(
                      context,
                      title: "Lebih Awal Lebih Baik: Deteksi Dini Kunci Mencegah Myopia",
                      desc: "Banyak orang baru menyadari matanya bermasalah ketika kondisinya sudah cukup parah.",
                      category: "KEBIASAAN",
                      imagePath: 'assets/images/edukasi10.png',
                      fullText: "  Seberapa sering Anda memeriksa kesehatan mata Anda? Jika jawaban Anda adalah hanya ketika ada masalah, maka inilah saatnya mengubah pola pikir tersebut sebelum terlambat. Banyak kasus miopia yang terus berkembang parah justru karena tidak terdeteksi sejak awal, sehingga penanganan yang diberikan pun menjadi terlambat dan hasilnya tidak optimal. Pencegahan serta pengobatan yang paling efektif untuk myopia sangat bergantung pada penyaringan yang efektif dan memulai pengobatan sejak dini dalam kehidupan, karena intervensi yang dilakukan lebih awal terbukti memberikan hasil yang jauh lebih baik dibandingkan penanganan yang dilakukan setelah kondisi mata sudah memburuk. Ini adalah pesan yang harus kita tanamkan dalam kesadaran kita bersama — bahwa deteksi dini bukan sekadar pilihan, melainkan sebuah keharusan.\n\n"
                                "  Fakta ilmiah dengan tegas menunjukkan bahwa semakin cepat miopia terdeteksi, semakin efektif pula intervensi yang bisa diberikan untuk menghentikan laju perkembangannya. Diagnosis dini, intervensi dini, dan pemantauan rutin adalah kunci untuk mengelola miopia dengan efektif, sehingga mereka yang telah terdiagnosis dengan miopia progresif dapat segera mendapatkan penanganan yang tepat untuk mengurangi laju perkembangan miopia. Coba bayangkan — jika miopia Anda terdeteksi lebih awal, Anda memiliki jauh lebih banyak pilihan penanganan yang tersedia, mulai dari perubahan gaya hidup, penggunaan tetes mata atropin, hingga orthokeratologi. Menunda pemeriksaan mata sama artinya dengan mempersempit pilihan penanganan yang bisa Anda dapatkan.\n\n"
                                "  Oleh karena itu, jangan tunggu sampai penglihatan Anda terasa sangat terganggu baru kemudian memutuskan untuk periksa ke dokter mata. Penelitian analitik observasional menunjukkan prevalensi miopia di perkotaan mencapai 56%, sedangkan di pinggiran kota 28,8%, dengan hasil signifikan antara jarak membaca buku (p=0,011) dan aktivitas di luar ruangan (p=0,002) terhadap miopia, sehingga studi ini menegaskan pentingnya skrining dan deteksi dini miopia secara berkala pada seluruh lapisan masyarakat. Jadwalkan pemeriksaan mata Anda minimal satu kali dalam setahun, ajak keluarga dan orang-orang terdekat Anda untuk melakukan hal yang sama, karena mata adalah jendela dunia yang tidak ternilai harganya — dan menjaganya dengan deteksi dini adalah bentuk cinta terbesar yang bisa Anda berikan untuk diri sendiri dan orang-orang yang Anda sayangi.",
                    ),
                    
                    const SizedBox(height: 100),
                  ]),
                );
              } 
              
              // ==========================================
              // JIKA TAB 1 (ARTIKEL MEDIS) YANG DIPILIH
              // ==========================================
              else {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    
                    // Kartu Artikel Medis 1
                    _buildEdukasiCard(
                      context,
                      title: "Patogenesis Miopia: Pemanjangan Sumbu Aksial Bola Mata",
                      desc: "Memahami secara medis bagaimana bola mata mengalami perubahan struktural permanen yang menyebabkan rabun jauh.",
                      category: "JURNAL OPHTHALMOLOGY",
                      imagePath: 'assets/images/artikel1.png', 
                      fullText: "  Miopia atau rabun jauh bukan sekadar kelainan refraksi biasa, melainkan kondisi patologis di mana terjadi perubahan struktural secara anatomis pada bola mata. Secara spesifik, miopia ditandai dengan pemanjangan sumbu aksial (axial length) bola mata yang abnormal.\n\n"
                                "  Pada anatomi mata yang sehat (emetropia), cahaya yang masuk melalui kornea dan lensa akan dibiaskan sedemikian rupa hingga titik fokusnya jatuh persis di atas makula (pusat retina). Namun, pada penderita miopia progresif, bola mata tumbuh terlalu panjang dari depan ke belakang. Akibat pemanjangan ini, titik fokus cahaya jatuh di 'depan' retina. Hal inilah yang menyebabkan objek di kejauhan tampak kabur.\n\n"
                                "  Secara patofisiologis, pemanjangan aksial ini dipicu oleh penipisan sklera (lapisan putih mata). Ketika mata terus-menerus terpapar 'hyperopic defocus' akibat aktivitas jarak dekat yang ekstrem (seperti membaca atau menatap gadget), retina akan melepaskan sinyal biokimia neuroretinal.\n\n"
                                "  Sinyal tersebut memicu remodeling matriks ekstraseluler pada sklera. Kolagen pada sklera mulai terdegradasi sehingga sklera menjadi lemah, menipis, dan elastis. Dorongan tekanan intraokular dari dalam mata kemudian membuat bola mata yang melemah tersebut meregang memanjang secara permanen.\n\n"
                                "  Penelitian medis klinis membuktikan bahwa paparan cahaya matahari luar ruangan (outdoor light) sangat krusial. Cahaya matahari dengan intensitas tinggi merangsang pelepasan neurotransmiter dopamin dari retina. Dopamin ini terbukti secara ilmiah berfungsi sebagai inhibitor poten yang 'mengerem' pertumbuhan sumbu aksial mata, sehingga mencegah progresivitas miopia.",
                    ),

                    // Kartu Artikel 1 - Myopia Booming Global
                    _buildEdukasiCard(
                      context,
                      title: "Myopia Booming: Krisis Penglihatan Global yang Mengancam Separuh Populasi Dunia",
                      desc: "Memahami mengapa miopia kini bukan sekadar masalah mata biasa, melainkan krisis kesehatan masyarakat global yang membutuhkan perhatian serius.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel2.png',
                      fullText: "  Dunia sedang menghadapi krisis kesehatan mata yang tidak bisa lagi diabaikan. Organisasi Kesehatan Dunia (WHO) memprediksikan bahwa setengah populasi dunia akan mengalami miopia pada tahun 2050. Fenomena ini bahkan telah diberi nama tersendiri: Myopia Booming — sebuah istilah yang menggambarkan lonjakan kasus miopia secara masif di seluruh penjuru dunia, terutama di kawasan Asia Timur dan Asia Tenggara.\n\n"
                                "  Di Asia Timur dan Asia Tenggara, sebanyak 90% para lulusan sekolah diketahui menderita miopia. Sementara di Eropa dan Amerika Utara, angkanya mencapai 30–50% dari para lulusan sekolah. Indonesia pun tidak luput dari tren ini. Berdasarkan data Survei Kesehatan Indonesia (SKI) tahun 2023, prevalensi gangguan penglihatan pada anak usia sekolah (5–19 tahun) di Indonesia diperkirakan mencapai 10 persen — angka yang jauh dari kata menggembirakan.\n\n"
                                "  Yang membuat situasi ini semakin mengkhawatirkan adalah dampak yang ditimbulkan jauh melampaui sekadar penglihatan kabur. Sejak pandemi Covid-19, kurangnya waktu beraktivitas di luar ruangan dan intensnya penggunaan gadget menjadi pemicu utama lonjakan kasus ini. Miopia yang tidak ditangani serius dapat berkembang menjadi miopia tinggi yang membawa komplikasi berat seperti glaukoma, ablasi retina, katarak, hingga kebutaan permanen. Inilah saatnya kita semua membuka mata — secara harfiah maupun kiasan — terhadap ancaman nyata yang sedang mengintai penglihatan kita.",
                    ),

                    // Kartu Artikel 2 - Komplikasi Miopia Tinggi
                    _buildEdukasiCard(
                      context,
                      title: "Lebih dari Sekadar Minus: Bahaya Tersembunyi Miopia Tinggi yang Wajib Anda Ketahui",
                      desc: "Mengungkap komplikasi serius yang mengintai penderita miopia tinggi, mulai dari glaukoma, ablasi retina, hingga ancaman kebutaan permanen.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel3.png',
                      fullText: "  Banyak orang menganggap miopia hanya soal kacamata minus yang terus bertambah. Padahal, di balik angka-angka dioptri yang terus meningkat itu, tersimpan ancaman yang jauh lebih serius. Miopia derajat tinggi — yakni di atas minus 6 dioptri — dapat meningkatkan risiko komplikasi mata berat seperti katarak imatur, glaukoma, ablasi retina, dan degenerasi makula yang semuanya berpotensi berujung pada kebutaan permanen.\n\n"
                                "  Fakta-fakta ilmiah berbicara lebih keras dari yang kita kira. Penderita miopia tinggi memiliki kemungkinan 50% lebih besar mengalami glaukoma dibandingkan penderita miopia ringan. Selain itu, mereka juga 17% lebih berisiko menjalani operasi katarak di usia yang lebih muda. Adapun ablasi retina — kondisi di mana retina terkelupas dari dinding belakang mata — dapat menyebabkan hilangnya penglihatan secara permanen jika tidak segera ditangani. Yang lebih mengkhawatirkan, komplikasi-komplikasi ini tidak dapat dihilangkan meskipun sudah menjalani operasi LASIK sekalipun.\n\n"
                                "  Pesan yang ingin disampaikan sangat jelas: jangan tunggu miopia Anda mencapai angka yang mengkhawatirkan baru kemudian bertindak. Penanganan sejak dini adalah satu-satunya cara untuk memutus rantai progresi miopia sebelum komplikasi serius terjadi. Jadwalkan pemeriksaan mata secara rutin, terapkan gaya hidup sehat untuk mata, dan konsultasikan pilihan intervensi terbaik dengan dokter spesialis mata Anda — karena penglihatan yang Anda jaga hari ini adalah kualitas hidup yang Anda nikmati seumur hidup.",
                    ),

                    // Kartu Artikel 3 - Kebijakan Pencegahan Miopia China
                    _buildEdukasiCard(
                      context,
                      title: "Belajar dari China: Ketika Negara Turun Tangan Perangi Epidemi Miopia Sejak Bangku Sekolah",
                      desc: "Menelaah kebijakan revolusioner pemerintah China dalam memerangi lonjakan kasus miopia pada generasi muda melalui regulasi tidur, pencahayaan kelas, dan pembatasan gadget.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel4.png',
                      fullText: "  Ketika sebuah negara memutuskan untuk memerangi miopia lewat kebijakan nasional, itu adalah sinyal kuat bahwa masalah ini sudah melampaui batas urusan pribadi dan menjadi isu kesehatan publik yang gawat. Itulah yang dilakukan China pada Oktober 2024, ketika Kementerian Pendidikan, Komisi Kesehatan Nasional, dan Administrasi Pengendalian dan Pencegahan Penyakit secara bersama-sama meluncurkan serangkaian regulasi baru yang komprehensif untuk menekan laju miopia pada anak-anak.\n\n"
                                "  Kebijakan tersebut mencakup berbagai aspek kehidupan siswa secara menyeluruh. Siswa taman kanak-kanak diwajibkan mendapatkan waktu tidur lebih dari 10 jam setiap hari, sementara siswa sekolah dasar mendapatkan 10 jam penuh. Sekolah-sekolah dasar diwajibkan membeli meja dan kursi yang dapat disesuaikan, serta melengkapi ruang kelas dengan fasilitas pencahayaan yang mendukung kesehatan mata. Tak hanya itu, taman kanak-kanak diwajibkan melakukan tes penglihatan setiap enam bulan sekali, dan sekolah dasar harus memantau penglihatan siswa dua kali per semester.\n\n"
                                "  Langkah berani China ini seharusnya menjadi inspirasi dan cermin bagi kita semua — bahwa mencegah miopia membutuhkan kolaborasi nyata antara pemerintah, sekolah, tenaga kesehatan, dan orang tua. Tidak bisa hanya mengandalkan satu pihak saja. Jika negara dengan populasi terbesar di dunia saja sudah bergerak serius menghadapi ancaman ini, sudah saatnya kita pun mengambil sikap yang sama: mulai dari lingkungan terdekat kita, dari rumah, dari sekolah, dari diri sendiri.",
                    ),

                    // Kartu Artikel 4 - Aturan 20-20-20 Kemenkes
                    _buildEdukasiCard(
                      context,
                      title: "Metode 20-20-20: Solusi Sederhana dari Kemenkes RI untuk Lindungi Mata di Era Digital",
                      desc: "Mengenal metode 20-20-20 yang direkomendasikan Kementerian Kesehatan RI sebagai langkah praktis dan mudah untuk menjaga kesehatan mata dari paparan layar digital sehari-hari.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel5.png',
                      fullText: "  Di tengah gempuran layar digital yang kian mendominasi kehidupan modern, Kementerian Kesehatan Republik Indonesia hadir dengan rekomendasi praktis yang bisa langsung diterapkan siapa saja, kapan saja, dan di mana saja tanpa biaya apapun. Dalam peringatan Hari Penglihatan Sedunia 2024 yang mengangkat tema nasional 'Sayangi Mata Anak Kita', Kemenkes memperkenalkan kembali metode 20-20-20 sebagai senjata sederhana namun ampuh melawan kelelahan mata akibat aktivitas digital.\n\n"
                                "  Metode ini sangat mudah dipahami dan dipraktikkan: setiap 20 menit melakukan aktivitas yang melibatkan penglihatan intens seperti menatap layar, istirahatkan mata selama 20 detik dengan memandang objek yang berjarak 20 kaki atau sekitar 6 meter. Langkah kecil ini secara efektif memberikan jeda bagi otot-otot mata yang terus bekerja keras, mengurangi ketegangan, dan membantu mencegah progresivitas miopia akibat paparan layar yang berkepanjangan.\n\n"
                                "  Kemenkes juga menegaskan bahwa upaya deteksi dini gangguan penglihatan harus terus ditingkatkan di masyarakat, seiring dengan komitmen Indonesia dalam mencapai target global kesehatan mata tahun 2030. Pesan ini bukan hanya ditujukan untuk orang tua yang khawatir dengan kondisi mata anak-anaknya, tetapi untuk semua kalangan — karena di era di mana mata kita dipaksa bekerja lebih keras dari sebelumnya, menjaga kesehatan penglihatan adalah tanggung jawab yang tidak bisa ditunda lagi.",
                    ),


                    // Kartu Artikel 5 - Screen Time & Miopia Pasca Pandemi
                    _buildEdukasiCard(
                      context,
                      title: "Pandemi Usai, Krisis Mata Dimulai: Lonjakan Miopia Akibat Screen Time yang Tak Terbendung",
                      desc: "Mengulas bagaimana perubahan gaya hidup digital pasca pandemi Covid-19 telah memicu gelombang baru kasus miopia secara masif di seluruh dunia.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel5.png',
                      fullText: "  Pandemi Covid-19 mungkin sudah berlalu, tetapi dampaknya terhadap kesehatan mata masih terasa hingga hari ini. Selama masa pandemi, ketergantungan terhadap perangkat digital melonjak drastis — mulai dari sekolah daring, bekerja dari rumah, hingga hiburan digital yang tak terbatas. Perubahan perilaku akibat peningkatan ketergantungan pada perangkat digital ini diperkirakan akan bertahan bahkan setelah pandemi berakhir. Pada tahun 2050, diperkirakan 5 miliar orang di dunia akan mengalami miopia — sebuah angka yang tidak bisa lagi kita abaikan.\n\n"
                                "  Fakta semakin mengkhawatirkan ketika melihat data perilaku digital masyarakat Indonesia. Rata-rata masyarakat Indonesia menghabiskan sekitar 5,7 jam per hari di depan layar — menempatkan Indonesia pada jajaran teratas secara global. Dengan durasi screen time yang sepanjang itu, mata dipaksa bekerja terus-menerus tanpa jeda yang cukup. Studi ilmiah menemukan bahwa 55% hingga 81% pengguna layar mengalami gejala Computer Vision Syndrome (CVS) atau Digital Eye Strain — mulai dari kelelahan mata, penglihatan kabur, hingga peningkatan risiko miopia progresif. Lebih mengkhawatirkan lagi, pengguna smartphone lebih rentan mengalami miopia dibandingkan pengguna tablet, karena kebiasaan memegang layar lebih dekat ke mata.\n\n"
                                "  Ini bukan sekadar masalah kenyamanan — ini adalah krisis kesehatan yang sedang diam-diam berkembang di tengah kita. Setiap jam tambahan di depan layar tanpa jeda adalah satu langkah lebih dekat menuju kerusakan penglihatan yang semakin parah. Sudah saatnya kita secara sadar menetapkan batas penggunaan layar harian, menerapkan aturan 20-20-20, dan memulihkan keseimbangan antara dunia digital dan aktivitas nyata — demi melindungi penglihatan kita untuk jangka panjang.",
                    ),

                    // Kartu Artikel 6 - Peran Cahaya Matahari & Dopamin
                    _buildEdukasiCard(
                      context,
                      title: "Rahasia Sinar Matahari: Dopamin Retina, Kunci Biologis Pencegah Miopia yang Sering Terlupakan",
                      desc: "Mengungkap mekanisme ilmiah di balik manfaat paparan cahaya matahari terhadap kesehatan mata — bagaimana dopamin yang dilepas retina menjadi rem alami pertumbuhan bola mata.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel6.png',
                      fullText: "  Selama ini banyak orang hanya tahu bahwa beraktivitas di luar ruangan itu baik untuk mata, namun jarang yang memahami mengapa secara ilmiah. Ternyata, di balik manfaat sederhana itu tersimpan mekanisme biologis yang luar biasa. Paparan sinar matahari merangsang pelepasan dopamin dari sel-sel retina mata. Dopamin inilah yang kemudian berfungsi sebagai inhibitor alami — sebuah 'rem' biologis yang mencegah bola mata terus memanjang secara berlebihan. Pemanjangan bola mata yang tidak terkontrol inilah yang menjadi akar penyebab utama miopia.\n\n"
                                "  Penelitian ilmiah telah membuktikan bahwa anak-anak yang jarang terpapar cahaya alami memiliki risiko lebih tinggi mengalami miopia. Berbagai studi menunjukkan bahwa paparan sinar matahari minimal 3,3 jam per hari saat aktivitas luar ruangan secara signifikan mengurangi risiko miopia. Mekanisme ini juga menjelaskan mengapa tetes mata atropin — yang dikenal sebagai salah satu intervensi medis paling efektif untuk miopia — bekerja melalui jalur yang serupa, yakni merangsang pelepasan dopamin di retina untuk menghambat pertumbuhan aksial bola mata.\n\n"
                                "  Pemahaman ini membuka perspektif baru yang sangat penting: pencegahan miopia bukan hanya soal menghindari layar, tetapi juga soal secara aktif mencari paparan cahaya alami yang cukup setiap harinya. Mengingat iklim Indonesia yang dikaruniai cahaya matahari sepanjang tahun, kita sebenarnya memiliki 'obat' alami gratis yang tersedia setiap hari. Manfaatkan itu — luangkan waktu minimal 2 jam di luar ruangan setiap hari, dan biarkan sinar matahari bekerja melindungi mata Anda secara alami dari dalam.",
                    ),

                    // Kartu Artikel 7 - Faktor Genetik & Lingkungan
                    _buildEdukasiCard(
                      context,
                      title: "Gen Bukan Takdir: Memahami Peran Genetik dan Lingkungan dalam Risiko Miopia",
                      desc: "Membedah mitos dan fakta seputar faktor keturunan miopia — apakah orang tua bermata minus berarti anak pasti minus? Dan seberapa besar peran lingkungan dalam menentukan nasib penglihatan kita?",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel7.png',
                      fullText: "  Sudah menjadi kepercayaan umum di masyarakat bahwa miopia adalah 'penyakit keturunan' yang tidak bisa dihindari jika orang tua bermata minus. Memang benar bahwa faktor genetik berperan nyata — jika kedua orang tua menderita miopia, risiko anak terkena miopia meningkat hingga 50%. Penelitian bahkan menunjukkan bahwa genetika menyumbang hingga 80% dari varians kelainan refraksi. Namun, fakta yang sering luput dari perhatian adalah bahwa gen bukanlah satu-satunya penentu nasib penglihatan kita.\n\n"
                                "  Yang lebih menarik dari temuan ilmiah terkini adalah bahwa orang tua yang menderita miopia tidak semata-mata menurunkan risiko tersebut melalui genetik, melainkan juga melalui kebiasaan. Orang tua yang bermata minus cenderung memiliki kebiasaan beraktivitas melihat dekat yang kemudian ditiru oleh anak-anak mereka. Artinya, lingkaran miopia dalam sebuah keluarga bisa jadi lebih banyak disebabkan oleh pola kebiasaan yang diwariskan, bukan hanya gen yang diwariskan. Inilah kabar yang seharusnya membuat kita lebih optimis — karena kebiasaan bisa diubah, meski gen tidak bisa.\n\n"
                                "  Ini adalah pesan yang sangat membebaskan: meski Anda memiliki riwayat keluarga dengan miopia, Anda masih memiliki kendali yang besar terhadap kondisi penglihatan Anda sendiri dan anak-anak Anda. Dengan menerapkan gaya hidup sehat mata — memperbanyak aktivitas luar ruangan, membatasi layar, menjaga jarak baca, dan rutin periksa mata — Anda sedang secara aktif melawan risiko genetik yang ada. Karena dalam pertarungan antara gen dan gaya hidup, gaya hidup sehat selalu bisa menjadi pemenangnya.",
                    ),

                    // Kartu Artikel 8 - Kacamata, Lensa Kontak, LASIK
                    _buildEdukasiCard(
                      context,
                      title: "Kacamata, Lensa Kontak, atau LASIK? Panduan Memilih Solusi Koreksi Miopia yang Tepat untuk Anda",
                      desc: "Memahami pilihan-pilihan koreksi miopia yang tersedia saat ini — dari yang paling sederhana hingga teknologi bedah laser terkini — agar Anda bisa membuat keputusan terbaik untuk kesehatan mata Anda.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel8.png',
                      fullText: "  Ketika dokter mata mendiagnosis miopia, pertanyaan pertama yang muncul di benak kebanyakan orang adalah: 'Apa pilihan terbaik untuk saya?' Jawabannya tidak bisa satu ukuran untuk semua, karena setiap individu memiliki kondisi mata, gaya hidup, dan kebutuhan yang berbeda. Pilihan yang tersedia saat ini cukup beragam. Kacamata dengan lensa negatif (minus) adalah solusi paling umum, sederhana, dan terjangkau. Lensa konkaf yang digunakan akan memfokuskan kembali sinar cahaya sehingga bayangan benda jatuh tepat di retina. Lensa kontak menawarkan alternatif yang lebih bebas secara estetika, namun membutuhkan kedisiplinan ekstra dalam hal kebersihan untuk mencegah infeksi mata.\n\n"
                                "  Bagi yang menginginkan solusi lebih permanen, operasi refraktif menjadi pilihan. Prosedur LASIK (Laser-Assisted In Situ Keratomileusis) adalah yang paling populer — menggunakan laser untuk membentuk ulang kornea sehingga cahaya dapat difokuskan langsung ke retina. LASIK umumnya direkomendasikan untuk koreksi miopia dari -1 hingga -13 dioptri, tergantung ketebalan kornea masing-masing pasien. Teknologi yang lebih baru seperti SMILE (Small Incision Lenticule Extraction) juga kini tersedia, menawarkan prosedur yang lebih minimal invasif. Namun penting diingat, operasi laser hanya dianjurkan untuk usia dewasa di atas 18 tahun dengan ukuran minus yang sudah stabil.\n\n"
                                "  Yang perlu dipahami adalah bahwa semua pilihan koreksi ini — kacamata, lensa kontak, maupun LASIK — pada dasarnya hanya mengoreksi tajam penglihatan, bukan menyembuhkan kondisi miopia itu sendiri. Bola mata yang sudah terlanjur panjang tidak bisa dikembalikan ke ukuran normal. Itulah mengapa pencegahan dan pengendalian progresi sejak dini jauh lebih penting dari sekadar menunggu minus stabil lalu operasi. Konsultasikan kondisi mata Anda secara menyeluruh dengan dokter spesialis mata, karena pilihan terbaik adalah pilihan yang paling sesuai dengan kondisi unik mata Anda.",
                    ),

                    // Kartu Artikel 9 - Miopia & Prestasi Akademik
                    _buildEdukasiCard(
                      context,
                      title: "Mata Kabur, Prestasi Pudar: Dampak Miopia yang Tidak Terdeteksi terhadap Kualitas Belajar",
                      desc: "Mengungkap hubungan tersembunyi antara miopia yang tidak terkoreksi dengan penurunan performa akademik dan kualitas hidup — serta mengapa deteksi dini di lingkungan sekolah menjadi begitu krusial.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel9.png',
                      fullText: "  Pernahkah Anda atau seseorang yang Anda kenal tiba-tiba mengalami penurunan nilai di sekolah tanpa alasan yang jelas? Salah satu penyebab yang sering luput dari perhatian adalah gangguan penglihatan yang tidak terdeteksi. Di Indonesia, Survei PERDAMI (Perhimpunan Dokter Spesialis Mata Indonesia) menemukan bahwa sebanyak 40,5% anak sekolah dasar di Jakarta mengalami rabun jauh atau mata minus — hampir 4 dari 10 anak SD sudah memiliki gangguan penglihatan. Ironisnya, banyak dari mereka — dan orang tua mereka — tidak menyadarinya sampai kondisinya sudah cukup parah.\n\n"
                                "  Dampak miopia yang tidak terkoreksi jauh melampaui sekadar ketidaknyamanan visual. Ketika seorang anak tidak dapat melihat tulisan guru di papan tulis dengan jelas, ia tidak hanya kehilangan informasi pelajaran — ia juga kehilangan rasa percaya diri, konsentrasi, dan motivasi belajarnya secara perlahan. Kementerian Kesehatan RI bahkan mencatat bahwa pemberian kacamata pada anak yang membutuhkan dapat mengurangi kegagalan belajar hingga 44 persen. Sayangnya, studi Vision Project menemukan hanya 4 persen anak SD yang mendapatkan kacamata meski sudah didiagnosis rabun jauh — sebuah kesenjangan yang sangat besar dan memprihatinkan.\n\n"
                                "  Inilah mengapa program skrining penglihatan di sekolah bukan sekadar kegiatan formalitas, melainkan investasi nyata dalam masa depan generasi penerus bangsa. Jika Anda adalah orang tua, guru, atau siapa pun yang peduli terhadap tumbuh kembang anak — perhatikan tanda-tandanya: apakah anak sering menyipitkan mata, duduk terlalu dekat ke TV, atau nilainya tiba-tiba menurun? Jangan tunggu tanda-tanda itu diabaikan. Segera bawa anak periksa ke dokter mata, karena satu pemeriksaan sederhana bisa mengubah seluruh perjalanan belajar mereka.",
                    ),

                    // Kartu Artikel 10 - Miopia di Era Digital Indonesia
                    _buildEdukasiCard(
                      context,
                      title: "Indonesia di Ambang Krisis Penglihatan: 10% Anak Usia Sekolah Terancam Gangguan Mata",
                      desc: "Menelaah data terkini Kementerian Kesehatan RI tentang prevalensi gangguan penglihatan pada generasi muda Indonesia dan urgensi tindakan kolektif yang tidak bisa ditunda lagi.",
                      category: "BERITA KESEHATAN",
                      imagePath: 'assets/images/artikel10.png',
                      fullText: "  Indonesia menghadapi tantangan kesehatan mata yang semakin serius dan memerlukan perhatian segera dari seluruh lapisan masyarakat. Berdasarkan data Survei Kesehatan Indonesia (SKI) tahun 2023, prevalensi gangguan penglihatan pada anak usia sekolah yakni 5 sampai 19 tahun diperkirakan mencapai 10 persen. Angka ini bukan sekadar statistik — di baliknya ada jutaan anak Indonesia yang setiap hari berjuang melihat papan tulis, membaca buku, dan menjalani aktivitas belajar mereka dengan penglihatan yang kabur dan tidak terkoreksi.\n\n"
                                "  Kondisi ini diperparah oleh rendahnya kesadaran masyarakat akan pentingnya pemeriksaan mata secara rutin. Plt Direktur Jenderal Pencegahan dan Pengendalian Penyakit Kemenkes, Yudi Pramono, menegaskan bahwa jika gangguan refraksi tidak ditangani, kondisinya dapat memburuk bahkan menyebabkan kebutaan. Apabila tidak dilakukan pencegahan dan pengendalian secara serius dan intensif, dampak gangguan penglihatan akan berpengaruh terhadap kualitas hidup dan kesehatan masyarakat, serta menjadi beban ekonomi dan kerugian negara yang signifikan. Di seluruh dunia, terdapat 2,2 miliar orang yang mengalami gangguan penglihatan — dan 1 miliar di antaranya sebenarnya dapat dihindari, dicegah, maupun diobati.\n\n"
                                "  Kabar baiknya, kita masih punya kesempatan untuk membalikkan tren ini. Pemerintah telah berkomitmen dalam mencapai target global kesehatan mata tahun 2030, namun komitmen pemerintah saja tidak cukup tanpa partisipasi aktif dari seluruh masyarakat. Mulai dari keluarga terkecil — pastikan seluruh anggota keluarga Anda menjalani pemeriksaan mata secara rutin, terapkan kebiasaan sehat untuk mata, dan sebarkan kesadaran ini ke lingkungan sekitar Anda. Karena melindungi penglihatan Indonesia adalah tanggung jawab kita bersama.",
                    ),
                    
                    const SizedBox(height: 100), // Spasi bawah
                  ]),
                );
              }
            }), // Penutup Obx yang benar
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: TOMBOL TAB ---
  Widget _buildTabButton(int index, String label, IconData icon) {
    bool isSelected = controller.selectedCategory.value == index;
    return GestureDetector(
      onTap: () => controller.changeCategory(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2052D9) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF2052D9).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: KARTU EDUKASI (Tanpa Icon & Teks Justify) ---
  Widget _buildEdukasiCard(BuildContext context,
      {required String title, required String desc, required String category, required String imagePath, required String fullText}) {
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Garis Timeline
          Column(
            children: [
              Container(width: 2, height: 30, color: Colors.blue.withOpacity(0.2)),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2052D9).withOpacity(0.5), width: 2),
                ),
                child: const Icon(Icons.circle, size: 8, color: Color(0xFF2052D9)),
              ),
              Expanded(child: Container(width: 2, color: Colors.blue.withOpacity(0.2))),
            ],
          ),
          const SizedBox(width: 16),
          
          // Konten Kartu Utama
          Expanded(
            child: GestureDetector(
              onTap: () => _showArticleSheet(title, category, imagePath, fullText),
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(color: Color(0xFF2052D9), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey),
                        ],
                      ),
                    ),
                    
                    // Judul artikel
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.3)),
                    ),
                    const SizedBox(height: 16),
                    
                    // GAMBAR KARTU
                    Container(
                      height: 140,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Text(
                        desc,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.grey.shade600, height: 1.5, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: BOTTOM SHEET ARTIKEL WIKIPEDIA STYLE ---
  void _showArticleSheet(String title, String category, String imagePath, String fullText) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            
            // Header Judul Artikel
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category, style: const TextStyle(color: Color(0xFF2052D9), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      const SizedBox(height: 8),
                      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.3)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded, color: Colors.grey),
                  style: IconButton.styleFrom(backgroundColor: Colors.grey.shade100),
                )
              ],
            ),
            
            const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
            
            // Isi Artikel
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GAMBAR ARTIKEL
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey.shade200,
                              child: const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 50)),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Teks Artikel
                      Text(
                        fullText,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}