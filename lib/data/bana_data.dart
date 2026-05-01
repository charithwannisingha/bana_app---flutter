class BanaTrack {
  final String title;
  final String author;
  final String url;

  BanaTrack({
    required this.title,
    required this.author,
    required this.url,
  });
}

// --- වර්ග 7ට අදාළව Offline සහ Online බණ ගොනු ලැයිස්තුව ---
final Map<String, List<BanaTrack>> categoryData = {
  
  // 1. ධර්ම දේශනා
  "ධර්ම දේශනා": [
    BanaTrack(
      title: "සිත පිළිබඳ අපූරු දේශනාව ",
      author: "පූජ්‍ය ගලිගමුවේ ඤාණදීප ස්වාමීන් වහන්සේ",
      url: "assets/audio/dharma_deshana/sitha_palanaya.mp3", 
    ),
    BanaTrack(
      title: "කර්මය සහ විපාකය ",
      author: "පූජ්‍ය කිරිබත්ගොඩ ඤාණානන්ද හිමි",
      url: "https://charitheranda.xyz/audio/karmaya.mp3", 
    ),
  ],

  // 2. පිරිත්
  "පිරිත්": [
    BanaTrack(
      title: "මහ පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/mhapirith.mp3",
    ),
    
    BanaTrack(
      title: "ඇණවුම් පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/AnawumPiritha.mp3",
    ),

    BanaTrack(
      title: "අංගුලිමාල පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/AngulimaalaPiritha.mp3",
    ),

    
    BanaTrack(
      title: "අන්තරාය නිවාරණ පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/AntharayaNiwaranaPiritha.mp3",
    ),

    BanaTrack(
      title: "දස දිසා පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/dasa_disa_piritha.mp3",
    ),

    BanaTrack(
      title: "ජල නන්දන පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/JalaNandanaPiritha.mp3",
    ),

    BanaTrack(
      title: "ජය පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/JayaPiritha.mp3",
    ),

    BanaTrack(
      title: "ජිනපඤ්ජර පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/JinapanjaraPiritha.mp3",
    ),

    BanaTrack(
      title: "ඛන්ධ පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/Kanda_Piritha.mp3",
    ),

    BanaTrack(
      title: "සීවලී පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/SeevaliePiritha.mp3",
    ),

    BanaTrack(
      title: "සෙත් පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/SethPirith1.mp3",
    ),

        BanaTrack(
      title: "වට්ටක පිරිත ",
      author: "මහා සංඝරත්නය",
      url: "assets/audio/pirith/WattakaPiritha.mp3",
    ),
  ],

  // 3. භාවනා
  "භාවනා": [
    BanaTrack(
      title: "සමථ භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/samathabawanawa.mp3",
    ),

    BanaTrack(
      title: "මෛත්‍රී භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/maithirbawanawa.mp3",
    ),

    BanaTrack(
      title: "අසුභ භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/asababawanawa.mp3",
    ),

    BanaTrack(
      title: "ආනාපානාසති භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/anapanasathi.mp3",
    ),

    BanaTrack(
      title: "බුද්ධානුස්සති භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/bunanusthathi.mp3",
    ),

    BanaTrack(
      title: "මරණානුස්සති භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/maranasathibawabwa.mp3",
    ),

    BanaTrack(
      title: "විදර්ශනා භාවනාව ",
      author: "සම්ප්‍රදායික භාවනා කමටහන්",
      url: "assets/audio/bawana/vidhrashana.mp3",
    ),
  ],

  // 4. බෝධි පූජා
  "බෝධි පූජා": [
    BanaTrack(
      title: "ජය ශ්‍රී මහා ආශිර්වාදාත්මක බෝධි පූජාව ",
      author: "පූජ්‍ය දීගල පියදස්සි හිමි",
      url: "assets/audio/bodhi_pooja/jayasirimhabodi.mp3",
    ),

      BanaTrack(
      title: "ආශිර්වාද බෝධි පූජාව ",
      author: "පූජ්‍ය දීගල පියදස්සි හිමි",
      url: "assets/audio/bodhi_pooja/bodiipuuja.mp3",
    ),

      BanaTrack(
      title: "ආශිර්වාද බෝධි පූජාව. ",
      author: "පූජ්‍ය පානදුරේ අරියධම්ම හිමි",
      url: "assets/audio/bodhi_pooja/bodipuja.mp3",
    ),

      BanaTrack(
      title: "ආශිර්වාද බෝධි පූජාව.. ",
      author: "පූජ්‍ය පාද උඩුමලගල පියනන්ද හිමි",
      url: "assets/audio/bodhi_pooja/asirawadabodipuja.mp3",
    ),

      BanaTrack(
      title: "පහන් කන්ද ආශිර්වාද බෝධි පූජාව ",
      author: "නෙත් FM",
      url: "assets/audio/bodhi_pooja/phankandaasirwada.mp3",
    ),
  ],

  // 5. කවි බණ
  "කවි බණ": [
    BanaTrack(
      title: "සම්බුදු හිමියන් ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/buduhimi.mp3",
    ),
    
    BanaTrack(
      title: "මහ මායා දේවිය ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/mhamaya.mp3",
    ),

    BanaTrack(
      title: "අම්මා ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/amma.mp3",
    ),

    BanaTrack(
      title: "තාත්තා ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/thatha.mp3",
    ),

    BanaTrack(
      title: "යශෝදරා දේවිය ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/yasodara.mp3",
    ),

    BanaTrack(
      title: "සමන් දේව කරුණාව ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/sumansamandevi.mp3",
    ),

    BanaTrack(
      title: "දළදා වහන්සේ වන්දනා ",
      author: "පූජ්‍ය මාතලේ සුමංගල හිමි",
      url: "assets/audio/kavi_bana/daladawahanse.mp3",
    ),
  ],

  // 6. ජාතක කථා
  "ජාතක කථා": [
    BanaTrack(
      title: "සස ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/sasajathakaya.mp3",
    ),
    BanaTrack(
      title: "ජවන හංස ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/javana_hansa_jathakaya.mp3",
    ),

     BanaTrack(
      title: "තයෝධම්ම ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/sansaragathajathakaya.mp3",
    ),

     BanaTrack(
      title: "උරග ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/uragajathakaya.mp3",
    ),

     BanaTrack(
      title: "සිරිකාලකණ්ණී ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/sirikalakanijathakaya.mp3",
    ),

     BanaTrack(
      title: "කණ්හදීපායන ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/kanbadipajathakaya.mp3",
    ),

     BanaTrack(
      title: "භිස ජාතකය ",
      author: "පූජ්‍ය කෝරළයාගම සරණතිස්ස හිමි",
      url: "assets/audio/jathaka/bisajathakaya.mp3",
    ),
  ],

  // 7. සෙත් කවි
  "සෙත් කවි": [
    BanaTrack(
      title: "රත්නමාලි ගාථා රත්නය ",
      author: "",
      url: "assets/audio/seth_kavi/rathmaligatha.mp3",
    ),
    BanaTrack(
      title: "ඡත්ත මානවක ගාථා රත්නය ",
      author: "",
      url: "assets/audio/seth_kavi/chathamanawagagatha.mp3",
    ),

       BanaTrack(
      title: "නරසීහ ගාථා රත්නය ",
      author: "",
      url: "assets/audio/seth_kavi/naraseehagatha.mp3",
    ),

       BanaTrack(
      title: "ජයමංගල ගාථා රත්නය  ",
      author: "",
      url: "assets/audio/seth_kavi/jayamangalagatha.mp3",
    ),

       BanaTrack(
      title: "ආශිර්වාද සෙත් කවි",
      author: "",
      url: "assets/audio/seth_kavi/asirwada_seth_kavi.mp3",
    ),

       BanaTrack(
      title: "නවග්‍රහ සෙත් කවි ",
      author: "",
      url: "assets/audio/seth_kavi/nawagraha_seth_kavi.mp3",
    ),

       BanaTrack(
      title: "බුදු ගුණ සෙත් කවි ",
      author: "",
      url: "assets/audio/seth_kavi/budugunasethkavi.mp3",
    ),
  ],
};