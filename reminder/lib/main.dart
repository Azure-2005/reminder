import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '醒悟',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReminderHomePage(),
    );
  }
}

class ReminderHomePage extends StatefulWidget {
  @override
  _ReminderHomePageState createState() => _ReminderHomePageState();
}

class _ReminderHomePageState extends State<ReminderHomePage> {
  int _selectedIndex = 0;
  
  List<ReminderItem> reminders = [
   //举例提醒事项
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提醒'),
        backgroundColor: Color(0xFFE3F2FD),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // 主页内容
          ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              return ReminderCard(
                reminder: reminders[index],
                onToggle: (bool? value) {
                  setState(() {
                    reminders[index].completed = value ?? false;
                  });
                },
                onDelete: () {
                  setState(() {
                    reminders.removeAt(index);
                  });
                },
              );
            },
          ),
          // 其他页面内容（示例）
          Center(
            child: Text('日历页面'),
          ),
          Center(
            child: Text('设置页面'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 添加新提醒
          _addNewReminder();
        },
        shape: const CircleBorder(),
        child: Icon(Icons.add),
        tooltip: '添加提醒',
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: '计划',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '每日',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '我',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _addNewReminder() {
    // 这里可以跳转到添加提醒页面
    print('添加新提醒');
  }
}

class ReminderItem {
  String title;
  String description;
  String time;
  bool completed;

  ReminderItem({
    required this.title,
    required this.description,
    required this.time,
    required this.completed,
  });
}

class ReminderCard extends StatelessWidget {
  final ReminderItem reminder;
  final Function(bool?) onToggle;
  final Function() onDelete;

  const ReminderCard({
    Key? key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Checkbox(
              value: reminder.completed,
              onChanged: onToggle,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          reminder.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            decoration: reminder.completed ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                      Text(
                        reminder.time,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                          decoration: reminder.completed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    reminder.description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                      decoration: reminder.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}



