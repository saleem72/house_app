//

extension StringSpecific on String {
  String arabicMonth() {
    var temp = replaceAll("يناير", "كانون الثاني");
    temp = temp.replaceAll("فبراير", "شباط");
    temp = temp.replaceAll("مارس", "آذار");
    temp = temp.replaceAll("أبريل", "نيسـان");
    temp = temp.replaceAll("مايو", "أيار");
    temp = temp.replaceAll("يونيو", "حزيران");
    temp = temp.replaceAll("يوليو", "تموز");
    temp = temp.replaceAll("أغسطس", "آب");
    temp = temp.replaceAll("سبتمبر", "أيلول");
    temp = temp.replaceAll("أكتوبر", "تشرين الأول");
    temp = temp.replaceAll("نوفمبر", "تشرين الثاني");
    temp = temp.replaceAll("ديسمبر", "كانون الأول");
    return temp;
  }
}
