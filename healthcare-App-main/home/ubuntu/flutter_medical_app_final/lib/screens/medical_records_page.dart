import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/add_medical_record_page.dart';
import 'package:medical_app_base/screens/medical_record_filter_page.dart';
import 'package:medical_app_base/screens/notifications_page.dart';
import 'package:medical_app_base/screens/medical_record_details_page.dart';

class MedicalRecordsPage extends StatefulWidget {
  const MedicalRecordsPage({super.key});

  @override
  State<MedicalRecordsPage> createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  final List<Map<String, dynamic>> records = [
    {
      'date': '2024-03-15',
      'doctor': 'د. أحمد محمد',
      'specialty': 'طب القلب',
      'diagnosis': 'ضغط دم مرتفع',
      'medications': ['أدوية ضغط الدم', 'مميعات الدم'],
      'notes': 'يجب متابعة الضغط يومياً',
    },
    {
      'date': '2024-02-28',
      'doctor': 'د. سارة أحمد',
      'specialty': 'طب الباطنة',
      'diagnosis': 'نزلة برد',
      'medications': ['مسكنات', 'فيتامينات'],
      'notes': 'الراحة التامة لمدة 3 أيام',
    },
    {
      'date': '2024-03-10',
      'doctor': 'د. محمد علي',
      'specialty': 'طب العظام',
      'diagnosis': 'آلام في الظهر',
      'medications': ['مسكنات', 'مراهم موضعية'],
      'notes': 'تجنب حمل الأوزان الثقيلة',
    },
    {
      'date': '2024-03-05',
      'doctor': 'د. فاطمة حسن',
      'specialty': 'طب العيون',
      'diagnosis': 'قصر نظر',
      'medications': ['قطرات للعين'],
      'notes': 'ارتداء النظارات الطبية',
    },
    {
      'date': '2024-02-20',
      'doctor': 'د. خالد محمود',
      'specialty': 'طب الأسنان',
      'diagnosis': 'تسوس في الأضراس',
      'medications': ['معجون أسنان خاص'],
      'notes': 'تنظيف الأسنان مرتين يومياً',
    },
    {
      'date': '2024-03-01',
      'doctor': 'د. نورا سعيد',
      'specialty': 'طب الجلدية',
      'diagnosis': 'حساسية جلدية',
      'medications': ['كريمات موضعية', 'مضادات الهيستامين'],
      'notes': 'تجنب التعرض لأشعة الشمس المباشرة',
    },
    {
      'date': '2024-03-12',
      'doctor': 'د. عمر حسين',
      'specialty': 'طب الأنف والأذن والحنجرة',
      'diagnosis': 'التهاب في الجيوب الأنفية',
      'medications': ['بخاخات أنفية', 'مضادات حيوية'],
      'notes': 'تجنب التعرض للغبار والروائح القوية',
    },
    {
      'date': '2024-03-08',
      'doctor': 'د. ليلى محمود',
      'specialty': 'طب الأطفال',
      'diagnosis': 'حصبة ألمانية',
      'medications': ['خافض حرارة', 'فيتامينات'],
      'notes': 'عزل الطفل لمدة أسبوع',
    },
    {
      'date': '2024-02-25',
      'doctor': 'د. كريم عبدالله',
      'specialty': 'طب الجهاز الهضمي',
      'diagnosis': 'التهاب في المعدة',
      'medications': ['مضادات حموضة', 'مضادات حيوية'],
      'notes': 'تجنب الأطعمة الحارة والدهنية',
    },
    {
      'date': '2024-03-14',
      'doctor': 'د. منى رضا',
      'specialty': 'طب النساء والتوليد',
      'diagnosis': 'فحص دوري',
      'medications': ['فيتامينات', 'حديد'],
      'notes': 'متابعة دورية كل 3 أشهر',
    },
    {
      'date': '2024-03-02',
      'doctor': 'د. ياسر محسن',
      'specialty': 'طب المخ والأعصاب',
      'diagnosis': 'صداع نصفي',
      'medications': ['مسكنات', 'أدوية وقائية'],
      'notes': 'تجنب التوتر والإرهاق',
    },
    {
      'date': '2024-02-15',
      'doctor': 'د. هبة السيد',
      'specialty': 'طب الغدد الصماء',
      'diagnosis': 'سكري من النوع الثاني',
      'medications': ['أدوية السكري', 'مكملات غذائية'],
      'notes': 'قياس السكر يومياً وتجنب السكريات',
    },
    {
      'date': '2024-03-16',
      'doctor': 'د. رامي عادل',
      'specialty': 'طب المسالك البولية',
      'diagnosis': 'حصوات في الكلى',
      'medications': ['مسكنات', 'أدوية تفتيت الحصوات'],
      'notes': 'شرب كميات كبيرة من الماء',
    },
    {
      'date': '2024-03-13',
      'doctor': 'د. نادية كامل',
      'specialty': 'طب الروماتيزم',
      'diagnosis': 'التهاب المفاصل',
      'medications': ['أدوية مضادة للالتهاب', 'مسكنات'],
      'notes': 'تجنب الحركات العنيفة',
    },
    {
      'date': '2024-03-09',
      'doctor': 'د. عمرو سعد',
      'specialty': 'طب الأورام',
      'diagnosis': 'فحص دوري',
      'medications': ['فيتامينات', 'مكملات غذائية'],
      'notes': 'متابعة كل 6 أشهر',
    },
    {
      'date': '2024-03-07',
      'doctor': 'د. دينا محمود',
      'specialty': 'طب التغذية',
      'diagnosis': 'سمنة مفرطة',
      'medications': ['فيتامينات', 'مكملات غذائية'],
      'notes': 'اتباع نظام غذائي صحي',
    },
    {
      'date': '2024-03-04',
      'doctor': 'د. كريم فؤاد',
      'specialty': 'طب الصدر',
      'diagnosis': 'التهاب رئوي',
      'medications': ['مضادات حيوية', 'موسعات شعبية'],
      'notes': 'تجنب التدخين والغبار',
    },
    {
      'date': '2024-03-03',
      'doctor': 'د. سلمى علي',
      'specialty': 'طب المناعة',
      'diagnosis': 'حساسية موسمية',
      'medications': ['مضادات الهيستامين', 'بخاخات أنفية'],
      'notes': 'تجنب التعرض للغبار وحبوب اللقاح',
    },
    {
      'date': '2024-02-27',
      'doctor': 'د. محمود رشاد',
      'specialty': 'طب المسالك البولية',
      'diagnosis': 'التهاب في البروستاتا',
      'medications': ['مضادات حيوية', 'مسكنات'],
      'notes': 'تجنب الجلوس لفترات طويلة',
    },
    {
      'date': '2024-02-22',
      'doctor': 'د. ياسمين أحمد',
      'specialty': 'طب التجميل',
      'diagnosis': 'ندبات في الوجه',
      'medications': ['كريمات موضعية', 'فيتامينات'],
      'notes': 'تجنب التعرض لأشعة الشمس',
    },
    {
      'date': '2024-03-17',
      'doctor': 'د. علي محسن',
      'specialty': 'طب العظام',
      'diagnosis': 'كسر في الساق',
      'medications': ['مسكنات', 'كالسيوم'],
      'notes': 'تجنب المشي لمدة شهر',
    },
    {
      'date': '2024-03-11',
      'doctor': 'د. مريم سعيد',
      'specialty': 'طب الأطفال',
      'diagnosis': 'التهاب في الأذن',
      'medications': ['مضادات حيوية', 'قطرات للأذن'],
      'notes': 'تجنب دخول الماء للأذن',
    },
    {
      'date': '2024-03-06',
      'doctor': 'د. حسام الدين',
      'specialty': 'طب القلب',
      'diagnosis': 'تخطيط قلب',
      'medications': ['أدوية ضغط', 'مميعات'],
      'notes': 'متابعة كل شهر',
    },
    {
      'date': '2024-02-29',
      'doctor': 'د. نرمين علي',
      'specialty': 'طب النساء',
      'diagnosis': 'فحص دوري',
      'medications': ['فيتامينات', 'حديد'],
      'notes': 'متابعة كل 3 أشهر',
    },
    {
      'date': '2024-02-23',
      'doctor': 'د. كريم محمود',
      'specialty': 'طب العيون',
      'diagnosis': 'التهاب في العين',
      'medications': ['قطرات مضادة للالتهاب'],
      'notes': 'تجنب فرك العين',
    },
  ];

  List<Map<String, dynamic>> _foundRecords = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundRecords = records;
    _searchController.addListener(_runSearchFilter);
  }

  @override
  void dispose() {
    _searchController.removeListener(_runSearchFilter);
    _searchController.dispose();
    super.dispose();
  }

  void _runSearchFilter() {
    List<Map<String, dynamic>> results = [];
    if (_searchController.text.isEmpty) {
      results = records;
    } else {
      results = records.where((record) {
        final String searchTerm = _searchController.text.toLowerCase();
        return record['doctor'].toLowerCase().contains(searchTerm) ||
            record['specialty'].toLowerCase().contains(searchTerm) ||
            record['diagnosis'].toLowerCase().contains(searchTerm) ||
            record['notes'].toLowerCase().contains(searchTerm);
      }).toList();
    }
    setState(() {
      _foundRecords = results;
    });
  }

  void _confirmDelete(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا السجل؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  records.remove(record);
                  _foundRecords.remove(record);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف السجل بنجاح!')),
                );
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3EC8D6), Color(0xFF6EE2F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    'السجلات الطبية',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'سجل زياراتك الطبية',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Search and Filter
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'ابحث في السجلات...',
                          border: InputBorder.none,
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFF3EC8D6)),
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF3EC8D6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MedicalRecordFilterPage()));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF3EC8D6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationsPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Records List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _foundRecords.length,
                itemBuilder: (context, index) {
                  final record = _foundRecords[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                record['date'],
                                style: const TextStyle(
                                  color: Color(0xFF3EC8D6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (String result) {
                                  if (result == 'details') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MedicalRecordDetailsPage(
                                                    record: record)));
                                  } else if (result == 'edit') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddMedicalRecordPage()));
                                  } else if (result == 'delete') {
                                    _confirmDelete(record);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'details',
                                    child: Text('عرض التفاصيل'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text('تعديل السجل'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('حذف السجل'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            record['doctor'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            record['specialty'],
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'التشخيص:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3EC8D6),
                            ),
                          ),
                          Text(record['diagnosis']),
                          const SizedBox(height: 8),
                          const Text(
                            'الأدوية:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3EC8D6),
                            ),
                          ),
                          Wrap(
                            spacing: 8,
                            children: (record['medications'] as List<String>)
                                .map((med) => Chip(
                                      label: Text(med),
                                      backgroundColor:
                                          Color(0xFF3EC8D6).withOpacity(0.1),
                                      labelStyle:
                                          TextStyle(color: Color(0xFF3EC8D6)),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'ملاحظات:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3EC8D6),
                            ),
                          ),
                          Text(record['notes']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddMedicalRecordPage()));
        },
        backgroundColor: Color(0xFF3EC8D6),
        child: const Icon(Icons.add),
      ),
    );
  }
}
