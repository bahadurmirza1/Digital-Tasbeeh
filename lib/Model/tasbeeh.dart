class Tasbeeh {
  late String tname;
  late int tid, tcount, ttotal;

  Tasbeeh();
  Tasbeeh.fromMap(Map<String, dynamic> mp) {
    tid = mp["tid"];
    tname = mp["tname"];
    tcount = mp["tcount"];
    ttotal = mp["ttotal"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = Map<String, dynamic>();
    //mp["tid"] = tid;
    mp["tname"] = tname;
    mp["tcount"] = tcount;
    mp["ttotal"] = ttotal;
    return mp;
  }
}
