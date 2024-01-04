
void Task1() {
  print('Task 1');
}
void Task2() {
  Duration duration = Duration(seconds: 5);
  Future.delayed(duration,()
  {
    print('Task 2');
  });
}

void Task3() {
  print('Task 3');
}

void Taskall() {
  Task1();
  Task2();
  Task3();
}

void main(){
  Taskall();
}