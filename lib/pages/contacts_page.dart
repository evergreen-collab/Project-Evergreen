import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

import '../widgets/joy_nest_app_bar.dart';
import '../providers/settings_provider.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts = [];
  bool _permissionDenied = false;
  bool _loaded = false;

  final List<SampleContact> _sampleContacts = const [
    SampleContact(name: 'Jennifer Vengerberg', phone: '+48 555 123 4567'),
    SampleContact(name: 'Bruno Diaz', phone: '+1 555 987 6543'),
    SampleContact(name: 'Gerold Riviera', phone: '+48 555 222 3344'),
    SampleContact(name: 'Jan Ptacek', phone: '+420 555 333 4455'),
  ];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      if (!await FlutterContacts.requestPermission()) {
        setState(() {
          _permissionDenied = true;
          _loaded = true;
        });
        return;
      }
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        _contacts = contacts;
        _loaded = true;
      });
    } catch (e) {
      setState(() {
        _contacts = [];
        _loaded = true;
      });
    }
  }

  void _showCallPopup({Contact? contact, SampleContact? sampleContact}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CallPopup(contact: contact, sampleContact: sampleContact),
    );
  }

  void _showChatPopup({Contact? contact, SampleContact? sampleContact}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ChatPopup(contact: contact, sampleContact: sampleContact),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color sampleIconColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : _permissionDenied
          ? const Center(child: Text('Contacts permission denied'))
          : (_contacts.isEmpty
          ? ListView.builder(
        itemCount: _sampleContacts.length,
        itemBuilder: (context, index) {
          final sample = _sampleContacts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: ContactCard(
              avatar: Icon(Icons.man_2_rounded, size: 56, color: sampleIconColor),
              name: sample.name,
              phone: sample.phone,
              onCall: () => _showCallPopup(sampleContact: sample),
              onChat: () => _showChatPopup(sampleContact: sample),
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          Widget avatar;
          if (contact.photoOrThumbnail != null) {
            avatar = CircleAvatar(
              radius: 36,
              backgroundImage: MemoryImage(contact.photoOrThumbnail!),
              backgroundColor: Colors.grey[700],
            );
          } else {
            avatar = CircleAvatar(
              radius: 36,
              backgroundColor: Colors.grey,
              child: Icon(Icons.man_2_rounded, size: 56, color: sampleIconColor),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: ContactCard(
              avatar: avatar,
              name: contact.displayName,
              phone: contact.phones.isNotEmpty
                  ? contact.phones.first.number
                  : 'No phone number',
              onCall: contact.phones.isNotEmpty
                  ? () => _showCallPopup(contact: contact)
                  : null,
              onChat: () => _showChatPopup(contact: contact),
            ),
          );
        },
      )),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Widget avatar;
  final String name;
  final String phone;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  const ContactCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.phone,
    this.onCall,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(24),
      color: Theme.of(context).cardColor.withAlpha(248),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            avatar,
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha(204),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700]?.withAlpha(242),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                elevation: 4,
              ),
              onPressed: onCall,
              child: const Icon(Icons.phone, size: 36, color: Colors.white),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700]?.withAlpha(242),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                elevation: 4,
              ),
              onPressed: onChat,
              child: const Icon(Icons.chat, size: 32, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CallPopup extends StatelessWidget {
  final Contact? contact;
  final SampleContact? sampleContact;
  const CallPopup({super.key, this.contact, this.sampleContact})
      : assert(contact != null || sampleContact != null);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color sampleIconColor = isDark ? Colors.white : Colors.black;

    final String displayName = contact?.displayName ?? sampleContact?.name ?? '';
    final String? phone =
    contact?.phones.isNotEmpty == true ? contact!.phones.first.number : sampleContact?.phone;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.9),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (contact?.photoOrThumbnail != null)
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(contact!.photoOrThumbnail!),
                      backgroundColor: Colors.grey[700],
                    )
                  else
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.man_2_rounded, size: 60, color: sampleIconColor),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    displayName,
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  if (phone != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: const TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ],
                  const SizedBox(height: 14),
                  const Text('Calling...', style: TextStyle(color: Colors.white70, fontSize: 20)),
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.call_end, size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPopup extends StatelessWidget {
  final Contact? contact;
  final SampleContact? sampleContact;
  const ChatPopup({super.key, this.contact, this.sampleContact})
      : assert(contact != null || sampleContact != null);

  List<Map<String, String>> get _messages {
    final name = contact?.displayName ?? sampleContact?.name ?? 'Contact';

    if (name == 'Jennifer Vengerberg') {
      return [
        {'from': name, 'text': 'Glad you reached out.'},
        {'from': 'You', 'text': 'Of course. How have you been?'},
        {'from': name, 'text': "I'm good, dear friend. Things have been... interesting, as always."},
        {'from': 'You', 'text': 'That does sound familiar.'},
      ];
    } else if (name == 'Bruno Diaz') {
      return [
        {'from': name, 'text': 'Hey!'},
        {'from': 'You', 'text': 'Hi Bruno, how are things?'},
        {'from': name, 'text': "All good in Gotham!"},
        {'from': 'You', 'text': 'Stay safe out there!'},
      ];
    } else if (name == 'Gerold Riviera') {
      return [
        {'from': name, 'text': 'Caught me just as the wind picked up.'},
        {'from': 'You', 'text': 'Timing, as always.'},
        {'from': name, 'text': "I'm good, wind's howling!"},
        {'from': 'You', 'text': 'Take care out there.'},
      ];
    } else if (name == 'Jan Ptacek') {
      return [
        {'from': name, 'text': 'Hey, always happy to see your message!'},
        {'from': 'You', 'text': 'Hi Jan! How are you holding up?'},
        {'from': name, 'text': "I'm good, Henry saved me again! You know how it is."},
        {'from': 'You', 'text': 'Haha, Henry to the rescue as always!'},
      ];
    } else {
      return [
        {'from': name, 'text': 'Hi there!'},
        {'from': 'You', 'text': 'Hello! How are you?'},
        {'from': name, 'text': "I'm good, thank you!"},
        {'from': 'You', 'text': 'Glad to hear!'},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color sampleIconColor = isDark ? Colors.white : Colors.black;

    final String displayName = contact?.displayName ?? sampleContact?.name ?? '';

    final Size screen = MediaQuery.of(context).size;
    final double dialogWidth = screen.width * 0.85;
    final double dialogHeight = screen.height * 0.75;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          width: dialogWidth,
          height: dialogHeight,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      if (contact?.photoOrThumbnail != null)
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: MemoryImage(contact!.photoOrThumbnail!),
                          backgroundColor: Colors.grey[700],
                        )
                      else
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.man_2_rounded, size: 56, color: sampleIconColor),
                        ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Text(
                          displayName,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, idx) {
                        final msg = _messages[idx];
                        final isMe = msg['from'] == 'You';
                        return Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? (isDark ? Colors.blue[900] : Colors.blue[200])
                                  : (isDark ? Colors.grey[800] : Colors.grey[300]),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Text(
                              msg['text']!,
                              style: TextStyle(
                                color: isMe
                                    ? Colors.white
                                    : (isDark ? Colors.white70 : Colors.black87),
                                fontSize: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(fontSize: 28, color: Colors.grey[500]),
                            filled: true,
                            fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
                          ),
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.grey[400], size: 44),
                        onPressed: null, // Disabled for demo/filler
                        iconSize: 44,
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 48),
                  color: isDark ? Colors.white : Colors.black,
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close chat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleContact {
  final String name;
  final String phone;
  const SampleContact({required this.name, required this.phone});
}
