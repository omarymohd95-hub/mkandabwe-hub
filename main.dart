import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

const Color kGold = Color(0xFFD4B05A);
const Color kPrimary = kGold;
const Color kBg = Color(0xFF141414);
const Color kAppBar = Color(0xFF0E0E0E);
const Color kCard = Color(0xFF1E1E1E);
const Color kLine = Color(0xFF3A3524);
const Color kText = Color(0xFFEAE4D3);
const Color kMuted = Color(0xFFA39D8C);
const Color kOnGold = Color(0xFF1A1A1A);
const Color kDanger = Color(0xFFE07A6E);

// ============================================================
// LUGHA / LANGUAGE
// ============================================================

final ValueNotifier<String> appLang = ValueNotifier<String>('sw');

const Map<String, Map<String, String>> _strings = {
  'sw': {
    'nav_home': 'Home',
    'nav_family': 'Familia',
    'nav_contrib': 'Michango',
    'nav_news': 'Taarifa',
    'welcome': 'Karibu kwenye familia yetu',
    'tagline': 'Familia moja. Umoja mmoja. Maendeleo pamoja.',
    'summary': 'Muhtasari wa familia',
    'stat_members': 'Wanafamilia',
    'stat_contrib': 'Jumla ya michango',
    'stat_news': 'Taarifa',
    'latest_news': 'Taarifa ya hivi karibuni',
    'no_news': 'Hakuna taarifa bado',
    'signed_in_as': 'Umeingia kama',
    'admin_badge': 'Admin',
    'logout': 'Toka',
    'language': 'Lugha',
    'add': 'Ongeza',
    'cancel': 'Ghairi',
    'save': 'Hifadhi',
    'delete': 'Futa',
    'delete_q': 'Unataka kufuta hiki?',
    'error': 'Kosa',
    'name': 'Jina',
    'relation': 'Uhusiano (mf. Mtoto, Mjomba)',
    'phone': 'Simu',
    'default_relation': 'Mwanafamilia',
    'add_member': 'Ongeza mwanafamilia',
    'no_members': 'Hakuna wanafamilia bado',
    'total_contrib': 'JUMLA YA MICHANGO',
    'contrib_count': 'Idadi ya michango',
    'who_contributed': 'Nani amechangia',
    'no_contrib': 'Hakuna michango bado',
    'add_contrib': 'Ongeza mchango',
    'contributor': 'Aliyechangia',
    'amount': 'Kiasi (TSh)',
    'note_optional': 'Maelezo (si lazima)',
    'add_members_first': 'Ongeza wanafamilia kwanza',
    'add_news': 'Ongeza taarifa',
    'news_title': 'Kichwa',
    'news_body': 'Ujumbe',
    'login_title': 'Ingia kwa akaunti ya familia',
    'email': 'Barua pepe',
    'password': 'Nenosiri',
    'login': 'Ingia',
    'login_error': 'Barua pepe au nenosiri si sahihi.',
    'network_error': 'Imeshindwa. Angalia mtandao.',
    'forgot': 'Umesahau nenosiri?',
    'reset_sent':
        'Tumetuma link ya kubadilisha nenosiri kwenye barua pepe yako.',
    'enter_email': 'Andika barua pepe kwanza.',
    'signup_title': 'Fungua akaunti ya familia',
    'full_name': 'Jina kamili',
    'create_account': 'Fungua akaunti',
    'have_account': 'Tayari una akaunti? Ingia',
    'no_account': 'Huna akaunti? Jisajili',
    'name_required': 'Andika jina lako.',
    'pw_min': 'Nenosiri liwe na angalau herufi 6.',
    'email_in_use': 'Barua pepe hii tayari imesajiliwa.',
    'invalid_email': 'Barua pepe si sahihi.',
    'pending_title': 'Subiri idhini',
    'pending_msg':
        'Akaunti yako imetumwa kwa msimamizi wa familia. Utaingia akikubali. Ukurasa huu utabadilika wenyewe akikubali.',
    'rejected_title': 'Ombi halikubaliwa',
    'rejected_msg':
        'Msimamizi hajakubali akaunti hii. Wasiliana naye ukidhani ni kosa.',
    'requests': 'Maombi ya kujiunga',
    'pending_requests': 'Yanasubiri idhini',
    'approved_members': 'Walioidhinishwa',
    'rejected_members': 'Waliokataliwa',
    'no_requests': 'Hakuna maombi bado',
    'approve': 'Kubali',
    'reject': 'Kataa',
    'revoke': 'Ondoa ruhusa',
  },
  'en': {
    'nav_home': 'Home',
    'nav_family': 'Family',
    'nav_contrib': 'Contributions',
    'nav_news': 'News',
    'welcome': 'Welcome to our family',
    'tagline': 'One family. One unity. Progress together.',
    'summary': 'Family summary',
    'stat_members': 'Family members',
    'stat_contrib': 'Total contributions',
    'stat_news': 'Announcements',
    'latest_news': 'Latest announcement',
    'no_news': 'No announcements yet',
    'signed_in_as': 'Signed in as',
    'admin_badge': 'Admin',
    'logout': 'Log out',
    'language': 'Language',
    'add': 'Add',
    'cancel': 'Cancel',
    'save': 'Save',
    'delete': 'Delete',
    'delete_q': 'Do you want to delete this?',
    'error': 'Error',
    'name': 'Name',
    'relation': 'Relationship (e.g. Child, Uncle)',
    'phone': 'Phone',
    'default_relation': 'Family member',
    'add_member': 'Add family member',
    'no_members': 'No family members yet',
    'total_contrib': 'TOTAL CONTRIBUTIONS',
    'contrib_count': 'Number of contributions',
    'who_contributed': 'Who contributed',
    'no_contrib': 'No contributions yet',
    'add_contrib': 'Add contribution',
    'contributor': 'Contributor',
    'amount': 'Amount (TSh)',
    'note_optional': 'Note (optional)',
    'add_members_first': 'Add family members first',
    'add_news': 'Add announcement',
    'news_title': 'Title',
    'news_body': 'Message',
    'login_title': 'Sign in to the family account',
    'email': 'Email',
    'password': 'Password',
    'login': 'Sign in',
    'login_error': 'Incorrect email or password.',
    'network_error': 'Something went wrong. Check your connection.',
    'forgot': 'Forgot password?',
    'reset_sent': 'We sent a password reset link to your email.',
    'enter_email': 'Enter your email first.',
    'signup_title': 'Create a family account',
    'full_name': 'Full name',
    'create_account': 'Create account',
    'have_account': 'Already have an account? Sign in',
    'no_account': "Don't have an account? Sign up",
    'name_required': 'Enter your name.',
    'pw_min': 'Password must be at least 6 characters.',
    'email_in_use': 'This email is already registered.',
    'invalid_email': 'Invalid email address.',
    'pending_title': 'Waiting for approval',
    'pending_msg':
        'Your account was sent to the family admin. You will get in once approved. This page updates by itself.',
    'rejected_title': 'Request not approved',
    'rejected_msg':
        'The admin has not approved this account. Contact them if you think this is a mistake.',
    'requests': 'Join requests',
    'pending_requests': 'Awaiting approval',
    'approved_members': 'Approved',
    'rejected_members': 'Rejected',
    'no_requests': 'No requests yet',
    'approve': 'Approve',
    'reject': 'Reject',
    'revoke': 'Remove access',
  },
};

String t(String key) =>
    _strings[appLang.value]?[key] ?? _strings['sw']![key] ?? key;

Future<void> setLang(String code) async {
  appLang.value = code;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lang', code);
}

class LangBuilder extends StatelessWidget {
  final WidgetBuilder builder;

  const LangBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: appLang,
      builder: (context, _, __) => builder(context),
    );
  }
}

class LanguageMenu extends StatelessWidget {
  final Color color;

  const LanguageMenu({super.key, this.color = kGold});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: t('language'),
      icon: Icon(Icons.language, color: color),
      onSelected: setLang,
      itemBuilder: (_) => [
        CheckedPopupMenuItem<String>(
          value: 'sw',
          checked: appLang.value == 'sw',
          child: const Text('Kiswahili'),
        ),
        CheckedPopupMenuItem<String>(
          value: 'en',
          checked: appLang.value == 'en',
          child: const Text('English'),
        ),
      ],
    );
  }
}

// ============================================================
// MSAADA / HELPERS
// ============================================================

typedef Docs = List<QueryDocumentSnapshot<Map<String, dynamic>>>;

String formatMoney(num v) {
  final n = v.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < n.length; i++) {
    if (i > 0 && (n.length - i) % 3 == 0) buf.write(',');
    buf.write(n[i]);
  }
  return 'TSh $buf';
}

String formatDate(Timestamp? ts) {
  if (ts == null) return '';
  final d = ts.toDate();
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  return '$dd/$mm/${d.year}';
}

double sumAmount(Docs docs) {
  double total = 0;
  for (final d in docs) {
    total += ((d.data()['amount'] ?? 0) as num).toDouble();
  }
  return total;
}

Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream(
  String name, {
  String orderBy = 'createdAt',
  bool descending = false,
}) {
  return FirebaseFirestore.instance
      .collection(name)
      .orderBy(orderBy, descending: descending)
      .snapshots();
}

/// Inaonyesha hati za mkusanyiko wa Firestore na kusasishwa papo hapo.
class CollectionBuilder extends StatefulWidget {
  final String collection;
  final bool descending;
  final Widget Function(BuildContext context, Docs docs) builder;

  const CollectionBuilder({
    super.key,
    required this.collection,
    required this.builder,
    this.descending = false,
  });

  @override
  State<CollectionBuilder> createState() => _CollectionBuilderState();
}

class _CollectionBuilderState extends State<CollectionBuilder> {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _stream =
      collectionStream(widget.collection, descending: widget.descending);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _stream,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text('${t('error')}: ${snap.error}'));
        }
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return widget.builder(context, snap.data!.docs);
      },
    );
  }
}

/// Inajua kama aliyeingia ni admin (hati ya admins/{uid} ipo).
class AdminBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, bool isAdmin) builder;

  const AdminBuilder({super.key, required this.builder});

  @override
  State<AdminBuilder> createState() => _AdminBuilderState();
}

class _AdminBuilderState extends State<AdminBuilder> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? _stream;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      _stream =
          FirebaseFirestore.instance.collection('admins').doc(uid).snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_stream == null) return widget.builder(context, false);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _stream,
      builder: (context, snap) =>
          widget.builder(context, snap.data?.exists ?? false),
    );
  }
}

/// Kadi nyeupe yenye uwezo wa kufutwa kwa kutelezesha (admin tu).
class FamilyCard extends StatelessWidget {
  final String id;
  final bool canDelete;
  final VoidCallback onDelete;
  final Widget child;

  const FamilyCard({
    super.key,
    required this.id,
    required this.canDelete,
    required this.onDelete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction:
          canDelete ? DismissDirection.endToStart : DismissDirection.none,
      confirmDismiss: (_) async {
        final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(t('delete_q')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(t('cancel')),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: kDanger,
                  foregroundColor: kOnGold,
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(t('delete')),
              ),
            ],
          ),
        );
        return ok ?? false;
      },
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: kDanger,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: kOnGold),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kLine),
        ),
        child: child,
      ),
    );
  }
}

Widget addButton(VoidCallback onPressed, IconData icon) {
  return FloatingActionButton.extended(
    onPressed: onPressed,
    backgroundColor: kPrimary,
    foregroundColor: kOnGold,
    icon: Icon(icon),
    label: Text(t('add')),
  );
}

Widget emptyState(IconData icon, String text) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 44, color: kPrimary),
        const SizedBox(height: 10),
        Text(text, style: const TextStyle(color: kMuted)),
      ],
    ),
  );
}

// ============================================================
// APP
// ============================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  appLang.value = prefs.getString('lang') ?? 'sw';
  runApp(const MkandabweApp());
}

class MkandabweApp extends StatelessWidget {
  const MkandabweApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mkandabwe Family Hub',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kGold,
          brightness: Brightness.dark,
        ).copyWith(
          primary: kGold,
          onPrimary: kOnGold,
          surface: kBg,
          onSurface: kText,
        ),
        scaffoldBackgroundColor: kBg,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: kAppBar,
          indicatorColor: const Color(0x38D4B05A),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final on = states.contains(WidgetState.selected);
            return IconThemeData(color: on ? kGold : kMuted);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final on = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 12,
              color: on ? kGold : kMuted,
              fontWeight: on ? FontWeight.w600 : FontWeight.w400,
            );
          }),
        ),
      ),
      home: const AuthGate(),
    );
  }
}

/// Jina alilolijaza mtu wakati wa kujisajili (linatumika kutengeneza ombi lake).
String? signupName;

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) return const AccessGate();
        return const LoginPage();
      },
    );
  }
}

// ============================================================
// IDHINI YA ADMIN / APPROVAL
// ============================================================

class AccessGate extends StatefulWidget {
  const AccessGate({super.key});

  @override
  State<AccessGate> createState() => _AccessGateState();
}

class _AccessGateState extends State<AccessGate> {
  late final String _uid = FirebaseAuth.instance.currentUser!.uid;
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _admin =
      FirebaseFirestore.instance.collection('admins').doc(_uid).snapshots();
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _user =
      FirebaseFirestore.instance.collection('users').doc(_uid).snapshots();
  bool _creating = false;

  Future<void> _createPending() async {
    final u = FirebaseAuth.instance.currentUser!;
    final email = u.email ?? '';
    final typed = signupName?.trim() ?? '';
    final name = typed.isNotEmpty
        ? typed
        : (u.displayName ??
            (email.contains('@') ? email.split('@').first : email));
    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'name': name,
        'email': email,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {
      _creating = false;
    }
  }

  Widget _loading() =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _admin,
      builder: (context, adminSnap) {
        if (!adminSnap.hasData && !adminSnap.hasError) return _loading();
        if (adminSnap.data?.exists ?? false) return const FamilyHome();

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _user,
          builder: (context, userSnap) {
            if (userSnap.hasError) {
              return const PendingPage(rejected: false);
            }
            if (!userSnap.hasData) return _loading();
            final doc = userSnap.data!;
            if (!doc.exists) {
              if (!_creating) {
                _creating = true;
                _createPending();
              }
              return const PendingPage(rejected: false);
            }
            final status = doc.data()?['status'];
            if (status == 'approved') return const FamilyHome();
            return PendingPage(rejected: status == 'rejected');
          },
        );
      },
    );
  }
}

class PendingPage extends StatelessWidget {
  final bool rejected;

  const PendingPage({super.key, required this.rejected});

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    return LangBuilder(
      builder: (context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        rejected ? Icons.block : Icons.hourglass_top,
                        size: 64,
                        color: kPrimary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t(rejected ? 'rejected_title' : 'pending_title'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t(rejected ? 'rejected_msg' : 'pending_msg'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: kMuted),
                      ),
                      if (email.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        Text(
                          email,
                          style: const TextStyle(color: kMuted),
                        ),
                      ],
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        icon: const Icon(Icons.logout),
                        label: Text(t('logout')),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 4,
                right: 8,
                child: LanguageMenu(color: kPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ukurasa wa admin wa kukubali au kukataa maombi ya kujiunga.
class AccessRequestsPage extends StatelessWidget {
  const AccessRequestsPage({super.key});

  Widget _tile(
    QueryDocumentSnapshot<Map<String, dynamic>> doc, {
    required bool canApprove,
    required bool canReject,
  }) {
    final d = doc.data();
    final name = (d['name'] ?? '') as String;
    final email = (d['email'] ?? '') as String;
    return FamilyCard(
      id: doc.id,
      canDelete: false,
      onDelete: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kPrimary,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
            style: const TextStyle(color: kOnGold),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canApprove)
              IconButton(
                tooltip: t('approve'),
                icon: const Icon(Icons.check_circle, color: kPrimary),
                onPressed: () => doc.reference.update({'status': 'approved'}),
              ),
            if (canReject)
              IconButton(
                tooltip: t('reject'),
                icon: const Icon(Icons.cancel, color: kDanger),
                onPressed: () => doc.reference.update({'status': 'rejected'}),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _section(
    String title,
    Docs list, {
    required bool canApprove,
    required bool canReject,
  }) {
    if (list.isEmpty) return [];
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
        child: Text(
          '$title (${list.length})',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      for (final d in list) ...[
        _tile(d, canApprove: canApprove, canReject: canReject),
        const SizedBox(height: 10),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LangBuilder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBar,
          foregroundColor: kGold,
          shape: const Border(bottom: BorderSide(color: kLine)),
          title: Text(t('requests')),
        ),
        body: CollectionBuilder(
          collection: 'users',
          descending: true,
          builder: (context, docs) {
            if (docs.isEmpty) {
              return emptyState(Icons.how_to_reg, t('no_requests'));
            }
            Docs by(String status) =>
                docs.where((d) => d.data()['status'] == status).toList();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._section(t('pending_requests'), by('pending'),
                    canApprove: true, canReject: true),
                ..._section(t('approved_members'), by('approved'),
                    canApprove: false, canReject: true),
                ..._section(t('rejected_members'), by('rejected'),
                    canApprove: true, canReject: false),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// KUINGIA NA KUJISAJILI / LOGIN & SIGN UP
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool signUp = false;
  bool loading = false;
  bool obscure = true;
  String? errorKey;

  Future<void> _submit() async {
    if (signUp) {
      if (nameCtrl.text.trim().isEmpty) {
        setState(() => errorKey = 'name_required');
        return;
      }
      if (passCtrl.text.length < 6) {
        setState(() => errorKey = 'pw_min');
        return;
      }
    }
    setState(() {
      loading = true;
      errorKey = null;
    });
    try {
      if (signUp) {
        signupName = nameCtrl.text.trim();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text,
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtrl.text.trim(),
          password: passCtrl.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (signUp) {
          if (e.code == 'email-already-in-use') {
            errorKey = 'email_in_use';
          } else if (e.code == 'weak-password') {
            errorKey = 'pw_min';
          } else if (e.code == 'invalid-email') {
            errorKey = 'invalid_email';
          } else {
            errorKey = 'network_error';
          }
        } else {
          errorKey = 'login_error';
        }
      });
    } catch (_) {
      setState(() => errorKey = 'network_error');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _resetPassword() async {
    final email = emailCtrl.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    if (email.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(t('enter_email'))));
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      messenger.showSnackBar(SnackBar(content: Text(t('reset_sent'))));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(t('network_error'))));
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LangBuilder(
      builder: (context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kGold,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'MFH',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: kOnGold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Mkandabwe Family Hub',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        t(signUp ? 'signup_title' : 'login_title'),
                        style: const TextStyle(color: kMuted),
                      ),
                      const SizedBox(height: 28),
                      if (signUp) ...[
                        TextField(
                          controller: nameCtrl,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: t('full_name'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                      TextField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: t('email'),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: passCtrl,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          labelText: t('password'),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () =>
                                setState(() => obscure = !obscure),
                          ),
                        ),
                        onSubmitted: (_) => _submit(),
                      ),
                      if (errorKey != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          t(errorKey!),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: kDanger),
                        ),
                      ],
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: kPrimary,
                          ),
                          onPressed: loading ? null : _submit,
                          child: loading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: kOnGold,
                                  ),
                                )
                              : Text(t(signUp ? 'create_account' : 'login')),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (!signUp)
                        TextButton(
                          onPressed: _resetPassword,
                          child: Text(t('forgot')),
                        ),
                      TextButton(
                        onPressed: () => setState(() {
                          signUp = !signUp;
                          errorKey = null;
                        }),
                        child: Text(t(signUp ? 'have_account' : 'no_account')),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 4,
                right: 8,
                child: LanguageMenu(color: kPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// UKURASA MKUU WENYE TABO
// ============================================================

class FamilyHome extends StatefulWidget {
  const FamilyHome({super.key});

  @override
  State<FamilyHome> createState() => _FamilyHomeState();
}

class _FamilyHomeState extends State<FamilyHome> {
  int selectedIndex = 0;

  // Mara ya mwisho mtumiaji alipofungua kila tabo (milliseconds)
  final Map<int, int> _seen = {};

  static Stream<QuerySnapshot<Map<String, dynamic>>> _latestStream(String c) {
    return FirebaseFirestore.instance
        .collection(c)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }

  late final Stream<QuerySnapshot<Map<String, dynamic>>> _pendingUsers =
      FirebaseFirestore.instance
          .collection('users')
          .where('status', isEqualTo: 'pending')
          .snapshots();

  Widget _requestsButton() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _pendingUsers,
      builder: (context, snap) {
        final n = snap.data?.docs.length ?? 0;
        return IconButton(
          tooltip: t('requests'),
          icon: Badge(
            isLabelVisible: n > 0,
            label: Text('$n'),
            child: const Icon(Icons.how_to_reg),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AccessRequestsPage()),
          ),
        );
      },
    );
  }

  late final Map<int, Stream<QuerySnapshot<Map<String, dynamic>>>> _latest = {
    1: _latestStream('members'),
    2: _latestStream('contributions'),
    3: _latestStream('announcements'),
  };

  @override
  void initState() {
    super.initState();
    _loadSeen();
  }

  Future<void> _loadSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final tab in [1, 2, 3]) {
      final key = 'seen_$tab';
      var v = prefs.getInt(key);
      if (v == null) {
        v = now;
        await prefs.setInt(key, v);
      }
      _seen[tab] = v;
    }
    if (mounted) setState(() {});
  }

  Future<void> _markSeen(int tab) async {
    if (tab == 0) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    _seen[tab] = now;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('seen_$tab', now);
  }

  void _go(int index) {
    _markSeen(selectedIndex);
    _markSeen(index);
    setState(() => selectedIndex = index);
  }

  /// Ikoni yenye alama nyekundu kama kuna kitu kipya kwenye tabo hiyo.
  Widget _badged(IconData icon, int tab) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _latest[tab],
      builder: (context, snap) {
        var show = false;
        final docs = snap.data?.docs ?? [];
        if (docs.isNotEmpty &&
            _seen.containsKey(tab) &&
            selectedIndex != tab) {
          final ts = docs.first.data()['createdAt'] as Timestamp?;
          if (ts != null && ts.millisecondsSinceEpoch > _seen[tab]!) {
            show = true;
          }
        }
        return Badge(isLabelVisible: show, child: Icon(icon));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LangBuilder(
      builder: (context) {
        final pages = <Widget>[
          HomePage(onOpenTab: _go),
          MembersPage(),
          ContributionsPage(),
          AnnouncementsPage(),
        ];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: kAppBar,
            foregroundColor: kGold,
            shape: const Border(bottom: BorderSide(color: kLine)),
            centerTitle: true,
            title: const Text(
              'MFH  |  MKANDABWE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              AdminBuilder(
                builder: (context, isAdmin) =>
                    isAdmin ? _requestsButton() : const SizedBox.shrink(),
              ),
              const LanguageMenu(),
              IconButton(
                tooltip: t('logout'),
                icon: const Icon(Icons.logout),
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
            ],
          ),
          body: pages[selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: _go,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: t('nav_home'),
              ),
              NavigationDestination(
                icon: _badged(Icons.people_outline, 1),
                selectedIcon: const Icon(Icons.people),
                label: t('nav_family'),
              ),
              NavigationDestination(
                icon: _badged(Icons.volunteer_activism_outlined, 2),
                selectedIcon: const Icon(Icons.volunteer_activism),
                label: t('nav_contrib'),
              ),
              NavigationDestination(
                icon: _badged(Icons.campaign_outlined, 3),
                selectedIcon: const Icon(Icons.campaign),
                label: t('nav_news'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomePage extends StatefulWidget {
  final ValueChanged<int> onOpenTab;

  const HomePage({super.key, required this.onOpenTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _members =
      collectionStream('members');
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _contribs =
      collectionStream('contributions');
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _news =
      collectionStream('announcements', descending: true);

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kGold,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  'MFH',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kOnGold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              AdminBuilder(
                builder: (context, isAdmin) => isAdmin
                    ? Chip(
                        avatar: const Icon(
                          Icons.verified_user,
                          size: 18,
                          color: kPrimary,
                        ),
                        label: Text(t('admin_badge')),
                        backgroundColor: const Color(0x33D4B05A),
                        side: BorderSide.none,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            t('welcome'),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            t('tagline'),
            style: const TextStyle(fontSize: 16, color: kMuted),
          ),
          if (email.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              '${t('signed_in_as')}: $email',
              style: const TextStyle(fontSize: 13, color: kMuted),
            ),
          ],
          const SizedBox(height: 26),
          Text(
            t('summary'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _statStream(
                  stream: _members,
                  icon: Icons.people,
                  label: t('stat_members'),
                  value: (docs) => '${docs.length}',
                  tab: 1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statStream(
                  stream: _news,
                  icon: Icons.campaign,
                  label: t('stat_news'),
                  value: (docs) => '${docs.length}',
                  tab: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _statStream(
            stream: _contribs,
            icon: Icons.volunteer_activism,
            label: t('stat_contrib'),
            value: (docs) => formatMoney(sumAmount(docs)),
            tab: 2,
          ),
          const SizedBox(height: 26),
          Text(
            t('latest_news'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _news,
            builder: (context, snap) {
              final docs = snap.data?.docs ?? [];
              if (docs.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: _cardDecoration(),
                  child: Text(
                    t('no_news'),
                    style: const TextStyle(color: kMuted),
                  ),
                );
              }
              final d = docs.first.data();
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => widget.onOpenTab(3),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: _cardDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (d['title'] ?? '') as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        (d['body'] ?? '') as String,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatDate(d['createdAt'] as Timestamp?),
                        style: const TextStyle(
                          fontSize: 12,
                          color: kMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kLine),
      );

  Widget _statStream({
    required Stream<QuerySnapshot<Map<String, dynamic>>> stream,
    required IconData icon,
    required String label,
    required String Function(Docs docs) value,
    required int tab,
  }) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snap) {
        final text = snap.hasData ? value(snap.data!.docs) : '...';
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => widget.onOpenTab(tab),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: kPrimary),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(label),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// WANAFAMILIA / MEMBERS
// ============================================================

class MembersPage extends StatelessWidget {
  MembersPage({super.key});

  final CollectionReference<Map<String, dynamic>> _col =
      FirebaseFirestore.instance.collection('members');

  Future<void> _addMember(BuildContext context) async {
    final nameCtrl = TextEditingController();
    final relationCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t('add_member')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: t('name')),
                textCapitalization: TextCapitalization.words,
              ),
              TextField(
                controller: relationCtrl,
                decoration: InputDecoration(labelText: t('relation')),
                textCapitalization: TextCapitalization.words,
              ),
              TextField(
                controller: phoneCtrl,
                decoration: InputDecoration(labelText: t('phone')),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t('cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t('save')),
          ),
        ],
      ),
    );

    if (result == true && nameCtrl.text.trim().isNotEmpty) {
      await _col.add({
        'name': nameCtrl.text.trim(),
        'relation': relationCtrl.text.trim().isEmpty
            ? t('default_relation')
            : relationCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminBuilder(
      builder: (context, isAdmin) => Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton:
            isAdmin ? addButton(() => _addMember(context), Icons.person_add) : null,
        body: CollectionBuilder(
          collection: 'members',
          builder: (context, docs) {
            if (docs.isEmpty) {
              return emptyState(Icons.people, t('no_members'));
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: docs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final doc = docs[i];
                final d = doc.data();
                final name = (d['name'] ?? '') as String;
                final relation = (d['relation'] ?? '') as String;
                final phone = (d['phone'] ?? '') as String;
                return FamilyCard(
                  id: doc.id,
                  canDelete: isAdmin,
                  onDelete: () => doc.reference.delete(),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kPrimary,
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                        style: const TextStyle(color: kOnGold),
                      ),
                    ),
                    title: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      phone.isEmpty ? relation : '$relation • $phone',
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// MICHANGO / CONTRIBUTIONS
// ============================================================

class ContributionsPage extends StatelessWidget {
  ContributionsPage({super.key});

  final CollectionReference<Map<String, dynamic>> _col =
      FirebaseFirestore.instance.collection('contributions');

  Future<void> _addContribution(BuildContext context) async {
    final membersSnap = await FirebaseFirestore.instance
        .collection('members')
        .orderBy('createdAt')
        .get();
    final names = membersSnap.docs
        .map((d) => (d.data()['name'] ?? '') as String)
        .toList();

    if (!context.mounted) return;

    if (names.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t('add_members_first'))),
      );
      return;
    }

    String selected = names.first;
    final amountCtrl = TextEditingController();
    final noteCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(t('add_contrib')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selected,
                  decoration: InputDecoration(labelText: t('contributor')),
                  items: names
                      .map((n) => DropdownMenuItem(value: n, child: Text(n)))
                      .toList(),
                  onChanged: (v) => setLocal(() => selected = v ?? selected),
                ),
                TextField(
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: t('amount')),
                ),
                TextField(
                  controller: noteCtrl,
                  decoration: InputDecoration(labelText: t('note_optional')),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(t('cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(t('save')),
            ),
          ],
        ),
      ),
    );

    final amount =
        double.tryParse(amountCtrl.text.trim().replaceAll(',', '')) ?? 0;
    if (result == true && amount > 0) {
      await _col.add({
        'memberName': selected,
        'amount': amount,
        'note': noteCtrl.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminBuilder(
      builder: (context, isAdmin) => Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton:
            isAdmin ? addButton(() => _addContribution(context), Icons.add) : null,
        body: CollectionBuilder(
          collection: 'contributions',
          descending: true,
          builder: (context, docs) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kGold, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t('total_contrib'),
                        style: const TextStyle(color: kMuted),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatMoney(sumAmount(docs)),
                        style: const TextStyle(
                          color: kGold,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${t('contrib_count')}: ${docs.length}',
                        style: const TextStyle(color: kMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  t('who_contributed'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                if (docs.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(child: Text(t('no_contrib'))),
                  ),
                for (final doc in docs) ...[
                  _contributionTile(doc, isAdmin),
                  const SizedBox(height: 10),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _contributionTile(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    bool isAdmin,
  ) {
    final d = doc.data();
    final name = (d['memberName'] ?? '') as String;
    final note = (d['note'] ?? '') as String;
    final amount = ((d['amount'] ?? 0) as num).toDouble();
    final date = formatDate(d['createdAt'] as Timestamp?);

    return FamilyCard(
      id: doc.id,
      canDelete: isAdmin,
      onDelete: () => doc.reference.delete(),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kPrimary,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
            style: const TextStyle(color: kOnGold),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(note.isEmpty ? date : '$date • $note'),
        trailing: Text(
          formatMoney(amount),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimary,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TAARIFA / ANNOUNCEMENTS
// ============================================================

class AnnouncementsPage extends StatelessWidget {
  AnnouncementsPage({super.key});

  final CollectionReference<Map<String, dynamic>> _col =
      FirebaseFirestore.instance.collection('announcements');

  Future<void> _addAnnouncement(BuildContext context) async {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t('add_news')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(labelText: t('news_title')),
                textCapitalization: TextCapitalization.sentences,
              ),
              TextField(
                controller: bodyCtrl,
                decoration: InputDecoration(labelText: t('news_body')),
                textCapitalization: TextCapitalization.sentences,
                minLines: 3,
                maxLines: 6,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t('cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t('save')),
          ),
        ],
      ),
    );

    if (result == true && titleCtrl.text.trim().isNotEmpty) {
      await _col.add({
        'title': titleCtrl.text.trim(),
        'body': bodyCtrl.text.trim(),
        'author': FirebaseAuth.instance.currentUser?.email ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminBuilder(
      builder: (context, isAdmin) => Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: isAdmin
            ? addButton(() => _addAnnouncement(context), Icons.edit)
            : null,
        body: CollectionBuilder(
          collection: 'announcements',
          descending: true,
          builder: (context, docs) {
            if (docs.isEmpty) {
              return emptyState(Icons.campaign, t('no_news'));
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              itemCount: docs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final doc = docs[i];
                final d = doc.data();
                final title = (d['title'] ?? '') as String;
                final body = (d['body'] ?? '') as String;
                final date = formatDate(d['createdAt'] as Timestamp?);
                return FamilyCard(
                  id: doc.id,
                  canDelete: isAdmin,
                  onDelete: () => doc.reference.delete(),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.campaign,
                                color: kPrimary, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (body.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(body),
                        ],
                        const SizedBox(height: 10),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: kMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
